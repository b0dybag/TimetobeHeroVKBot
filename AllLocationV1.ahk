
LOCAL_1_PIX:=0x243335               ;; CheckLocation
LOCAL_2_PIX:=0x4E443A				;; 
LOCAL_3_PIX:=0x2D1711				;; if LocalCheckPix=0x454553 
LOCAL_4_PIX:=0x2D2928
LOCAL_5_PIX:=0x454553
TELEPORT_1_PIX:=0x171106
TELEPORT_2_PIX:=0x0403300
TELEPORT_3_PIX:=0x191318

;;ALERT_FALSE_PIX:=0xD5FFFE			;; AlertCheck
ALERT_TRUE_PIX:=0x6B8080	
GOAWAY_R_PIX:=0x9CD4E5
GOAWAY_L_PIX:=0x5C4412

killLocation1:=0
killLocation2:=1
killLocation3:=1
killLocation4:=1
killLocation5:=1
killLocation6:=1
killLocation7:=0
isLocationSkeletonReady:=0

CanChange:=1
menuPosition:=1
menuDinamic:=1
CustomColor = 00FF00 
Gui, +AlwaysOnTop +LastFound +Owner 
Gui, Color, %CustomColor%
Gui, Font, s14 bold, Verdana
Gui, Add, Text, vInfo cWhite, CTL+SFT+Q
Loop 7
{
	tmp:=killLocation%A_Index%
	Gui, Add, Text, vMyText%A_Index% cWhite, XXX%A_Index%-%tmp%XXX
}

Gui, Add, Text, vWorking cWhite, XXXXXXXX
Gui, Add, Text, vCoords cWhite, XXXXX YYYYY
Gui, Add, Text, vColor cWhite, Col:XXXXXXXX
WinSet, TransColor, %CustomColor% 255
Gui, -Caption
;;SetTimer, UpdateOSD, 100
Gosub, UpdateOSD
Loop 7
{
	RefreshGUI(A_Index)
}
Gui, Show, x-15 y200
return

UpdateOSD:
MouseGetPos, MouseX, MouseY
PixelGetColor, color, %MouseX%, %MouseY%
GuiControl,, Coords, X%MouseX%, Y%MouseY%
GuiControl,, Color, C:%color%
GuiControl,, Working, Change:%CanChange%
return


^!S::
SetTimer, AlertCheck, 10000
Gosub, CheckLocation
return

CheckLocation:
PixelGetColor, LocalCheckPix, 260, 450
Loop 5
{
if LOCAL_%A_Index%_PIX=%LocalCheckPix%
	Gosub, Location%A_Index%
}
Loop 3 
{
	if TELEPORT_%A_Index%_PIX=%LocalCheckPix%
		Gosub, Teleport%A_Index%
}
return

AlertCheck:
PixelGetColor, CheckAlertPix, 20, 230
PixelGetColor, CheckAlertPix2, 609, 370
PixelGetColor, CheckAlertPix3, 473, 440
PixelGetColor, CheckAlertPix4, 473, 440
;;MsgBox color:%CheckAlertPix2% `n colorMain:%CheckAlertPix% `n Colorthird:%CheckAlertPix3%

;;if ALERT_TRUE_PIX=%CheckAlertPix%
;;{
	PixelGetColor, CheckGoAwayRPix, 810, 411
	PixelGetColor, CheckGoAwayLPix, 486, 417
	;;GuiControl,, Info, %CheckGoAwayRPix%
	;;GuiControl,, Working, %CheckGoAwayLPix%
	;;GuiControl,, MyText1, %CheckAlertPix%
	if GOAWAY_R_PIX=%CheckGoAwayRPix%
	{
		Sleep, 500
		Click 810, 411
		Sleep, 500
		Gosub, CheckLocation
	}
	else
	{
		PixelGetColor, CheckGoAwayLPix, 486, 417
		if GOAWAY_L_PIX=%CheckGoAwayLPix%
		{
			Sleep, 500
			Click 486, 417
			Sleep, 500
			Gosub, CheckLocation
		}
		;;else MsgBox IDONTKNOW
	}
;;} ;;else MsgBox AllOk
tmp:=0x6BBAF6
;;MsgBox color:%CheckAlertPix2% `n colorMain:%tmp% 
if tmp=%CheckAlertPix2%    ;; Ocherednoi rubierz
{
	Click 794, 201
	Sleep, 500
	Gosub, CheckLocation
}
tmp:=0x251B28
;;MsgBox color:%CheckAlertPix2% `n colorMain:%tmp% 
if tmp=%CheckAlertPix3%    ;; slomalsya prepdmet
{
	Click 794, 201
	Sleep, 500
	Gosub, CheckLocation
}
;;if (tmp=%CheckAlertPix3%)   ;; dont work
;;{
;;	Click 607, 384
;;	Sleep, 500
;;	Gosub, CheckLocation
;;}
return

