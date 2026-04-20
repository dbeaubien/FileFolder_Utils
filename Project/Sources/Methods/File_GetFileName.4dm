//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// File_GetFileName (filePath) : filename
// File_GetFileName (text) : text
//
// DESCRIPTION
//   Given the path to a document, returns the document itself.
//---------------------------------------------------
#DECLARE($filePath : Text)->$fileName : Text
//---------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)

var $pathParts : Collection
$pathParts:=Split string:C1554($filePath; Folder separator:K24:12)

If ($pathParts.length>0)
	$fileName:=$pathParts.pop()
End if 