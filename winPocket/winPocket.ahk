#include ../functions/transparencyFunctions.ahk
#include ../functions/arrayFunctions.ahk

; global variables
	global rangeMax := [0,0,0,0]

	global rangeUL := [0,0,0,0]
	global rangeUR := [0,0,0,0]
	
	global rangeLL := [0,0,0,0]
	global rangeLR := [0,0,0,0]
	
	global rangeC := [0,0,0,0]
	global rangeL := [0,0,0,0]
	global rangeR := [0,0,0,0]
	global rangeT := [0,0,0,0]
	global rangeB := [0,0,0,0]
	global index

; Simple script used to place active window to four corners of the current window's monitor
; https://autohotkey.com/board/topic/94735-get-active-monitor/

GetMonitor(hwnd := 0) {
; If no hwnd is provided, use the Active Window
	if (hwnd)
		WinGetPos, winX, winY, winW, winH, ahk_id %hwnd%
	else
		WinGetActiveStats, winTitle, winW, winH, winX, winY

	SysGet, numDisplays, MonitorCount
	SysGet, idxPrimary, MonitorPrimary

	Loop %numDisplays%
	{	SysGet, mon, MonitorWorkArea, %a_index%
	; Left may be skewed on Monitors past 1
		if (a_index > 1)
			monLeft -= 10
	; Right overlaps Left on Monitors past 1
		else if (numDisplays > 1)
			monRight -= 10
	; Tracked based on X. Cannot properly sense on Windows "between" monitors
		if (winX >= monLeft && winX < monRight)
			return %a_index%
	}
; Return Primary Monitor if can't sense
	return idxPrimary
}


updateRanges:
	index := GetMonitor()
	SysGet, Mon, MonitorWorkArea, %index%
	sWidth := Abs(MonRight - MonLeft)
	sHeight := Abs(MonTop - MonBottom)

	rangeMax := [MonLeft, MonTop, sWidth, sHeight]

	rangeUL := [MonLeft, MonTop, sWidth*0.5, sHeight*0.5]
	rangeUR := [MonLeft+sWidth*0.5, MonTop, sWidth*0.5, sHeight*0.5]
	
	rangeLL := [MonLeft, MonTop+sHeight*0.5, sWidth*0.5, sHeight*0.5]
	rangeLR := [MonLeft+sWidth*0.5, MonTop+sHeight*0.5, sWidth*0.5, sHeight*0.5]
	
	rangeC := [MonLeft+sWidth*0.25, MonTop+sHeight*0.25, sWidth*0.5, sHeight*0.5]
	rangeL := [MonLeft, MonTop, sWidth*0.5, sHeight]
	rangeR := [MonLeft+sWidth*0.5, MonTop, sWidth*0.5, sHeight]
	rangeT := [MonLeft, MonTop, sWidth, sHeight*0.5]
	rangeB := [MonLeft, MonTop+sHeight*0.5, sWidth, sHeight*0.5]

return

; return coordinates for window position based on current monitor
; returns [x start, y start, width, height]
getCoordinates(position)
{
	SysGet, MonitorCount, MonitorCount
	
	gosub updateRanges

	if (position==1)
	{
		return rangeLL
	}
	if (position==2)
	{
		return rangeB
	}
	if (position==3)
	{
		return rangeLR
	}
	if (position==4)
	{
		;gosub updateRanges
		WinGetPos, X, Y, Width, Height, A
		rangeCu := roundArray([X, Y, Width, Height])
		rangeL := roundArray(rangeL)
		if compareArrays(rangeL, rangeCu)
			return rangeR
		return rangeL
	}
	if (position==5)
	{
		WinGetPos, X, Y, Width, Height, A
		rangeCu := roundArray([X, Y, Width, Height])
		rangeC := roundArray(rangeC)
		
		if compareArrays(rangeC, rangeCu)
			return rangeMax
		return rangeC
	}
	if (position==6) ; move to next monitor on L
	{
		WinGetPos, X, Y, Width, Height, A
		rangeCu := roundArray([X, Y, Width, Height])
		rangeR := roundArray(rangeR)

		if compareArrays(rangeR, rangeCu)
			return rangeL
		return rangeR
	}
	if (position==7)
	{
		return rangeUL
	}
	if (position==8)
	{
		return rangeT
	}
	if (position==9)
	{
		return rangeUR
	}

	return [-1,-1,-1,-1]
}


placeAndResize(id)
{
	fadeInWindow(False, 10)
	range := getCoordinates(id)
	if compareArrays(range, rangeMax)
	{
		WinRestore, A
		WinMaximize, A
	}
	else
	{
		WinRestore, A
		WinMove, A, ,range[1], range[2]
		WinMove, A, , , ,range[3], range[4]
	}
	fadeInWindow(True, 10)

}


^NumPad1::
	placeAndResize(1)
return
^NumPad2::
	placeAndResize(2)
return
^NumPad3::
	placeAndResize(3)
return
^NumPad4::
	placeAndResize(4)
return
^NumPad5::
	placeAndResize(5)
return
^NumPad6::
	placeAndResize(6)
return
^NumPad7::
	placeAndResize(7)
return
^NumPad8::
	placeAndResize(8)
return
^NumPad9::
	placeAndResize(9)
return
