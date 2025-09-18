//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// Method: File_VerifyitExist (path to directory) : isThere

C_TEXT:C284($1; $thePath)
C_BOOLEAN:C305($0; $isThere)
C_LONGINT:C283($tmpLongInt)

$thePath:=$1

If ($thePath="")
	$isThere:=False:C215
	
Else 
	// check to see if the directory is there, if not then create it
	$tmpLongInt:=Test path name:C476($thePath)
	Case of 
		: ($tmpLongInt=Is a document:K24:1)
			$isThere:=True:C214
			
		: ($tmpLongInt=Is a folder:K24:2)
			$isThere:=False:C215
			
	End case 
End if 

$0:=$isThere
