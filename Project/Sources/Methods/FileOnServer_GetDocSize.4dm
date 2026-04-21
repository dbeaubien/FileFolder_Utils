//%attributes = {"invisible":true,"shared":true,"executedOnServer":true,"preemptive":"capable"}
// FileOnServer_GetDocSize (path to file) : size in bytes
// FileOnServer_GetDocSize (text) : size in bytes
// 
// DESCRIPTION:
//   Returns the size of the file on the 4D Server.
//
#DECLARE($vt_fullPathOnServer : Text)->$vl_fileSize : Integer
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)

$vl_fileSize:=Get document size:C479($vt_fullPathOnServer)