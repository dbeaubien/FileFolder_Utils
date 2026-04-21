//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// Folder_RemoveOlderContents (pathToFolder; modMoreThanThisManyMinutes)
// Folder_RemoveOlderContents (text; longint)
// 
// DESCRIPTION
//   Removes any files in the specified folder that has
//   a modification date that was modified more than the
//   the number of specified minutes.
//
#DECLARE($vt_folderPath : Text; $vl_numMinutes : Integer)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=2)

var $vb_isLocked; $vb_isInvisible : Boolean
var $vd_createDate; $vd_modDate : Date
var $vh_createTime; $vh_modTime : Time

// Make sure we have a nice ending to our string, We will add one below
If (Substring:C12($vt_folderPath; Length:C16($vt_folderPath); 1)=Folder separator:K24:12)
	$vt_folderPath:=Substring:C12($vt_folderPath; 1; Length:C16($vt_folderPath)-1)
End if 

If (Folder_DoesExist($vt_folderPath))
	$vt_folderPath:=$vt_folderPath+Folder separator:K24:12  // ready for our code below
	
	OnErr_Install_Handler("OnErr_GENERIC")
	
	// Figure out the date time of when we want to delete files that have been moded before
	var $vl_pivotModDateTime : Integer
	$vl_pivotModDateTime:=TS_FromDateTime-($vl_numMinutes*60)
	
	ARRAY TEXT:C222($PROC_aT_Files; 0)
	DOCUMENT LIST:C474($vt_folderPath; $PROC_aT_Files)
	
	var $i; $vl_lastModDateTime : Integer
	var $vt_filePath : Text
	For ($i; 1; Size of array:C274($PROC_aT_Files))
		$vt_filePath:=$vt_folderPath+$PROC_aT_Files{$i}
		
		GET DOCUMENT PROPERTIES:C477($vt_filePath; $vb_isLocked; $vb_isInvisible; $vd_createDate; $vh_createTime; $vd_modDate; $vh_modTime)
		$vl_lastModDateTime:=TS_FromDateTime($vd_modDate; $vh_modTime)
		If ($vl_lastModDateTime<$vl_pivotModDateTime)
			If (File_DoesExist($vt_filePath))
				DELETE DOCUMENT:C159($vt_filePath)
			End if 
		End if 
	End for 
	
	OnErr_Install_Handler
End if 