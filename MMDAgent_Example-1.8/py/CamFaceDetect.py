#クジラ飛行机氏 『OpenCVで監視カメラを自作してみよう』
#(URL: https://news.mynavi.jp/article/zeropython-35/) より引用.

import cv2
import sys
import random

import time
import pyautogui as pgui

import os
import shutil

# 保存パスの指定
save_path = "./py/dump/"

def init():

    #Click MMDAgent ---
    pgui.click(10,10)

    # MMDAgentを待つ
    time.sleep(1)
    os.makedirs(save_path, exist_ok=True)
    dir_del()

    # main()を呼び出す
    main()
    

def main():
    # カメラのキャプチャを開始
    cam = cv2.VideoCapture(0)
    
    # フレームの初期化 --- (*1)
    img1 = img2 = img3 = get_image(cam)
    
    # 動きの閾値
    th = 50
    num = 1

    # While
    while True:
        # ESPキーが押されたら終了
        if cv2.waitKey(1) == 27: break

        # 差分を調べる --- (*2)
        diff = check_image(img1, img2, img3)
        
        # 差分がthの値以上なら動きがあったと判定 --- (*3)
        cnt = cv2.countNonZero(diff)

        # 動きの判定
        if cnt > th:
            print("カメラに動きを検出")
            #cv2.imshow('PUSH ENTER KEY', img3)
            
            # 写真を保存 --- (*4)
            file_name = save_path + str(num) + ".jpg"
            cv2.imwrite(file_name, img3)
            num += 1

            #保存された画像が顔を含んでいるか判定        
            if   detect_human(file_name) == "face" :
                print("face detected.")
                type_random("face")
                time.sleep(8)
            elif detect_human(file_name) == "body" :
                print("body detected.")
                type_random("body")
                time.sleep(8)
            else                                   :
                print("no human.")

        else:
            cv2.imshow('PUSH ENTER KEY', diff)
            
        
        # 比較用の画像を保存 --- (*5)
        img1, img2, img3 = (img2, img3, get_image(cam))

        # FPSを下げる
        time.sleep(0.5)
        
    # 後始末
    cam.release()
    cv2.destroyAllWindows() 

#顔検出
def detect_human(image_file):

    # カスケードファイルのパスを指定 --- (※1)
    cascade_face_file = "./py/xml/haarcascade_frontalface_alt.xml"
    cascade_body_file = "./py/xml/haarcascade_fullbody.xml"

    # 画像の読み込み --- (※2)
    image = cv2.imread(image_file)

    # グレースケールに変換
    image_gs = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

    # 顔認識用特徴量ファイルを読み込む --- (※3)
    cascade_face = cv2.CascadeClassifier(cascade_face_file)
    cascade_body = cv2.CascadeClassifier(cascade_body_file)
    
    # 顔認識の実行
    face_list = cascade_face.detectMultiScale(image_gs,
                scaleFactor=1.1,
                minNeighbors=1,
                minSize=(150,150))

    body_list = cascade_body.detectMultiScale(image_gs,
                scaleFactor=1.1,
                minNeighbors=1,
                minSize=(150,150))

    if   len(face_list) > 0: return "face"

    elif len(body_list) > 0: return "body"
    
    else                   : return False

# 画像に動きがあったか調べる関数
def check_image(img1, img2, img3):
    # グレイスケール画像に変換 --- (*6)
    gray1 = cv2.cvtColor(img1, cv2.COLOR_RGB2GRAY)
    gray2 = cv2.cvtColor(img2, cv2.COLOR_RGB2GRAY)
    gray3 = cv2.cvtColor(img3, cv2.COLOR_RGB2GRAY)
    # 絶対差分を調べる --- (*7)
    diff1 = cv2.absdiff(gray1, gray2)
    diff2 = cv2.absdiff(gray2, gray3)
    # 論理積を調べる --- (*8)
    diff_and = cv2.bitwise_and(diff1, diff2)
    # 白黒二値化 --- (*9)
    _, diff_wb = cv2.threshold(diff_and, 30, 255, cv2.THRESH_BINARY)
    # ノイズの除去 --- (*10)
    diff = cv2.medianBlur(diff_wb, 5)
    return diff

# カメラから画像を取得する
def get_image(cam):
    img = cam.read()[1]
    img = cv2.resize(img, (600, 400))
    return img

def type_random(mode):
    if mode == "body":
        pgui.typewrite('[')
        
    x = random.randrange(140)

    if mode == "face":
        if    0 <= x and x < 10:
            pgui.typewrite('e')

        elif 10 <= x and x < 20:
            pgui.typewrite('o')

        elif 20 <= x and x < 30:
            pgui.typewrite('o')
            
        elif 30 <= x and x < 40:
            pgui.typewrite('r')

        elif 40 <= x and x < 50:
            pgui.typewrite('t')

        elif 50 <= x and x < 60:
            pgui.typewrite('y')

        elif 60 <= x and x < 70:
            pgui.typewrite('u')

        elif 70 <= x and x < 80:
            pgui.typewrite('i')

        elif 80 <= x and x < 90:
            pgui.typewrite('o')

        elif 90 <= x and x < 100:
            pgui.typewrite('p')

        elif 100 <= x and x < 110:
            pgui.typewrite('@')

        elif 110 <= x and x < 140:
            pgui.typewrite('[')

def dir_del():
    # 前回使用していた画像を消去
    shutil.rmtree(save_path)
    os.mkdir(save_path)
    print("files cleaned up -------------")

# Main関数相当を Python で呼び出すときは、
# その関数は一番下に置かなければならない。(def より上に書いてはならない)
# Init
init()
