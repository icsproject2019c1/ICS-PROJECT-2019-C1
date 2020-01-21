import time
import pyautogui as pgui

#Click MMDAgent ---
pgui.click(10,10)

screen = 2
time.sleep(2)
i = 0

while True:
    #Wait
    i = i + 1

    if   i == 1:
        pgui.typewrite(';')
        time.sleep(5)

    elif i == 2:
        pgui.typewrite(':')
        time.sleep(5)

    else:
        i = 0
        

    

    

    
