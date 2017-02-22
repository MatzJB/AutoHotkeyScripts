; author: MatzJB
; date: February 22, 2017

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



; return coordinates for window position based on current monitor

getCoordinates(position)
{
	; returns [x start, y start, width, height]

	index := GetMonitor()
	SysGet, Mon, MonitorWorkArea, %index%
	
	sWidth := Abs(MonRight - MonLeft)
	sHeight := Abs(MonTop - MonBottom)

	rangeUL := [MonLeft, MonTop, sWidth*0.5, sHeight*0.5]
	rangeUR := [MonLeft+sWidth*0.5, MonTop, sWidth*0.5, sHeight*0.5]
	
	rangeLL := [MonLeft, MonTop + sHeight*0.5, sWidth*0.5, sHeight*0.5]
	rangeLR := [MonLeft + sWidth*0.5, MonTop + sHeight*0.5, sWidth*0.5, sHeight*0.5]
	
	rangeC := [MonLeft + sWidth*0.25, MonTop + sHeight*0.25, sWidth*0.5, sHeight*0.5]
	rangeL := [MonLeft, MonTop, sWidth*0.5, sHeight]
	rangeR := [MonLeft+sWidth*0.5, MonTop, sWidth*0.5, sHeight]


	if (position==4)
	{
		return rangeL
	}
	if (position==6)
	{
		return rangeR
	}
	; center
	if (position==5)
	{
		return rangeC
	}

	if (position==1)
	{
		return rangeLL
	}
	if (position==3)
	{
		return rangeLR
	}
	if (position==7)
	{
		return rangeUL
	}
	if (position==9)
	{
		return rangeUR
	}

	return [-1, -1, -1, -1]
}


placeAndResize(id)
{
	WinRestore, A
	range := getCoordinates(id)
	WinMove, A,, range[1], range[2] ; add offset for toolbar
	WinMove, A,,,, range[3], range[4]
}



^NumPad4::
	placeAndResize(4)
return

^NumPad6::
	placeAndResize(6)
return

^NumPad5::
	placeAndResize(5)
return

^NumPad1::
	placeAndResize(1)
return

^NumPad3::
	placeAndResize(3)
return

^NumPad7::
	placeAndResize(7)
return

^NumPad9::
	placeAndResize(9)
return