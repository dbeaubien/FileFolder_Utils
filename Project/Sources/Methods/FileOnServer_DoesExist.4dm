//%attributes = {"invisible":true,"shared":true,"executedOnServer":true,"preemptive":"capable"}
// FileOnServer_DoesExist (path to file) : does exist
// FileOnServer_DoesExist (text) : boolean
// 
// DESCRIPTION:
//   Returns true if the file exists on the 4D Server.
//   It will create any directories if are missing.
//
C_TEXT:C284($1; $vt_fullPathOnServer)  // Path to file
C_BOOLEAN:C305($0; $vb_doesExistOnServer)  // File does exist
// ----------------------------------------------------
// MODIFICATION HISTORY:
//   Added: DB (7/17/03 @ 15:46:39)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)
$vb_doesExistOnServer:=False:C215
$vt_fullPathOnServer:=$1

$vb_doesExistOnServer:=File_DoesExist($vt_fullPathOnServer)

$0:=$vb_doesExistOnServer