Traveler:
Location1:
action:=killLocation1
Gosub, ActionWithAll ;;  Location 1

Click 510, 200
StandartSleep()
Teleport1:
Click 650, 200
AcceptButtonClick()
StandartSleep()

Location2: 
action:=killLocation2
Gosub, ActionWithAll ;;  Location 2

if (killLocation3=1) {
	LogButtonClick()
	RysLogFight()
	killLocation3:=0
	SetTimer, LogMapsMakeReady, 6000000
}

Click 650, 200
StandartSleep()

Location3: 
action:=killLocation4
Gosub, ActionWithAll ;;  Location 3

Click 800, 300
StandartSleep()
Teleport2:
Click 800, 250
AcceptButtonClick()
StandartSleep()

Location4: 
action:=killLocation5
Gosub, ActionWithAll ;;  Location 4

Click 500, 300
StandartSleep()

Location5:
action:=killLocation6
Gosub, ActionWithAll ;;  Location 5

;;if (killLocation3=1) {
;;	LogButtonClick()
;;	BabaLogFight()
;;	killLocation3:=0
;;	SetTimer, LogMapsMakeReady, 6000000
;;}

if (isLocationSkeletonReady=1) {
	LogButtonClick()
	Click 630, 450
	StandartSleep()
	Click 600, 300
	StandartSleep()
	Click 500, 170
	StandartSleep()
	Click 1000, 440
	StandartSleep()
	
	action:=killLocation7
	gosub, ActionWithAll
	
	isLocationSkeletonReady:=0
	SetTimer, LocationSkeletonMakeReady, 1440000
	
	Click 860, 270
	AcceptButtonClick()
	StandartSleep()
	LogButtonClick()
}

Click 680, 310
StandartSleep()
Click 800, 250
StandartSleep()
Teleport3:
Click 650, 200
AcceptButtonClick()
StandartSleep()
Click 650, 200
StandartSleep()
Click 800, 300
StandartSleep()
Click 580, 350
AcceptButtonClick()
StandartSleep()

Gosub, CheckLocation
return

ActionWithAll:
endPix:=0x3D90C6
regPix:=0x0C3976
cryPix:=0xEFA439
position:=1
Loop
{
	max:=0	
	cryCount:=0
	tableY:=157
	Loop, 4
	{
		PixelGetColor, tablePix, 985, %tableY%
		if regPix=%tablePix%
			max:=max+1
		if cryPix=%tablePix%
		{
			max:=max+1
			cryCount:=cryCount+1
		}
		tableY:=tableY+79
	}
	;;MsgBox I was here2`nmax=%max%`ncry=%cryCount%`nPos=%position%`nloop:%loopto%
	if cryCount=%max%
		break
	if max=1
	{
		PixelGetColor, getEndPix, 1057, 225
		if endPix=%getEndPix%
			break
	}
	tableY:=78+position*79 ;;first pos = 157
	PixelGetColor, tablePix, 985, %tableY%
	tableCenterY:=99+position*79 ;; first pos = 178
	if regPix=%tablePix% 
	{
		Click 1016, %tableCenterY%
		Sleep, 1000
		if action=1
		{
			Click 580, 490
			Gosub, Fight
		}
		else 
		{
			Click 700, 500
			Sleep, 500
			Click 1010, 110
			Sleep, 1000
		}
	}
	position:=position+1
	if position>%max%
		position:=1

}
return

