import codecs
import datetime
import time
import pyautogui as pgui
import os

BusInfo = "申し訳ありません。情報の取得に失敗しました。"

#File Over Write
in_file_name  = "MMDAgent_Example.fst"

#Click MMDAgent ---
pgui.click(10,10)

#func stat ---
def file_ReWrite(scripts):
    
    #Rewrite1
    with open(in_file_name, encoding='utf-8') as f:
        data_lines = f.read()

    data_lines = data_lines.replace("???????????????", scripts)

    with open(in_file_name, mode="w", encoding='utf-8') as f:
        f.write(data_lines)
        
    #Rewrite2
    with open(in_file_name, encoding='utf-8') as f:
        data_lines = f.read()
            
    data_lines = data_lines.replace("16   2     <eps>                               KEY_POST|MMDAgent|F|OFF", "16   2     <eps>     <esp>")

    with open(in_file_name, mode="w", encoding='utf-8') as f:
        f.write(data_lines)

    PRG_Wait()


def file_Retrieve(scripts):

    #Retrieve1
    with open(in_file_name, encoding='utf-8') as f:
        data_lines = f.read()

    data_lines = data_lines.replace(scripts, "???????????????")

    with open(in_file_name, mode="w", encoding='utf-8') as f:
        f.write(data_lines)

    #Retrieve2
    with open(in_file_name, encoding='utf-8') as f:
        data_lines = f.read()

    data_lines = data_lines.replace("16   2     <eps>     <esp>", "16   2     <eps>                               KEY_POST|MMDAgent|F|OFF")

    with open(in_file_name, mode="w", encoding='utf-8') as f:
        f.write(data_lines)


def PRG_Wait():
    #Wait
    time.sleep(18)

    #Send Command to MMDAgent
    pgui.typewrite('4')
    

def main():
    # MMDAgentからEXCUTEさせる場合、MMDAgentのディレクトリからパスが参照されていくので、相対パスのときは記述に注意!
    filename = "./py/csv/time_table.csv"
    csv = codecs.open(filename, "r", "utf-8").read()

    data = []
    rows = csv.split("\r\n")
    for row in rows:
        if row == "": continue
        cells = row.split(",")
        data.append(cells)

    # get time
    now = datetime.datetime.now()

    # holiday check
    if   now.weekday() == 5 or (now.weekday() == 6 and now.hour < int(data[0][0])) or (now.weekday() == 6 and now.hour == int(data[0][0]) and now.minute <= int(data[0][1])):
        BusInfo = "本日は休日のため、連絡バスの運行はありません。"

    # Friday Check
    elif now.weekday() == 4 and now.hour >= int(data[len(data) -1][0]) and now.minute >= int(data[len(data) -1][len(data[len(data) - 1]) -1]):
        BusInfo = "本日の連絡バスの運行は、終了したようです。明日は休日のため、連絡バスの運行はありません。"

    # Sunday Check
    elif (now.weekday() == 6 and now.hour > int(data[0][0])) or (now.weekday() == 6 and now.hour == int(data[0][0]) and now.minute > int(data[0][1])):
        BusInfo = "本日は休日のため、連絡バスの運行はありません。次のバスは、明日、" + data[0][0] + "時、" + data[0][1] + "分に出発予定です。"

    # weekday
    else:
        hour = now.hour
        minu = now.minute

        # CSV形式でインポートすると、各セルはstr型になるので、intなどに変換しなければ正しく評価されなくなるので注意
        # 0時以降は、こっちに入る
        for i in range(0, len(data)):

            #!!"data" should be convered STR to INT!! for eval at if
            if int(data[i][0]) >= hour or hour > int(data[len(data) -1][0]):

                # Search Minutes
                # カラム(列)の要素数を取り出すには、タプル(行)を指定してその行のlenを求める。
                # つまり、1行目の列の要素数を取り出したければ、len(data[0])
                # pyでは、data[]でその行のすべてのセル取り出し、data[][]で行列特定のセルを取り出す。
                for j in range(1, len(data[i])):

                    # 通常に次のバスを探す or 0～始発まで or 最終～23時まで
                    if  int(data[i][j]) > minu or int(data[i][0]) > hour or hour > int(data[len(data) -1][0]):
                        BusInfo = "次のバスは、" + data[i][0] + "時、" + data[i][j] + "分に出発予定です。"

                        # left calc
                        if   int(data[i][j]) - minu <= 1 and int(data[i][0]) == hour:
                            BusInfo += "あと1分以内に出発します。次のバスもあわせてご利用ください。"
                        elif int(data[i][j]) - minu <= 3 and int(data[i][0]) == hour:
                            BusInfo += "あと3分以内に出発します。お急ぎください!お気をつけて。"
                        elif int(data[i][j]) - minu <= 5 and int(data[i][0]) == hour:
                            BusInfo += "あと5分以内に出発します。バス停へのご移動をお願いします。"
                        
                        break

                    # 次の時間で一本目のバスを探す elifであることが重要
                    elif j == len(data[i]) - 1 :
                        # 18時台で最終バスを逃したときは、始発を表示
                        if hour >= int(data[len(data) -1][0]):
                            BusInfo = "最終バスを逃しました。次のバスは、始発、" + data[0][0] + "時、" + data[0][1] + "分の出発予定です。"

                        # 17時台など、運行のない時間帯をパスするためのloop
                        else:
                            for k in range(i + 1, len(data)):
                                if int(data[k][1]) >= 0:
                                    BusInfo = "次のバスは、" + data[k][0] + "時、" + data[k][1] + "分に出発予定です。"

                                    # left calc
                                    if   int(data[k][1]) + (60 - minu) <= 1:
                                        BusInfo += "あと1分以内に出発します。次のバスもあわせてご利用ください。"
                                    elif int(data[k][1]) + (60 - minu) <= 3:
                                        BusInfo += "あと3分以内に出発します。お急ぎください!お気をつけて。"
                                    elif int(data[k][1]) + (60 - minu) <= 5:
                                        BusInfo += "あと5分以内に出発します。バス停へのご移動をお願いします。"
                                    
                                    break

                #１便のみを探す
                break
    #Debug
    print(BusInfo)
    return BusInfo


#EXCT
desc = main()

file_ReWrite(desc)
file_Retrieve(desc)

