//%attributes = {"invisible":true,"shared":true,"executedOnServer":true,"preemptive":"capable"}
// FileOnServer_Delete (filePathOnServer)
// FileOnServer_Delete (text)
// 
// DESCRIPTION
//   Deletes the specified document on the 4D Server.
//
C_TEXT:C284($1; $vt_filePathOnServer)
// ----------------------------------------------------
// HISTORY
//   Created By: SB (09/26/2013)
// ----------------------------------------------------

$vt_filePathOnServer:=$1

Folder_VerifyExistance(Folder_ParentName($vt_filePathOnServer))

File_Delete($vt_filePathOnServer)