Fight:
accept :=0x644B14
manaColor :=0xA13F07
Loop
{
	Sleep, 11000
	PixelGetColor, acceptPlace, 600, 485
	if accept=%acceptPlace% 
		break
	PixelGetColor, firstAttack, 503, 252
	PixelGetColor, secondAttack, 630, 252
	if manaColor<>%firstAttack%
	Click 503, 200
	else if manaColor<>%secondAttack%
	Click 630, 200
	else Click 757, 200
}
Click 600, 485
Sleep, 500
return

LocationSkeletonMakeReady:
isLocationSkeletonReady:=1
return

LogMapsMakeReady:
killLocation3:=1
return

StandartSleep() {
Sleep, 3000
return
}

AcceptButtonClick(){
Sleep, 500
Click 590, 320
return
}

LogButtonClick(){
	Sleep, 500
	Click 1000, 485
	StandartSleep()
	return
}

RysLogFight() {
	logTrue:=0xA2DEF1
	Loop
	{
		Click 692, 346
		Sleep 5000
		Click 895, 155
		Sleep 1000
		Click 970, 320
		Sleep 1000
		Click 975, 260
		Sleep 1000
		PixelGetColor, logStart, 1000, 386
		if logTrue<>%logStart%
			break
		Click 970, 424
		Gosub, Fight
	}
	Click 1030, 135
	StandartSleep()
	LogButtonClick()
	return
}

BabaLogFight() {
	logTrue:=0xA2DEF1
	Loop
	{
		Click 772, 371
		Sleep 5000
		Click 895, 155
		Sleep 1000
		Click 970, 320
		Sleep 1000
		Click 975, 260
		Sleep 1000
		PixelGetColor, logStart, 1000, 386
		if logTrue<>%logStart%
			break
		Click 970, 424
		Gosub, Fight
	}
	Click 1030, 135
	StandartSleep()
	LogButtonClick()
	return
}

ShowPix() {
	PixelGetColor, CheckAlertPix, 20, 230
	PixelGetColor, CheckGoAwayRPix, 810, 411
	PixelGetColor, CheckGoAwayLPix, 486, 417
	
	MsgBox AP:%CheckAlertPix%`nLB:%CheckGoAwayLPix%`nRB:%CheckGoAwayRPix%
}

ShowCoords:
MouseGetPos MouseX, MouseY
MsgBox X:%MouseX%`nY:%MouseY%
return

ShowPix:
PixelGetColor, pix, MouseX, MouseY
MsgBox Pix:%pix%
return

Home::pause
Insert::ExitApp
End::ShowPix()
PgUp:: Gosub, ShowCoords
return
PgDn:: Gosub, ShowPix
return

^!q:: 
CanChange:=ChangeFunc(CanChange)
RefreshGUI(menuPosition)
return

Up:: 
CanChange ? menuPosition:=UpFunc(menuPosition,1)
return

Down:: 
CanChange ? menuPosition:=UpFunc(menuPosition,0)
return

Left::
Right::
CanChange ? killLocation%menuPosition%:=ChangeFunc(killLocation%menuPosition%)
RefreshGUI(menuPosition)
return

^!F::
gosub, Fight
return

ChangeFunc(i) {
	if (i)
		i:=0
	else
		i:=1
	return i
}

RefreshGUI(i){
	tmp:=killLocation%i%
	GuiControl,, MyText%i%, %i%-%tmp%
}

UpFunc(i,minus) {
	RefreshGUI(i)
	if (minus)
		if (i=1)
			i:=7
		else i:=i-1
		else
		if (i=7)
			i:=1
		else i:=i+1
	tmp:=killLocation%i%
	GuiControl,, MyText%i%, <%i%-%tmp%>
	return i
}
;;if (menuPosition=1) 
;;	GuiControl,, MyText1, <1-%killLocation1%>
;;if (menuPosition=1) 
;;	GuiControl,, MyText1, <1-%killLocation1%>
return
