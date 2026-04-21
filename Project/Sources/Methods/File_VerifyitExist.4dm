//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// Method: File_VerifyitExist (path to directory) : isThere

#DECLARE($thePath : Text)->$isThere : Boolean
var $tmpLongInt : Integer

If ($thePath="")
	return 
End if 

// check to see if the directory is there, if not then create it
$tmpLongInt:=Test path name:C476($thePath)
Case of 
	: ($tmpLongInt=Is a document:K24:1)
		$isThere:=True:C214
		
	: ($tmpLongInt=Is a folder:K24:2)
		$isThere:=False:C215
		
End case 
