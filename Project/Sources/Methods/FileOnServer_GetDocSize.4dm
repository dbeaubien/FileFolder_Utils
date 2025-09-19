//%attributes = {"invisible":true,"shared":true,"executedOnServer":true,"preemptive":"capable"}
// FileOnServer_GetDocSize (path to file) : size in bytes
// FileOnServer_GetDocSize (text) : size in bytes
// 
// DESCRIPTION:
//   Returns the size of the file on the 4D Server.
//
C_TEXT:C284($1; $vt_fullPathOnServer)  // Path to file
C_LONGINT:C283($0; $vl_fileSize)  // File size
// ----------------------------------------------------
// MODIFICATION HISTORY:
//   Added: DB (7/17/03 @ 15:46:39)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)
$vl_fileSize:=0
$vt_fullPathOnServer:=$1

$vl_fileSize:=Get document size:C479($vt_fullPathOnServer)

$0:=$vl_fileSize