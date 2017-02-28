
^Down::WinMinimize, A
return

;^Right::WinClose, A
;return

^G:: ; Google
	Send ^c
	Run, http://www.google.com/search?q=%clipboard%

^Y:: ; TouTube
	Send ^c
	Run, https://www.youtube.com/results?search_query=%clipboard%

return