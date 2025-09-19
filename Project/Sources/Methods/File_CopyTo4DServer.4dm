//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// File_CopyTo4DServer (localFilePath; filePathOnServer) : error
// File_CopyTo4DServer (text; text) : longint
//
// DESCRIPTION
//   Copies the file from the local file system to the
//   specified 4D path on the 4D Server.
//   
C_TEXT:C284($1; $vt_localFilePath)
C_TEXT:C284($2; $vt_filePathOnServer)
C_LONGINT:C283($0; $vl_error)
// ----------------------------------------------------
// HISTORY
//   Created By: SB (09/26/2013)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=2)

$vl_error:=0
$vt_localFilePath:=$1
$vt_filePathOnServer:=$2

FileOnServer_Delete($vt_filePathOnServer)

C_TEXT:C284($vt_MD5_LocalFile)
$vt_MD5_LocalFile:=File_GetChecksum($vt_localFilePath; "md5")

C_LONGINT:C283($vl_SourceFileSize)
$vl_SourceFileSize:=Get document size:C479($vt_localFilePath)

C_TIME:C306($fileRef)
$fileRef:=Open document:C264($vt_localFilePath; ""; Read mode:K24:5)
If (OK=1)
	
	C_LONGINT:C283($vl_count; $vl_NumBytesCopied; $vl_err)
	C_TEXT:C284($vt_DestFile_MD5)
	C_BLOB:C604($vx_fileBuffer)
	C_BOOLEAN:C305($vb_fileCopied)
	$vb_fileCopied:=False:C215
	$vl_count:=0
	$vl_NumBytesCopied:=0
	Repeat 
		SET BLOB SIZE:C606($vx_fileBuffer; 0)
		$vl_count:=$vl_count+1
		
		// Attempt to grab 150k of data
		RECEIVE PACKET:C104($fileRef; $vx_fileBuffer; 150*1024)
		$vl_NumBytesCopied:=$vl_NumBytesCopied+BLOB size:C605($vx_fileBuffer)
		COMPRESS BLOB:C534($vx_fileBuffer)
		
		$vl_err:=FileOnServer_AppendData($vt_filePathOnServer; $vx_fileBuffer)
		
		If ($vl_NumBytesCopied=$vl_SourceFileSize)
			$vb_fileCopied:=True:C214
		End if 
	Until ($vb_fileCopied)
	SET BLOB SIZE:C606($vx_fileBuffer; 0)
	
	CLOSE DOCUMENT:C267($fileRef)
Else 
	$vl_error:=-43  // ERROR - Can't open file
End if 

$vt_DestFile_MD5:=FileOnServer_GetMD5($vt_filePathOnServer)

If ($vt_DestFile_MD5=$vt_MD5_LocalFile)
	$vl_error:=0
Else 
	If ($vl_error=0)
		$vl_error:=-1
	End if 
End if 

$0:=$vl_error