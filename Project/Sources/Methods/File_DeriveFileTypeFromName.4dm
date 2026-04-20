//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// ----------------------------------------------------
// METHOD: File_DeriveFileTypeFromName
// 
// DESCRIPTION
//   Figure out what the file type is basd on the file name.
// ----------------------------------------------------
#DECLARE($vt_fileName : Text)->$vt_FileType : Text
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)

// Get our file extn. If windows, then we are done
$vt_FileType:=File_GetExtension($vt_fileName)

If (Is Windows:C1573)
	return 
End if 

// If mac, then we have more work to do
Case of 
	: ($vt_FileType="xls") || ($vt_FileType="slk")
		$vt_FileType:="XLS8"
		
	Else   // by default
		$vt_FileType:="TEXT"
End case 
