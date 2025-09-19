//%attributes = {"invisible":true,"shared":true,"executedOnServer":true,"preemptive":"capable"}
// FileOnServer_GetMD5 (filePathOnServer) : MD5
// FileOnServer_GetMD5 (text; pointer2Text) : longint
//
// DESCRIPTION
//   Generates and returns the MD5 hash for the file.
//   
C_TEXT:C284($1; $vt_filePathOnServer)
C_TEXT:C284($0; $vt_MD5hash)
// ----------------------------------------------------
// HISTORY
//   Created By: SB (09/25/2013)
// ----------------------------------------------------

$vt_MD5hash:=""
If (Asserted:C1132(Count parameters:C259=1))
	$vt_filePathOnServer:=$1
	
	$vt_MD5hash:=File_GetChecksum($vt_filePathOnServer; "md5")
End if   // ASSERT
$0:=$vt_MD5hash