
^Down::WinMinimize, A
return

;^Right::WinClose, A
;return


; to get functions to send itself without triggering itself in a loop we use prepend with a $
$^g:: ; Google
	WinGetTitle, WinTitle, A

	if not inStr(WinTitle, "Sublime")
	{
		Send ^c
		Run, http://www.google.com/search?q=%clipboard%
	}
	else
		send ^g
return

$^y:: ; TouTube
	WinGetTitle, WinTitle, A
	if not inStr(WinTitle, "Sublime")
	{
		msgbox, %WinTitle%
		Send ^c
		Run, https://www.youtube.com/results?search_query=%clipboard%
	}
	else
		send ^y
return