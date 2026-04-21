//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// File_DownloadFromURL (url; destFilePath)
// File_DownloadFromURL (text; text)
// 
// DESCRIPTION
//   Downloads a file from the internet and saves
//   it to the disk.
// ----------------------------------------------------
#DECLARE($url : Text; $destFilePath : Text)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=2)

Folder_VerifyItExists(File_GetFolderName($destFilePath))
File_Delete($destFilePath)

var $fileBlob : Blob
var $httpResponse : Integer
$httpResponse:=HTTP Get:C1157($url; $fileBlob)

If ($httpResponse=200)
	BLOB TO DOCUMENT:C526($destFilePath; $fileBlob)
End if 