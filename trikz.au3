; 	Trikz Macro by SeJIya © 2019 sejiya.ru
;	=============================
;	unbind mouse1
;	bind mouse2 +attack
;	bind f7 "+attack;-attack"
;	bind f8 "+jump;-jump"

#include <Misc.au3>

$hDLL = DllOpen("user32.dll")
$sWork = False

checkMouse()

Func checkMouse()
   While 1
	  Sleep(1)
	  If _IsPressed("01", $hDLL) AND $sWork == False AND WinActive("[TITLE:Counter-Strike Source; CLASS:Valve001]") Then
		 $sWork = True
		 _SendKey(0x76)
		 Sleep(98); Change delay for u. For me 92 95 98 - ok; 100..104 - bad, just test it
		 _SendKey(0x77)
		ExitLoop
	  EndIf
   WEnd
   $sWork = False
   Sleep(287) ;If server have fast flash switch use 287, else 326
   checkMouse()
EndFunc

Func _SendKey($keys)
   $hwnd = WinGetHandle("[TITLE:Counter-Strike Source; CLASS:Valve001]")
   $ret = DllCall($hDLL, "int", "MapVirtualKey", "int", $keys, "int", 0)
   If IsArray($ret) Then
	  DllCall($hDLL, "int", "PostMessage", "hwnd", $hwnd, "int", 0x0100, "int", $keys, "long", _MakeLong(1, $ret[0]))
	  Sleep(10)
	  DllCall($hDLL, "int", "PostMessage", "hwnd", $hwnd, "int", 0x0101, "int", $keys, "long", _MakeLong(1, $ret[0]) + 0xC0000000)
   EndIf
EndFunc

Func _MakeLong($LoDWORD, $HiDWORD)
   Return BitOR($HiDWORD * 0x10000, BitAND($LoDWORD, 0xFFFF))
EndFunc