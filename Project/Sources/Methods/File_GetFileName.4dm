//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// File_GetFileName (filePath) : filename
// File_GetFileName (text) : text
//
// DESCRIPTION
//   Given the path to a document, returns the document itself.
//
C_TEXT:C284($1; $filePath)  // Full path to document
C_TEXT:C284($0; $fileName)  // file name
//---------------------------------------------------
// HISTORY
//   Created: Jeremy Sullivan (October 16, 2001  5:29 PM) - HD Industries, Inc (http://www.hdind.com)
//   Mod by: Dani Beaubien (01/22/2016) - Rewrote
//   Mod by: Dani Beaubien (03/02/2020) - Rewrote to use a 4D Collection
//---------------------------------------------------

$fileName:=""
If (Asserted:C1132(Count parameters:C259=1))
	$filePath:=$1
	
	C_COLLECTION:C1488($pathParts)
	$pathParts:=Split string:C1554($filePath; Folder separator:K24:12)
	
	If ($pathParts.length>0)
		$fileName:=$pathParts.pop()
	End if 
	
End if 
$0:=$fileName