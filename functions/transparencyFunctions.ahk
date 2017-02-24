; transparency of window in focus

; note: you can't use expressions in winset 
; transparency for some reason....


toggleTransparency()
{
	winget, transparent, transparent, A

	if transparent < 255
		WinSet, Transparent, 255, A
	Else
		WinSet, Transparent, 220, A
}


fadeInWindow(fadeIn, delay)
{
	if (fadeIn)
	{
		WinSet, Transparent, 0, A
		sleep delay
		WinSet, Transparent, 50, A
		sleep delay
		WinSet, Transparent, 100, A
		sleep delay
		WinSet, Transparent, 150, A
		sleep delay
		WinSet, Transparent, 200, A
		sleep delay
		WinSet, Transparent, 255, A
	}
	else
	{
		WinSet, Transparent, 255, A
		sleep delay
		WinSet, Transparent, 200, A
		sleep delay
		WinSet, Transparent, 150, A
		sleep delay
		WinSet, Transparent, 100, A
		sleep delay
		WinSet, Transparent, 50, A
		sleep delay
		WinSet, Transparent, 0, A
	}
}


