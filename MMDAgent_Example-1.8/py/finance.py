#クジラ飛行机氏 『Pythonによるスクレイピング&機械学習 開発テクニック』
#よりサンプルプログラム ch2 everyday-kawase.py より引用.

import time
import pyautogui as pgui

#Finance Data Inport
from bs4 import BeautifulSoup

import urllib.request as req

# HTMLを取得
url = "https://stocks.finance.yahoo.co.jp/stocks/detail/?code=usdjpy"
res = req.urlopen(url)

# HTMLを解析
soup = BeautifulSoup(res, "html.parser")

# 任意のデータを抽出 --- (※1)
price = soup.select_one(".stoksPrice").string


#Click MMDAgent
pgui.click(10,10)

#File Over Write
in_file_name  = "MMDAgent_Example.fst"

#Rewrite1
with open(in_file_name, encoding='utf-8') as f:
    data_lines = f.read()


data_lines = data_lines.replace("???????????", price)


with open(in_file_name, mode="w", encoding='utf-8') as f:
    f.write(data_lines)

#Rewrite2
with open(in_file_name, encoding='utf-8') as f:
    data_lines = f.read()


data_lines = data_lines.replace("16   2     <eps>                               KEY_POST|MMDAgent|F|OFF", "16   2     <eps>     <esp>")


with open(in_file_name, mode="w", encoding='utf-8') as f:
    f.write(data_lines)

#Wait
time.sleep(6)

#Send Command to MMDAgent
pgui.typewrite('2')

#Retrieve1
with open(in_file_name, encoding='utf-8') as f:
    data_lines = f.read()


data_lines = data_lines.replace(price, "???????????")


with open(in_file_name, mode="w", encoding='utf-8') as f:
    f.write(data_lines)

#Retrieve2
with open(in_file_name, encoding='utf-8') as f:
    data_lines = f.read()


data_lines = data_lines.replace("16   2     <eps>     <esp>", "16   2     <eps>                               KEY_POST|MMDAgent|F|OFF")


with open(in_file_name, mode="w", encoding='utf-8') as f:
    f.write(data_lines)
