//%attributes = {"invisible":true,"shared":true,"executedOnServer":true,"preemptive":"capable"}
// FileOnServer_DoesExist (path to file) : does exist
// FileOnServer_DoesExist (text) : boolean
// 
// DESCRIPTION:
//   Returns true if the file exists on the 4D Server.
//   It will create any directories if are missing.
//
#DECLARE($vt_fullPathOnServer : Text)->$vb_doesExistOnServer : Boolean  // File does exist
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)

$vb_doesExistOnServer:=File_DoesExist($vt_fullPathOnServer)