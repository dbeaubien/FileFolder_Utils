
// Must be non compiled and not as a component
If (Not:C34(Is compiled mode:C492)) && (Structure file:C489(*)=Structure file:C489)
	Manifest_SetAuthor("Dani Beaubien")
	Manifest_SetBuildDate(Current date:C33)
	Manifest_SetURL("https://github.com/4D-Open-Source/FileFolder_Utils")
	Manifest_SetCopyright("Open Source")
	Manifest_SetVersion("Build "+String:C10(Year of:C25(Current date:C33))+String:C10(Month of:C24(Current date:C33))+String:C10(Day of:C23(Current date:C33)); True:C214)
End if 