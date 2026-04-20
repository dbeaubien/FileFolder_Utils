//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// File_GetFolderName (filePath) : folderName
// 
// DESCRIPTION
//   Given the path to a document, returns the path
//   to the folder the document is in.
//
#DECLARE($document_platformPath : Text)->$folder_platformPath : Text
// ----------------------------------------------------
ASSERT:C1129((Count parameters:C259=1) && ($document_platformPath#""))

var $path_parts : Collection
$path_parts:=Split string:C1554($document_platformPath; Folder separator:K24:12)
If ($path_parts.at(-1)="")
	$folder_platformPath:=$path_parts.pop()  // just get rid of the last part since it is blank
End if 

If ($path_parts.length>1)
	$folder_platformPath:=$path_parts.pop()  // just get rid of the last part
	$folder_platformPath:=$path_parts.join(Folder separator:K24:12)
	$folder_platformPath+=Folder separator:K24:12
Else 
	$folder_platformPath:=""
End if 