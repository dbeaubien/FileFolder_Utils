//%attributes = {"invisible":true,"shared":true,"executedOnServer":true,"preemptive":"capable"}
// FileOnServer_AppendData(filePathOnServer; data2Append) : error
// FileOnServer_AppendData (text; blob) : longint
//
// DESCRIPTION
//   Appends the blob on the end of the file.
//
//   NOTE: The blob will be expanded prior to appending
//   to the file if it is compressed.
//
//   NOTE: If the finalFileSize is negative then it is
//   an error code.
//   
C_TEXT:C284($1; $vt_filePathOnServer)
C_BLOB:C604($2; $vx_data2Append)
C_LONGINT:C283($0; $vl_error)
// ----------------------------------------------------
// HISTORY
//   Created By: SB (09/25/2013)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=2)
$vl_error:=0
$vt_filePathOnServer:=$1
$vx_data2Append:=$2

OnErr_Install_Handler("OnErr_GENERIC")

Folder_VerifyExistance(File_GetFolderName($vt_filePathOnServer))

// Expand the blob if it is compressed
C_LONGINT:C283($vl_isCompressed)
BLOB PROPERTIES:C536($vx_data2Append; $vl_isCompressed)
If ($vl_isCompressed=1)
	EXPAND BLOB:C535($vx_data2Append)
End if 

// Open the file
C_TIME:C306($fileRef)
If (File_DoesExist($vt_filePathOnServer))  // this will also ensure the folder exists
	$fileRef:=Append document:C265($vt_filePathOnServer)
Else 
	$fileRef:=Create document:C266($vt_filePathOnServer)
End if 

// Append the data
If (OK=1)
	SEND PACKET:C103($fileRef; $vx_data2Append)
	CLOSE DOCUMENT:C267($fileRef)
	SET BLOB SIZE:C606($vx_data2Append; 0)  // clean up data
End if 

$vl_error:=OnErr_GetLastError
OnErr_Install_Handler

$0:=$vl_error