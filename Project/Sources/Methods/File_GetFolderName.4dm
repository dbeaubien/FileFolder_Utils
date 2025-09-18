//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// File_GetFolderName (filePath) : folderName
// File_GetFolderName (text) : text
// 
// DESCRIPTION
//   Given the path to a document, returns the path
//   to the folder the document is in.
//
C_TEXT:C284($1; $vt_docPath)  //   Full path to document
C_TEXT:C284($0; $vt_folderPath)  //   Path to folder document is in
//
// ----------------------------------------------------
// HISTORY
//   Created by: Jeremy Sullivan (10/16/2001)
//   Mod: DB (11/20/07) - Improved and simplified
//   Mod: DB (09/18/2012) - Fixed some bugs (added Unit Tests as well)
//   Mod by: Dani Beaubien (01/22/2016) - Rewrote
// ----------------------------------------------------

$vt_folderPath:=""
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	$vt_docPath:=$1
	
	If ($vt_docPath=("@"+Folder separator:K24:12))
		$vt_docPath:=Substring:C12($vt_docPath; 1; Length:C16($vt_docPath)-Length:C16(Folder separator:K24:12))
	End if 
	
	C_BOOLEAN:C305($hitFolderSeparator)
	C_LONGINT:C283($i)
	For ($i; Length:C16($vt_docPath); 1; -1)
		If ($vt_docPath[[$i]]=Folder separator:K24:12)
			$hitFolderSeparator:=True:C214
		End if 
		If ($hitFolderSeparator)
			$vt_folderPath:=$vt_docPath[[$i]]+$vt_folderPath
		End if 
	End for 
	
End if 
$0:=$vt_folderPath
