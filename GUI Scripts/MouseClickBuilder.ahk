#SingleInstance Force
#Persistent
SetBatchLines, -1
CoordMode, Mouse, Screen
CoordMode, Click, Screen

HotkeyFile := A_ScriptDir "\GeneratedHotkeys.ahk"

; Map to store coords per hotkey
HotkeyCoords := {}

; List of keys we allow for capture
AllKeys := "a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,"
AllKeys .= "0,1,2,3,4,5,6,7,8,9,"
AllKeys .= "up,down,left,right,space,enter,tab,escape,shift,ctrl,alt"

; Ensure file exists
If !FileExist(HotkeyFile)
    FileAppend,, %HotkeyFile%

; ---------------- MAIN GUI ----------------
Gui, +AlwaysOnTop
Gui, Add, Text,, Pick a screen location, then assign a key combo.
Gui, Add, Button, w260 gPickLocation, Pick Screen Location
Gui, Add, Button, w260 gDone, Done Adding Hotkeys
Gui, Show,, Hotkey Builder
Return

; ---------------- PICK LOCATION ----------------
PickLocation:
    ToolTip, Click anywhere on the screen...
    KeyWait, LButton, D
    MouseGetPos, x, y
    ToolTip
    Sleep, 150

    ; Immediately open capture window (no manual typing)
    Gosub, CaptureKeys
Return

; ---------------- CAPTURE KEYS ----------------
CaptureKeys:
    KeyCount := 0
    FirstKey := ""
    SecondKey := ""

    Gui,3:New, +AlwaysOnTop -Caption +Border
    Gui,3:Add, Text, vLiveText Center w300 h40, Please press the 2-button combination you want to activate this click...
    Gui,3:Show, w300 h60, Capture
    Gui,3:Default

    ; Enable capture for all keys
    Loop, Parse, AllKeys, `,
    {
        k := A_LoopField
        if (k != "")
            Hotkey, *~$%k%, KeyPressed, On
    }
Return

KeyPressed:
    thisKey := SubStr(A_ThisHotkey, 4)   ; remove "*~$"
    KeyCount++

    GuiControl,, LiveText, % "Pressed: " thisKey

    if (KeyCount = 1)
        FirstKey := thisKey
    else if (KeyCount = 2)
    {
        SecondKey := thisKey

        ; Build hotkey combo
        combo := "~" FirstKey " & " SecondKey

        ; Write full absolute click logic into generated file
        block =
(
%combo%::
    CoordMode, Mouse, Screen
    CoordMode, Click, Screen
    MouseMove, %x%, %y%, 0
    Sleep, 400
    Click, %x%, %y%
    MouseMove, 0, 0, 0
Return

)
        FileAppend, %block%, %HotkeyFile%

        ; Activate hotkey dynamically (no reload)
        Hotkey, %combo%, DynamicClick, On

        ; Store coords for this hotkey
        HotkeyCoords[combo . "X"] := x
        HotkeyCoords[combo . "Y"] := y

        ; Close capture window
        Gui,3:Destroy

        ; Disable capture hotkeys
        Gosub, DisableCaptureHotkeys
    }
Return

DisableCaptureHotkeys:
    Loop, Parse, AllKeys, `,
    {
        k := A_LoopField
        if (k != "")
            Hotkey, *~$%k%, Off
    }
Return

; ---------------- HOTKEY ACTION (LIVE) ----------------
DynamicClick:
    hk := A_ThisHotkey
    x := HotkeyCoords[hk . "X"]
    y := HotkeyCoords[hk . "Y"]

    MouseMove, %x%, %y%, 0
    Sleep, 400
    Click, %x%, %y%
    MouseMove, 0, 0, 0
Return

; ---------------- DONE ----------------
Done:
Gui, Hide
ExitApp
Return

GuiClose:
ExitApp