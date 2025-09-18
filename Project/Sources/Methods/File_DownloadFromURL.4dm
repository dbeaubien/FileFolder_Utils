//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// File_DownloadFromURL (url; destFilePath)
// File_DownloadFromURL (text; text)
// 
// DESCRIPTION
//   Downloads a file from the internet and saves
//   it to the disk.
//
C_TEXT:C284($1; $url)
C_TEXT:C284($2; $destFilePath)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (05/31/2016)
//   Mod by: Dani Beaubien (01/24/2019) - Using built in 4D command to avoid PHP
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=2)
$url:=$1
$destFilePath:=$2

Folder_VerifyItExists(File_GetFolderName($destFilePath))
File_Delete($destFilePath)

C_BLOB:C604($fileBlob)
C_LONGINT:C283($httpResponse)
$httpResponse:=HTTP Get:C1157($url; $fileBlob)

If ($httpResponse=200)
	BLOB TO DOCUMENT:C526($destFilePath; $fileBlob)
	//Log_INFO(Current method name+" downloaded "+String(BLOB size($fileBlob); "###,###,###,##0")+" bytes from url \""+$url+"\"")
Else 
	//Log_INFO(Current method name+" FAILED with http response "+String($httpResponse)+" from url \""+$url+"\"")
End if 

