# WEBサイト 『pythonでディープラーニング（機械学習）』より
# 『Pythonで天気APIを使って天気の情報を取得する方法』 から
# (URL: https://python.blueskyzz.com/python/post-138/)から引用

import requests
import time
import pyautogui as pgui

#Weather Data Inport
url = 'http://weather.livedoor.com/forecast/webservice/json/v1'
payload = {'city' : '130010'}
data = requests.get(url, params=payload).json()

weather = data['forecasts'][0]['telop']

#Click MMDAgent
pgui.click(10,10)

#File Over Write
in_file_name  = "MMDAgent_Example.fst"

#Rewrite1
with open(in_file_name, encoding='utf-8') as f:
    data_lines = f.read()


data_lines = data_lines.replace("??????????", weather)


with open(in_file_name, mode="w", encoding='utf-8') as f:
    f.write(data_lines)

#Rewrite2
with open(in_file_name, encoding='utf-8') as f:
    data_lines = f.read()


data_lines = data_lines.replace("16   2     <eps>                               KEY_POST|MMDAgent|F|OFF", "16   2     <eps>     <esp>")


with open(in_file_name, mode="w", encoding='utf-8') as f:
    f.write(data_lines)

#Wait
time.sleep(5)

#Send Command to MMDAgent
pgui.typewrite('1')

#Retrieve1
with open(in_file_name, encoding='utf-8') as f:
    data_lines = f.read()


data_lines = data_lines.replace(weather, "??????????")


with open(in_file_name, mode="w", encoding='utf-8') as f:
    f.write(data_lines)

#Retrieve2
with open(in_file_name, encoding='utf-8') as f:
    data_lines = f.read()


data_lines = data_lines.replace("16   2     <eps>     <esp>", "16   2     <eps>                               KEY_POST|MMDAgent|F|OFF")


with open(in_file_name, mode="w", encoding='utf-8') as f:
    f.write(data_lines)
