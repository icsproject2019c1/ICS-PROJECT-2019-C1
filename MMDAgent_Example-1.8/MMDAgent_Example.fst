# ----------------------------------------------------------------- #
#           MMDAgent "Sample Script"                                #
#           released by MMDAgent Project Team                       #
#           http://www.mmdagent.jp/                                 #
# ----------------------------------------------------------------- #
#                                                                   #
#  Copyright (c) 2009-2015  Nagoya Institute of Technology          #
#                           Department of Computer Science          #
#                                                                   #
# Some rights reserved.                                             #
#                                                                   #
# This work is licensed under the Creative Commons Attribution 3.0  #
# license.                                                          #
#                                                                   #
# You are free:                                                     #
#  * to Share - to copy, distribute and transmit the work           #
#  * to Remix - to adapt the work                                   #
# Under the following conditions:                                   #
#  * Attribution - You must attribute the work in the manner        #
#    specified by the author or licensor (but not in any way that   #
#    suggests that they endorse you or your use of the work).       #
# With the understanding that:                                      #
#  * Waiver - Any of the above conditions can be waived if you get  #
#    permission from the copyright holder.                          #
#  * Public Domain - Where the work or any of its elements is in    #
#    the public domain under applicable law, that status is in no   #
#    way affected by the license.                                   #
#  * Other Rights - In no way are any of the following rights       #
#    affected by the license:                                       #
#     - Your fair dealing or fair use rights, or other applicable   #
#       copyright exceptions and limitations;                       #
#     - The author's moral rights;                                  #
#     - Rights other persons may have either in the work itself or  #
#       in how the work is used, such as publicity or privacy       #
#       rights.                                                     #
#  * Notice - For any reuse or distribution, you must make clear to #
#    others the license terms of this work. The best way to do this #
#    is with a link to this web page.                               #
#                                                                   #
# See http://creativecommons.org/ for details.                      #
# ----------------------------------------------------------------- #

# 1st field: state before transition
# 2nd field: state after transition
# 3rd field: event (input message)
# 4th field: command (output message)
#
# Model
# MODEL_ADD|(model alias)|(model file name)|(x position),(y position),(z position)|(x rotation),(y rotation),(z rotation)|(ON or OFF for cartoon)|(parent model alias)|(parent bone name)
# MODEL_CHANGE|(model alias)|(model file name)
# MODEL_DELETE|(model alias)
# MODEL_EVENT_ADD|(model alias)
# MODEL_EVENT_CHANGE|(model alias)
# MODEL_EVENT_DELETE|(model alias)
#
# Motion
# MOTION_ADD|(model alias)|(motion alias)|(motion file name)|(FULL or PART)|(ONCE or LOOP)|(ON or OFF for smooth)|(ON or OFF for repos)
# MOTION_ACCELERATE|(model alias)|(motion alias)|(speed)|(duration)|(specified time for end)
# MOTION_CHANGE|(model alias)|(motion alias)|(motion file name)
# MOTION_DELETE|(mpdel alias)|(motion alias)
# MOTION_EVENT_ADD|(model alias)|(motion alias)
# MOTION_EVENT_ACCELERATE|(model alias)|(motion alias)
# MOTION_EVENT_CHANGE|(model alias)|(motion alias)
# MOTION_EVENT_DELETE|(model alias)|(motion alias)
#
# Move and Rotate
# MOVE_START|(model alias)|(x position),(y position),(z position)|(GLOBAL or LOCAL position)|(move speed)
# MOVE_STOP|(model alias)
# MOVE_EVENT_START|(model alias)
# MOVE_EVENT_STOP|(model alias)
# TURN_START|(model alias)|(x position),(y position),(z position)|(GLOBAL or LOCAL position)|(rotation speed)
# TURN_STOP|(model alias)
# TURN_EVENT_START|(model alias)
# TURN_EVENT_STOP|(model alias)
# ROTATE_START|(model alias)|(x rotation),(y rotaion),(z rotation)|(GLOBAL or LOCAL rotation)|(rotation speed)
# ROTATE_STOP|(model alias)
# ROTATE_EVENT_START|(model alias)
# ROTATE_EVENT_STOP|(model alias)
#
# Sound
# SOUND_START|(sound alias)|(sound file name)
# SOUND_STOP|(sound alias)
# SOUND_EVENT_START|(sound alias)
# SOUND_EVENT_STOP|(sound alias)
#
# Stage
# STAGE|(stage file name)
# STAGE|(bitmap file name for floor),(bitmap file name for background)
#
# Light
# LIGHTCOLOR|(red),(green),(blue)
# LIGHTDIRECTION|(x position),(y position),(z position)
#
# Camera
# CAMERA|(x position),(y position),(z position)|(x rotation),(y rotation),(z rotation)|(distance)|(fovy)|(time)
# CAMERA|(motion file name)
#
# Speech recognition
# RECOG_EVENT_START
# RECOG_EVENT_STOP|(word sequence)
# RECOG_MODIFY|GAIN|(ratio)
# RECOG_MODIFY|USERDICT_SET|(dictionary file name)
# RECOG_MODIFY|USERDICT_UNSET
# RECOG_MODIFY|CHANGE_CONF|(config file name)
#
# Speech synthesis
# SYNTH_START|(model alias)|(voice alias)|(synthesized text)
# SYNTH_STOP|(model alias)
# SYNTH_EVENT_START|(model alias)
# SYNTH_EVENT_STOP|(model alias)
# LIPSYNC_START|(model alias)|(phoneme and millisecond pair sequence)
# LIPSYNC_STOP|(model alias)
# LIPSYNC_EVENT_START|(model alias)
# LIPSYNC_EVENT_STOP|(model alias)
#
# Variable
# VALUE_SET|(variable alias)|(value)
# VALUE_SET|(variable alias)|(minimum value for random)|(maximum value for random)
# VALUE_UNSET|(variable alias)
# VALUE_EVAL|(variable alias)|(EQ or NE or LE or LT or GE or GT for evaluation)|(value)
# VALUE_EVENT_SET|(variable alias)
# VALUE_EVENT_UNSET|(variable alias)
# VALUE_EVENT_EVAL|(variable alias)|(EQ or NE or LE or LT or GE or GT for evaluation)|(value)|(TRUE or FALSE)
# TIMER_START|(count down alias)|(value)
# TIMER_STOP|(count down alias)
# TIMER_EVENT_START|(count down alias)
# TIMER_EVENT_STOP|(count down alias)
#
# Plugin
# PLUGIN_ENABLE|(plugin name)
# PLUGIN_DISABLE|(plugin name)
# PLUGIN_EVENT_ENABLE|(plugin name)
# PLUGIN_EVENT_DISABLE|(plugin name)
#
# Other events
# DRAGANDDROP|(file name)
# KEY|(key name)
#
# Other commands
# EXECUTE|(file name)
# KEY_POST|(window class name)|(key name)|(ON or OFF for shift-key)|(ON or OFF for ctrl-key)|(On or OFF for alt-key)

