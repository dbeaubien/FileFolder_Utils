//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// File_CreateFile
// 
// DESCRIPTION
//   A generic method to create a file and properly set the
//   creator types. By default the file is set as a text file.
//
#DECLARE($vt_pathToCreateFileAt : Text; $vt_FileType : Text)->$vh_docRef : Time
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259<=2)

$vh_docRef:=?00:00:00?  // Clear our var

If (Count parameters:C259<2)
	$vt_FileType:=File_DeriveFileTypeFromName($vt_pathToCreateFileAt)
	If ($vt_FileType="")
		$vt_FileType:=(Is Windows:C1573) ? "TXT" : "TEXT"
	End if 
End if 

var $vt_docActuallyCreated : Text
$vh_docRef:=Create document:C266($vt_pathToCreateFileAt; $vt_FileType)
If (OK=1)
	$vt_docActuallyCreated:=Document
	CLOSE DOCUMENT:C267($vh_docRef)
	
	// Make sure that the name we specified (if any) is the name of the created file
	If ($vt_pathToCreateFileAt#"") && ($vt_pathToCreateFileAt#$vt_docActuallyCreated)
		MOVE DOCUMENT:C540($vt_docActuallyCreated; $vt_pathToCreateFileAt)
		$vt_docActuallyCreated:=$vt_pathToCreateFileAt
	End if 
	
	$vh_docRef:=Open document:C264($vt_docActuallyCreated)
Else 
	$vh_docRef:=-1
End if 
