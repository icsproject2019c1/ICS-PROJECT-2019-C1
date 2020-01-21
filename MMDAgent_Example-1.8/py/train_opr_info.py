import time
import pyautogui as pgui

#Train OPR Data Inport
from bs4 import BeautifulSoup 
import urllib.request as req

#File Name
in_file_name  = "MMDAgent_Example.fst"

#func stat ---
def file_ReWrite(trainInfo):
    
    #Rewrite1
    with open(in_file_name, encoding='utf-8') as f:
        data_lines = f.read()

    data_lines = data_lines.replace("????????????", trainInfo)

    with open(in_file_name, mode="w", encoding='utf-8') as f:
        f.write(data_lines)
        
    #Rewrite2
    with open(in_file_name, encoding='utf-8') as f:
        data_lines = f.read()
            
    data_lines = data_lines.replace("16   2     <eps>                               KEY_POST|MMDAgent|F|OFF", "16   2     <eps>     <esp>")

    with open(in_file_name, mode="w", encoding='utf-8') as f:
        f.write(data_lines)

    PRG_Wait()


def file_Retrieve(trainInfo):

    #Retrieve1
    with open(in_file_name, encoding='utf-8') as f:
        data_lines = f.read()

    data_lines = data_lines.replace(trainInfo, "????????????")

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
    time.sleep(6.8)

    #Send Command to MMDAgent
    pgui.typewrite('3')
    

#func end ---

#URLs ---
url = "https://transit.goo.ne.jp/unkou/train/kantou/"
res = req.urlopen(url)
soup = BeautifulSoup(res, "html.parser")


#Click MMDAgent ---
pgui.click(10,10)

#Register Routes ---
reg_list = {"横浜線", "京浜東北根岸線", "南武線[川崎～立川]", "中央線(快速)[東京～高尾]", "山手線", "八高川越線[八王子～川越]", "京王相模原線", "京王線" ,"小田急小田原線", "小田急江ノ島線", "小田急多摩線", "東急田園都市線"}

#Get Designated Data ---
#Get Route Name
name_list  = soup.select("ul.traininfo a")
#Get Status Att
sts_list   = soup.select(".status")

#Combine ---
info_list = [name_list, sts_list]

#Variables ---
Info_Cnt  = 0
send_line = "只今、日野キャンパス周辺の鉄道は、すべて、ほぼ平常通りに運行しているようです"
scr = ''

#Print ---
for i in range(0, len(name_list)):
    
    #Make Info Sentence
    if info_list[1][i].string != "その他":
        
        for reg in reg_list:
            if Info_Cnt >= 7:
                send_line = "日野キャンパス周辺の多くの路線で、ダイヤが乱れているようです。ご利用の際は、ご注意ください"
                
            elif reg == info_list[0][i].string:
                
                #is Second Info?
                if Info_Cnt == 0:
                    send_line = info_list[0][i].string
                    Info_Cnt += 1
                    
                #If this Info is a Second Info, add some words
                else:
                    send_line = "、" + info_list[0][i].string
                    Info_Cnt += 1
                
                #Merge send_line and Make Script
                scr = scr + send_line


#Add Concl words
if Info_Cnt != 0 or Info_Cnt < 7:
    scr = scr + "は、ダイヤが乱れているようです。ご利用の際は、ご注意ください"
        
#If No Info ---    
if Info_Cnt == 0 or Info_Cnt >= 7:
    file_ReWrite(send_line)
    file_Retrieve(send_line)

else:
    file_ReWrite(scr)
    file_Retrieve(scr)