# 0011-0020 Initialization

0   12     <eps>                               MODEL_ADD|mei|Model\mei\mei.pmd|20.0,0.0,-14.0
12   13   <eps>                               MODEL_ADD|menu|Accessory\menu\menu.pmd|0.0,-4.5,0.0|0.0,0.0,0.0|ON|mei
13   14   <eps>                               MOTION_ADD|menu|rotate|Motion\menu_rotation\menu_rotation.vmd|FULL|LOOP|OFF|OFF
14   15   <eps>                               STAGE|Stage\building2\floor.bmp,Stage\building2\background.bmp
15   16   <eps>                               MOTION_ADD|mei|base|Motion\mei_wait\mei_wait.vmd|FULL|LOOP|ON|OFF
16   2     <eps>                               KEY_POST|MMDAgent|F|OFF

# 0021-0030 Idle behavior

2    21   <eps>                               TIMER_START|idle1|20
21   22   TIMER_EVENT_START|idle1             TIMER_START|idle2|40
22   23   TIMER_EVENT_START|idle2             TIMER_START|idle3|60
23   1    TIMER_EVENT_START|idle3             VALUE_SET|random|0|100
1    1    RECOG_EVENT_START                   MOTION_ADD|mei|listen|Expression\mei_listen\mei_listen.vmd|PART|ONCE
1    1    TIMER_EVENT_STOP|idle1              MOTION_ADD|mei|idle|Motion\mei_idle\mei_idle_boredom.vmd|PART|ONCE
1    1    TIMER_EVENT_STOP|idle2              MOTION_ADD|mei|idle|Motion\mei_idle\mei_idle_yawn.vmd|PART|ONCE
1    2    TIMER_EVENT_STOP|idle3              MOTION_ADD|mei|idle|Motion\mei_idle\mei_idle_think.vmd|PART|ONCE

# 0031-0040 Hello

1    31   RECOG_EVENT_STOP|こんにちは         TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
31   32  TEXTAREA_EVENT_ADD|K                TEXTAREA_SET|K|こんにちは
32   33  TEXTAREA_EVENT_SET|K                SYNTH_START|mei|mei_voice_normal|こんにちは。
1    31   RECOG_EVENT_STOP|こんにちわ         TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
31   32  TEXTAREA_EVENT_ADD|K                TEXTAREA_SET|K|こんにちは
32   33  TEXTAREA_EVENT_SET|K                SYNTH_START|mei|mei_voice_normal|こんにちは。
33   34   <eps>                               MOTION_ADD|mei|action|Motion\mei_greeting\mei_greeting.vmd|PART|ONCE
34   2    SYNTH_EVENT_STOP|mei                TEXTAREA_DELETE|K

# 0041-0050 Self introduction

1    41   RECOG_EVENT_STOP|自己紹介           TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
41   42  TEXTAREA_EVENT_ADD|K                TEXTAREA_SET|K|メイと言います。
42   43  TEXTAREA_EVENT_SET|K                SYNTH_START|mei|mei_voice_normal|メイと言います。
1    41   RECOG_EVENT_STOP|あなた,誰          TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
41   42  TEXTAREA_EVENT_ADD|K                TEXTAREA_SET|K|メイと言います。
42   43  TEXTAREA_EVENT_SET|K                SYNTH_START|mei|mei_voice_normal|メイと言います。
1    41   RECOG_EVENT_STOP|君,誰              TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
41   42  TEXTAREA_EVENT_ADD|K                TEXTAREA_SET|K|メイと言います。
42   43  TEXTAREA_EVENT_SET|K                SYNTH_START|mei|mei_voice_normal|メイと言います。
43   44   <eps>                               MOTION_ADD|mei|action|Motion\mei_self_introduction\mei_self_introduction.vmd|PART|ONCE
44   45   <eps>                              TEXTAREA_DELETE|K
45   46   SYNTH_EVENT_STOP|mei                TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
46   47  TEXTAREA_EVENT_ADD|K                TEXTAREA_SET|K|よろしくお願いします。
47   48  TEXTAREA_EVENT_SET|K                SYNTH_START|mei|mei_voice_normal|よろしくお願いします。
48   2    SYNTH_EVENT_STOP|mei               TEXTAREA_DELETE|K

