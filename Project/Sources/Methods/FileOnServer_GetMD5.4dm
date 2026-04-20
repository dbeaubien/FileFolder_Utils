//%attributes = {"invisible":true,"shared":true,"executedOnServer":true,"preemptive":"capable"}
// FileOnServer_GetMD5 (filePathOnServer) : MD5
// FileOnServer_GetMD5 (text; pointer2Text) : longint
//
// DESCRIPTION
//   Generates and returns the MD5 hash for the file.
//   
#DECLARE($file_path_on_server : Text)->$md5_hash_value : Text
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)

$md5_hash_value:=File_GetChecksum($file_path_on_server; "md5")