# 0051-0060 Thank you

1    51   RECOG_EVENT_STOP|ありがと           TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
51   52  TEXTAREA_EVENT_ADD|K                TEXTAREA_SET|K|どういたしまして。
52   53  TEXTAREA_EVENT_SET|K                SYNTH_START|mei|mei_voice_normal|どういたしまして。
1    51   RECOG_EVENT_STOP|ありがとう         TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
51   52  TEXTAREA_EVENT_ADD|K                TEXTAREA_SET|K|どういたしまして。
52   53  TEXTAREA_EVENT_SET|K                SYNTH_START|mei|mei_voice_normal|どういたしまして。
1    51   RECOG_EVENT_STOP|有難う             TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
51   52  TEXTAREA_EVENT_ADD|K                TEXTAREA_SET|K|どういたしまして。
52   53  TEXTAREA_EVENT_SET|K                SYNTH_START|mei|mei_voice_normal|どういたしまして。
1    51   RECOG_EVENT_STOP|有り難う           TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
51   52  TEXTAREA_EVENT_ADD|K                TEXTAREA_SET|K|どういたしまして。
52   53  TEXTAREA_EVENT_SET|K                SYNTH_START|mei|mei_voice_normal|どういたしまして。
53   54   <eps>                               MOTION_ADD|mei|expression|Expression\mei_happiness\mei_happiness.vmd|PART|ONCE
54   55   SYNTH_EVENT_STOP|mei               TEXTAREA_DELETE|K
55   56   <eps>                              TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
56   57  TEXTAREA_EVENT_ADD|K                TEXTAREA_SET|K|いつでも、話しかけてくださいね。
57   58  TEXTAREA_EVENT_SET|K                SYNTH_START|mei|mei_voice_happy|いつでも、話しかけてくださいね。
58   59   <eps>                               MOTION_CHANGE|mei|base|Motion\mei_guide\mei_guide_happy.vmd
59   60    SYNTH_EVENT_STOP|mei                MOTION_CHANGE|mei|base|Motion\mei_wait\mei_wait.vmd
60   2    <eps>                               TEXTAREA_DELETE|K

# 0061-0070 Positive comments

1    61   RECOG_EVENT_STOP|可愛い             VALUE_EVAL|random|LE|80
1    61   RECOG_EVENT_STOP|かわいい           VALUE_EVAL|random|LE|80
1    61   RECOG_EVENT_STOP|綺麗               VALUE_EVAL|random|LE|80
1    61   RECOG_EVENT_STOP|きれい             VALUE_EVAL|random|LE|80
61   62   VALUE_EVENT_EVAL|random|LE|80|TRUE  TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
62   63   TEXTAREA_EVENT_ADD|K                TEXTAREA_SET|K|恥ずかしいです。
63   64   TEXTAREA_EVENT_SET|K                SYNTH_START|mei|mei_voice_bashful|恥ずかしいです。
61   62   VALUE_EVENT_EVAL|random|LE|80|FALSE TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
62   63   TEXTAREA_EVENT_ADD|K                TEXTAREA_SET|K|ありがとう。
63   64   TEXTAREA_EVENT_SET|K                SYNTH_START|mei|mei_voice_bashful|ありがとう。
64   65   <eps>                               MOTION_ADD|mei|expression|Expression\mei_bashfulness\mei_bashfulness.vmd|PART|ONCE
65   2    SYNTH_EVENT_STOP|mei                TEXTAREA_DELETE|K

# 0071-0090 Guide

1    71   RECOG_EVENT_STOP|図書館             MODEL_DELETE|menu
71   72   <eps>                               MODEL_ADD|panel|Accessory\map\map_library.pmd|0.0,2.8,2.5|0.0,0.0,0.0|ON|mei
72   73   <eps>                               MOTION_ADD|mei|action|Motion\mei_panel\mei_panel_on.vmd|PART|ONCE
73   74   <eps>                               MOTION_CHANGE|mei|base|Motion\mei_guide\mei_guide_normal.vmd
74   75   <eps>                               SYNTH_START|mei|mei_voice_normal|図書館は、正面から見ると、右前の方向にあります。
75   76   SYNTH_EVENT_STOP|mei                MOTION_ADD|mei|look|Motion\mei_look\mei_look_down.vmd|PART|ONCE
76   77   <eps>                               SYNTH_START|mei|mei_voice_normal|キャンパスマップでは、こちらになります。
77   78   <eps>                               MOTION_ADD|mei|action|Motion\mei_point\mei_point_center_buttom.vmd|PART|ONCE
78   79   SYNTH_EVENT_STOP|mei                MOTION_CHANGE|mei|base|Motion\mei_guide\mei_guide_happy.vmd
79   80   <eps>                               SYNTH_START|mei|mei_voice_normal|お解りになりますか？
80   81   SYNTH_EVENT_STOP|mei                MODEL_DELETE|panel
81   82   <eps>                               MODEL_ADD|menu|Accessory\menu\menu.pmd|0.0,-4.5,0.0|0.0,0.0,0.0|ON|mei
82   83   <eps>                               MOTION_CHANGE|mei|base|Motion\mei_wait\mei_wait.vmd
83   2    <eps>                               MOTION_ADD|menu|rotate|Motion\menu_rotation\menu_rotation.vmd|FULL|LOOP|OFF

# 0091-0100 Bye

1    91   RECOG_EVENT_STOP|バイバイ           TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
91   92   TEXTAREA_EVENT_ADD|K               TEXTAREA_SET|K|さようなら。
92   93   TEXTAREA_EVENT_SET|K               SYNTH_START|mei|mei_voice_normal|さようなら。
1    91   RECOG_EVENT_STOP|さようなら         TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
91   92   TEXTAREA_EVENT_ADD|K               TEXTAREA_SET|K|さようなら。
92   93   TEXTAREA_EVENT_SET|K               SYNTH_START|mei|mei_voice_normal|さようなら。
1    91   RECOG_EVENT_STOP|さよなら           TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
91   92   TEXTAREA_EVENT_ADD|K               TEXTAREA_SET|K|さようなら。
92   93   TEXTAREA_EVENT_SET|K               SYNTH_START|mei|mei_voice_normal|さようなら。
93   94   <eps>                               MOTION_ADD|mei|action|Motion\mei_bye\mei_bye.vmd|PART|ONCE
94   2    SYNTH_EVENT_STOP|mei                TEXTAREA_DELETE|K

# 0101-0110 Browsing

1    101  RECOG_EVENT_STOP|ホームページ       EXECUTE|http://www.mmdagent.jp/
1    101  RECOG_EVENT_STOP|ＭＭＤＡｇｅｎｔ   EXECUTE|http://www.mmdagent.jp/
101  102  <eps>                               SYNTH_START|mei|mei_voice_normal|ＭＭＤＡｇｅｎｔの、ホームページを表示します。
102  2    SYNTH_EVENT_STOP|mei                <eps>

# 0111-0120 Screen

# 0121-0130 English example

1    121  RECOG_EVENT_STOP|はじめまして       "SYNTH_START|mei|slt_voice_normal|Hello, nice to meet you."
1    121  RECOG_EVENT_STOP|はじめ             "SYNTH_START|mei|slt_voice_normal|Hello, nice to meet you."
1    121  RECOG_EVENT_STOP|始め               "SYNTH_START|mei|slt_voice_normal|Hello, nice to meet you."
1    121  RECOG_EVENT_STOP|初め               "SYNTH_START|mei|slt_voice_normal|Hello, nice to meet you."
121  2    SYNTH_EVENT_STOP|mei                <eps>

# 0131-0140 Male speech example

1    131  RECOG_EVENT_STOP|男性               MODEL_CHANGE|mei|Model\takumi_parka\takumi_parka.pmd
131  132  MODEL_EVENT_CHANGE|mei              MOTION_CHANGE|mei|base|Motion\takumi_wait\takumi_wait.vmd
132  133  MOTION_EVENT_CHANGE|mei|base        SYNTH_START|mei|takumi_voice_normal|こんにちは、私はタクミです。
133  134  SYNTH_EVENT_STOP|mei                MODEL_CHANGE|mei|Model\mei\mei.pmd
134  135  MODEL_EVENT_CHANGE|mei              MOTION_CHANGE|mei|base|Motion\mei_wait\mei_wait.vmd
135  2    MOTION_EVENT_CHANGE|mei|base        <eps>

#-------------------------------------------------------------------------------------------------------

# 0141-0150 Weather Info and Telling (?: 10)

1      141  RECOG_EVENT_STOP|お天気            EXECUTE|py\ws.py
1      141  RECOG_EVENT_STOP|天気予報          EXECUTE|py\ws.py
1      141  RECOG_EVENT_STOP|天気              EXECUTE|py\ws.py
141    142  <eps>                              TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
142    143   TEXTAREA_EVENT_ADD|K               TEXTAREA_SET|K|本日の東京都の天気をお調べします。少々お待ちください。
143    144   TEXTAREA_EVENT_SET|K               SYNTH_START|mei|mei_voice_normal|本日の東京都の天気をお調べします。少々お待ちください。
144    145  SYNTH_EVENT_STOP|mei               FSTRELOAD|null
145    2    <eps>                              TEXTAREA_DELETE|K

1      146  KEY|1                              TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
146    147   TEXTAREA_EVENT_ADD|K               TEXTAREA_SET|K|本日の東京都の天気は、??????????です。
147    148   TEXTAREA_EVENT_SET|K               SYNTH_START|mei|mei_voice_normal|本日の東京都の天気は、??????????です。
148    2    SYNTH_EVENT_STOP|mei               TEXTAREA_DELETE|K

# 0151-0160 Finance Info and Telling (?: 11)

1      151  RECOG_EVENT_STOP|為替              EXECUTE|py\finance.py
1      151  RECOG_EVENT_STOP|為替,情報          EXECUTE|py\finance.py
151    152  <eps>                              TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
152    153   TEXTAREA_EVENT_ADD|K               TEXTAREA_SET|K|只今の米ドルの為替情報をお調べします。少々お待ちください。
153    154   TEXTAREA_EVENT_SET|K               SYNTH_START|mei|mei_voice_normal|只今の米ドルの為替情報をお調べします。少々お待ちください。
154    155  SYNTH_EVENT_STOP|mei               FSTRELOAD|null
155    2    <eps>                              TEXTAREA_DELETE|K

1      156  KEY|2                              TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
156    157   TEXTAREA_EVENT_ADD|K               TEXTAREA_SET|K|只今の米ドルは、1ドル???????????円です。
157    158   TEXTAREA_EVENT_SET|K              SYNTH_START|mei|mei_voice_normal|只今の米ドルは、1ドル???????????円です。
158    2    SYNTH_EVENT_STOP|mei               TEXTAREA_DELETE|K

# 0161-0170 Train Operation Info and Telling (?: 12)

1      161  RECOG_EVENT_STOP|電車              EXECUTE|py\train_opr_info.py
1      161  RECOG_EVENT_STOP|運行,情報         EXECUTE|py\train_opr_info.py
161    162  <eps>                              TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
162    163   TEXTAREA_EVENT_ADD|K               TEXTAREA_SET|K|日野キャンパス周辺の鉄道の運行状況をお調べします。少々お待ちください。
163    164   TEXTAREA_EVENT_SET|K               SYNTH_START|mei|mei_voice_normal|日野キャンパス周辺の鉄道の運行状況をお調べします。少々お待ちください。
164    165  SYNTH_EVENT_STOP|mei               FSTRELOAD|null
165    2    <eps>                              TEXTAREA_DELETE|K

1      166  KEY|3                              TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
166    167   TEXTAREA_EVENT_ADD|K              TEXTAREA_SET|K|????????????。
167    168   TEXTAREA_EVENT_SET|K              SYNTH_START|mei|mei_voice_normal|????????????。
168    2    SYNTH_EVENT_STOP|mei               TEXTAREA_DELETE|K

# 0171-0175 Face Detection and Speak
1      171 KEY|[                               TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
171    172   TEXTAREA_EVENT_ADD|K              TEXTAREA_SET|K|C1班に投票してね!
172    173   TEXTAREA_EVENT_SET|K              SYNTH_START|mei|mei_voice_bashful|C1班に投票してね!
1      171 KEY|@                               TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
171    172   TEXTAREA_EVENT_ADD|K              TEXTAREA_SET|K|運行情報、と話しかけると、現在の日野キャンパス周辺の鉄道の運行状況をお調べします。
172    173   TEXTAREA_EVENT_SET|K              SYNTH_START|mei|mei_voice_normal|運行情報、と話しかけると、現在の日野キャンパス周辺の鉄道の運行状況をお調べします。
1      171 KEY|p                               TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
171    172   TEXTAREA_EVENT_ADD|K              TEXTAREA_SET|K|お天気、と話しかけると、本日の東京都のお天気をお調べします。
172    173   TEXTAREA_EVENT_SET|K              SYNTH_START|mei|mei_voice_normal|お天気、と話しかけると、本日の東京都のお天気をお調べします。
1      171 KEY|o                               TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
171    172   TEXTAREA_EVENT_ADD|K              TEXTAREA_SET|K|為替情報、と話しかけると、現在の米ドルの為替レートをお調べします。
172    173   TEXTAREA_EVENT_SET|K              SYNTH_START|mei|mei_voice_normal|為替情報、と話しかけると、現在の米ドルの為替レートをお調べします。
1      171 KEY|i                               TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
171    172   TEXTAREA_EVENT_ADD|K              TEXTAREA_SET|K|心理テスト、と話しかけると、心理テストを行いますよ!
172    173   TEXTAREA_EVENT_SET|K              SYNTH_START|mei|mei_voice_normal|心理テスト、と話しかけると、心理テストを行いますよ!
1      171 KEY|u                               TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
171    172   TEXTAREA_EVENT_ADD|K              TEXTAREA_SET|K|におい、と話しかけると、口臭チェックをしますよ!
172    173   TEXTAREA_EVENT_SET|K              SYNTH_START|mei|mei_voice_normal|におい、と話しかけると、口臭チェックをしますよ!
1      171 KEY|y                               TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
171    172   TEXTAREA_EVENT_ADD|K              TEXTAREA_SET|K|音楽、と話しかけると、今の雰囲気にあった曲を流しますよ!
172    173   TEXTAREA_EVENT_SET|K              SYNTH_START|mei|mei_voice_normal|音楽、と話しかけると、今の雰囲気にあった曲を流しますよ!
1      171 KEY|t                               TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
171    172   TEXTAREA_EVENT_ADD|K              TEXTAREA_SET|K|こんにちは。良かったら、お話しませんか?
172    173   TEXTAREA_EVENT_SET|K              SYNTH_START|mei|mei_voice_normal|こんにちは。良かったら、お話しませんか?
1      171 KEY|r                               TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
171    172   TEXTAREA_EVENT_ADD|K              TEXTAREA_SET|K|こんにちは。良かったら、お話しませんか?
172    173   TEXTAREA_EVENT_SET|K              SYNTH_START|mei|mei_voice_normal|こんにちは。良かったら、お話しませんか?
1      171 KEY|e                               TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
171    172   TEXTAREA_EVENT_ADD|K              TEXTAREA_SET|K|こんにちは。良かったら、お話しませんか?
172    173   TEXTAREA_EVENT_SET|K              SYNTH_START|mei|mei_voice_normal|こんにちは。良かったら、お話しませんか?
173    2    SYNTH_EVENT_STOP|mei               TEXTAREA_DELETE|K
# Init CamFaceDetect.py
1      2     KEY|c                                EXECUTE|py\CamFaceDetect.py
1      2     KEY|v                                EXECUTE|py\backgroundChange.py

# 0176-0180 Bus Operation Info and Telling (?: 12)

1      176  RECOG_EVENT_STOP|日の,              EXECUTE|py\bus.py
1      176  RECOG_EVENT_STOP|バス               EXECUTE|py\bus.py
176    177  <eps>                            TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
177    178   TEXTAREA_EVENT_ADD|K               TEXTAREA_SET|K|次の日野、南大沢間連絡バスが出発する時間を臨時便も含めてお調べします。なお、運行日によっては、バスの出発する時刻が正確でないことがあります。予め、ご了承ください。
178    179  TEXTAREA_EVENT_SET|K               SYNTH_START|mei|mei_voice_normal|次の、日野、南大沢間、連絡バスが出発する時間を、臨時便も含めてお調べします。なお、運行日によっては、バスの出発する時刻が、正確でないことがあります。予め、ご了承ください。
179    180  SYNTH_EVENT_STOP|mei               TEXTAREA_DELETE|K
180    2    <eps>                              FSTRELOAD|null

1      181  KEY|4                              TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
181    182   TEXTAREA_EVENT_ADD|K               TEXTAREA_SET|K|???????????????。
182    183   TEXTAREA_EVENT_SET|K               SYNTH_START|mei|mei_voice_normal|???????????????。
183    2    SYNTH_EVENT_STOP|mei               TEXTAREA_DELETE|K

# 0180-0190 Background Change
1      2    KEY|;                               STAGE|Stage\building2\floor.bmp,Stage\customBackground\bak1.jpg
1      2    KEY|*                               STAGE|Stage\building2\floor.bmp,Stage\customBackground\bak2.jpg

#-------------------------------------------------------------------------------------------------------


# 1000-1050  心理テスト

1    1000 RECOG_EVENT_STOP|心理               VALUE_EVAL|random|LE|50
1000 1001 VALUE_EVENT_EVAL|random|LE|50|TRUE  TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
1001 1002 TEXTAREA_EVENT_ADD|K                TEXTAREA_SET|K|心理テストを始めます。あなたは、廊下にいます。そこから、自分の部屋に戻ろうとしています。その時、ドア、の色は何の色が浮かびますか。赤、青、緑、黒、の中から選んでください。
1002 1003 TEXTAREA_EVENT_SET|K                SYNTH_START|mei|mei_voice_normal|心理テストを始めます。あなたは、廊下にいます。そこから、自分の部屋に戻ろうとしています。その時、ドア、の色は何の色が浮かびますか。赤、青、緑、黒、の中から選んでください。
1003 1004 SYNTH_EVENT_STOP|mei                TEXTAREA_DELETE|K
1004 1005 RECOG_EVENT_START                   <eps>
1005 1006 RECOG_EVENT_STOP|赤                 TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
1006 1007 TEXTAREA_EVENT_ADD|K                TEXTAREA_SET|K|この心理テストは、あなたの理想の恋人像を表しています。赤、を選んだ人は、義理、人情に厚い体育会系の人が理想のようです。まさに、修造、のような人ですね。
1007 1008 TEXTAREA_EVENT_SET|K                SYNTH_START|mei|mei_voice_normal|この心理テストは、あなたの理想の恋人像を表しています。赤、を選んだ人は、義理、人情に厚い体育会系の人が理想のようです。まさに、修造、のような人ですね。
1008 2    SYNTH_EVENT_STOP|mei                TEXTAREA_DELETE|K
1005 1006 RECOG_EVENT_STOP|青                 TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
1006 1007 TEXTAREA_EVENT_ADD|K                TEXTAREA_SET|K|この心理テストは、あなたの理想の恋人像を表しています。青、を選んだ人は、知的で、精神的に強い人が理想のようです。ぜひ、東大の合コンにでも行ってください。
1007 1008 TEXTAREA_EVENT_SET|K                SYNTH_START|mei|mei_voice_normal|この心理テストは、あなたの理想の恋人像を表しています。青、を選んだ人は、知的で、精神的に強い人が理想のようです。ぜひ、東大の合コンにでも行ってください。
1008 2    SYNTH_EVENT_STOP|mei                TEXTAREA_DELETE|K
1005 1006 RECOG_EVENT_STOP|緑                 TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
1006 1007 TEXTAREA_EVENT_ADD|K                TEXTAREA_SET|K|この心理テストは、あなたの理想の恋人像を表しています。緑、を選んだ人は、一緒にいると心が安らぐ人が理想のようです。
1007 1008 TEXTAREA_EVENT_SET|K                SYNTH_START|mei|mei_voice_normal|この心理テストは、あなたの理想の恋人像を表しています。緑、を選んだ人は、一緒にいると心が安らぐ人が理想のようです。
1008 2    SYNTH_EVENT_STOP|mei                TEXTAREA_DELETE|K
1005 1006 RECOG_EVENT_STOP|黒                 TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
1006 1007 TEXTAREA_EVENT_ADD|K                TEXTAREA_SET|K|この心理テストは、あなたの理想の恋人像を表しています。黒、を選んだ人は、ギャップのある人が理想のようです。ギャップ萌え、よい文明ですね。
1007 1008 TEXTAREA_EVENT_SET|K                SYNTH_START|mei|mei_voice_normal|この心理テストは、あなたの理想の恋人像を表しています。黒、を選んだ人は、ギャップのある人が理想のようです。ギャップ萌え、よい文明ですね。
1008 2    SYNTH_EVENT_STOP|mei                TEXTAREA_DELETE|K

1000 1001 VALUE_EVENT_EVAL|random|LE|50|FALSE TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
1001 1002 TEXTAREA_EVENT_ADD|K                TEXTAREA_SET|K|心理テストを始めます。あなたは、心の中にある、部屋にいます。その中で、最も見晴らしの良い窓に、カーテンを付けることにしました。なにいろを付けますか。ベージュ、きいろ、オレンジ、の中から選んでください。
1002 1003 TEXTAREA_EVENT_SET|K                SYNTH_START|mei|mei_voice_normal|心理テストを始めます。あなたは、心の中にある、部屋にいます。その中で、最も見晴らしの良い窓に、カーテンを付けることにしました。なにいろを付けますか。ベージュ、きいろ、オレンジ、の中から選んでください。
1003 1004 SYNTH_EVENT_STOP|mei                TEXTAREA_DELETE|K
1004 1005 RECOG_EVENT_START                   <eps>
1005 1006 RECOG_EVENT_STOP|ベージュ           TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
1006 1007 TEXTAREA_EVENT_ADD|K                TEXTAREA_SET|K|この心理テストは、あなたの金銭感覚を表しています。ベージュ、を選んだ人は、コツコツ堅実にためていく人のようです。
1007 1008 TEXTAREA_EVENT_SET|K                SYNTH_START|mei|mei_voice_normal|この心理テストは、あなたの金銭感覚を表しています。ベージュ、を選んだ人は、コツコツ堅実にためていく人のようです。
1004 2    SYNTH_EVENT_STOP|mei                TEXTAREA_DELETE|K
1005 1006 RECOG_EVENT_STOP|きいろ             TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
1006 1007 TEXTAREA_EVENT_ADD|K                TEXTAREA_SET|K|この心理テストは、あなたの金銭感覚を表しています。きいろ、を選んだ人は、勉強家だけど、気分に左右されてお金がたまりにくい人のようです。
1007 1008 TEXTAREA_EVENT_SET|K                SYNTH_START|mei|mei_voice_normal|この心理テストは、あなたの金銭感覚を表しています。きいろ、を選んだ人は、勉強家だけど、気分に左右されてお金がたまりにくい人のようです。
1008 2    SYNTH_EVENT_STOP|mei                TEXTAREA_DELETE|K
1005 1006 RECOG_EVENT_STOP|オレンジ           TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
1006 1007 TEXTAREA_EVENT_ADD|K                TEXTAREA_SET|K|この心理テストは、あなたの金銭感覚を表しています。オレンジ、を選んだ人は、お金に対して積極的に研究を重ねている人のようです。株、や、FX、に手を出したとき、大損をしないように気を付けましょう。
1007 1008 TEXTAREA_EVENT_SET|K                SYNTH_START|mei|mei_voice_normal|この心理テストは、あなたの金銭感覚を表しています。オレンジ、を選んだ人は、お金に対して積極的に研究を重ねている人のようです。株、や、FX、に手を出したとき、大損をしないように気を付けましょう。
1008 2    SYNTH_EVENT_STOP|mei                TEXTAREA_DELETE|K

1    1009 RECOG_EVENT_STOP|診断               VALUE_EVAL|random|LE|50
1009 1010 VALUE_EVENT_EVAL|random|LE|50|TRUE  TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
1010 1011 TEXTAREA_EVENT_ADD|K                TEXTAREA_SET|K|心理テストを始めます。あなたは、テストでぜろ点を取ってしまいました。それを、友達に見られてしまいました。その時、なんて言いますか。思い浮かんだら、浮かんだ、と言ってください。
1011 1012 TEXTAREA_EVENT_SET|K                SYNTH_START|mei|mei_voice_normal|心理テストを始めます。あなたは、テストでぜろ点を取ってしまいました。それを、友達に見られてしまいました。その時、なんて言いますか。思い浮かんだら、浮かんだ、と言ってください。
1012 1013 SYNTH_EVENT_STOP|mei                TEXTAREA_DELETE|K
1013 1014 RECOG_EVENT_START                   <eps>
1014 1015 RECOG_EVENT_STOP|浮かん             TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
1015 1016 TEXTAREA_EVENT_ADD|K                TEXTAREA_SET|K|あなたが思い浮かべた言葉は、あなたが、恋人とキスしているときに言う、セリフらしいですよ。
1016 1017 TEXTAREA_EVENT_SET|K                SYNTH_START|mei|mei_voice_normal|あなたが思い浮かべた言葉は、あなたが、恋人とキスしているときに言う、セリフらしいですよ。
1017 2    SYNTH_EVENT_STOP|mei                TEXTAREA_DELETE|K
1009 1010 VALUE_EVENT_EVAL|random|LE|50|FALSE TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
1010 1011 TEXTAREA_EVENT_ADD|K                TEXTAREA_SET|K|心理テストを始めます。あなたの家から一番近い公園を思い浮かべてください。そこに誰がいますか。決まったら、決まったと言ってください。
1011 1012 TEXTAREA_EVENT_SET|K                SYNTH_START|mei|mei_voice_normal|心理テストを始めます。あなたの家から一番近い公園を思い浮かべてください。そこに誰がいますか。決まったら、決まったと言ってください。
1012 1013 SYNTH_EVENT_STOP|mei                TEXTAREA_DELETE|K
1013 1014 RECOG_EVENT_START                   <eps>
1014 1015 RECOG_EVENT_STOP|決まっ             TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
1015 1016 TEXTAREA_EVENT_ADD|K                TEXTAREA_SET|K|その人は、あなたを恨んでいるひとです。
1016 1017 TEXTAREA_EVENT_SET|K                SYNTH_START|mei|mei_voice_normal|その人は、あなたを恨んでいるひとです。
1017 2    SYNTH_EVENT_STOP|mei                TEXTAREA_DELETE|K

#-------------------------------------------------------------------------------------------------------

#music 1171-1185

#1    1171   RECOG_EVENT_STOP|音楽            STAGE|Stage\building2\floor.bmp,Stage\customBackground\bak4.jpg
1    1172 RECOG_EVENT_STOP|音楽               TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
1172 1173 TEXTAREA_EVENT_ADD|K                TEXTAREA_SET|K|わかりました。それでは歌わせていただきます。
1173 1174 TEXTAREA_EVENT_SET|K                SYNTH_START|mei|mei_voice_normal|わかりました。それでは歌わせていただきます。
1174 1175   SYNTH_EVENT_STOP|mei             SOUND_START|m4|music\misc.WAV
1175 1176  <eps>                             TEXTAREA_DELETE|K
1176 1177  <eps>                              TEXTAREA_ADD|J|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,20,0
1177 1178 TEXTAREA_EVENT_ADD|J                TEXTAREA_SET|J|「おしまい」で音楽が止まります。
1178 2    TEXTAREA_EVENT_SET|J               <eps>     

1    1179   RECOG_EVENT_STOP|おしまい        SOUND_STOP|m4
1    1179   RECOG_EVENT_STOP|とめ,て         SOUND_STOP|m4
1    1179   RECOG_EVENT_STOP|天使            SOUND_STOP|m4
1    1179   RECOG_EVENT_STOP｜ストップ       SOUND_STOP|m4
1179  2     <eps>                            TEXTAREA_DELETE|J               

#口臭2 1191-2005

1    1191  RECOG_EVENT_STOP|匂い              TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
1191  1192  TEXTAREA_EVENT_ADD|K              TEXTAREA_SET|K|口のにおいをかがせてください。
1192  1193  TEXTAREA_EVENT_SET|K               SYNTH_START|mei|mei_voice_normal|口のにおいをかがせてください。
1193  1194  SYNTH_EVENT_STOP|mei               TEXTAREA_DELETE|K
1194  1195  RECOG_EVENT_START                   MOTION_ADD|mei|listen|Expression\mei_listen\mei_listen.vmd|PART|ONCE
1195  1196  <eps>                               VALUE_SET|RA|0|100
1196  1197  RECOG_EVENT_STOP|                   VALUE_EVAL|RA|LE|70
1197  1198  VALUE_EVENT_EVAL|RA|LE|70|TRUE      TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
1198  1199  TEXTAREA_EVENT_ADD|K                TEXTAREA_SET|K|とてもいい匂いがしますね。
1199  2000  TEXTAREA_EVENT_SET|K                SYNTH_START|mei|mei_voice_happy|とてもいい匂いがしますね。
2000  2001  <eps>                               MOTION_ADD|mei|action|Motion\mei_action\mei_ii.vmd|PART|ONCE
1197  2002   VALUE_EVENT_EVAL|RA|LE|70|FALSE    TEXTAREA_ADD|K|-1,-1|1.0,1.0,0.0|0,0,0,1|255,255,255,1|0,2,0
2002  2003  TEXTAREA_EVENT_ADD|K                TEXTAREA_SET|K|臭いですね。
2003  2004  TEXTAREA_EVENT_SET|K                SYNTH_START|mei|mei_voice_bashful|臭いですね
2004  2001  <eps>                               MOTION_ADD|mei|action|Motion\mei_action\mei_kisai.vmd|PART|ONCE
1196  2    RECOG_EVENT_STOP|おしまい            <eps>
2001  1194  SYNTH_EVENT_STOP|mei                TEXTAREA_DELETE|K


#Mmode 2010-2015

1     2011  RECOG_EVENT_STOP|暑い               SYNTH_START|mei|mei_voice_bashful|ハア。ハア。ハア。
2011  2012  SYNTH_EVENT_STOP|mei                <eps>
2012  2013  RECOG_EVENT_START                   MOTION_ADD|mei|listen|Expression\mei_listen\mei_listen.vmd|PART|ONCE
2013  2014  <eps>                               VALUE_SET|RA|0|100
2014  2015  RECOG_EVENT_STOP|                   VALUE_EVAL|RA|LE|70
2015  2016   VALUE_EVENT_EVAL|RA|LE|70|TRUE     SYNTH_START|mei|mei_voice_normal|やめてください。
2015  2016   VALUE_EVENT_EVAL|RA|LE|70|FALSE    SYNTH_START|mei|mei_voice_happy|気持ちー。
2014  2    RECOG_EVENT_STOP|おしまい            <eps>
2016  2012  SYNTH_EVENT_STOP|mei                <eps>


#2026-2070 じゃんけん
1    2026 RECOG_EVENT_STOP|ジャンケン         SYNTH_START|mei|mei_voice_normal|行きますよ。最初はグー、じゃんけんぽん。
2026 2027 <eps>                               VALUE_EVAL|random|LE|50
2027 2028 VALUE_EVENT_EVAL|random|LE|50|TRUE  VALUE_EVAL|random|LE|50
2028 2029 VALUE_EVENT_EVAL|random|LE|50|TRUE  MOTION_ADD|mei|action|Motion\mei_game\mei_pa.vmd|PART|ONCE
2028 2029 VALUE_EVENT_EVAL|random|LE|50|FALSE MOTION_ADD|mei|action|Motion\mei_game\mei_chyoki.vmd|PART|ONCE
2029 2    SYNTH_EVENT_STOP|mei                <eps>
2027 2028 VALUE_EVENT_EVAL|random|LE|50|FALSE VALUE_EVAL|random|LE|50
2028 2029 VALUE_EVENT_EVAL|random|LE|50|TRUE  MOTION_ADD|mei|action|Motion\mei_game\mei_gu.vmd|PART|ONCE
2028 2029 VALUE_EVENT_EVAL|random|LE|50|FALSE MOTION_ADD|mei|action|Motion\mei_game\mei_chyoki.vmd|PART|ONCE
2029 2    SYNTH_EVENT_STOP|mei                <eps>

