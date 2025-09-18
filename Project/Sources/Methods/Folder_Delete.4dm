//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// Folder_Delete (folderPath)
// 
// DESCRIPTION
//  This routine will recursively delete files and folders  
//  including the folder you pass in. Use with care as
//  this is NOT UNDOABLE and has NO ERROR CHECKING!
//  Don't say I didn't warn you.
//
C_TEXT:C284($1; $vt_folderPath)  // Path of the folder to be deleted. 
// ----------------------------------------------------
// HISTORY
//   Created by: DB (05/31/06)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)
$vt_folderPath:=$1

If ($vt_folderPath#"")
	OnErr_Install_Handler("OnErr_GENERIC")
	
	If (Substring:C12($vt_folderPath; Length:C16($vt_folderPath); 1)=Folder separator:K24:12)
		$vt_folderPath:=Substring:C12($vt_folderPath; 1; Length:C16($vt_folderPath)-1)
	End if 
	
	If (Folder_DoesExist($vt_folderPath))
		Folder_EmptyContents($vt_folderPath)  // 1st empty the folder
		DELETE FOLDER:C693($vt_folderPath)  // and then delete the folder
	End if 
	
	OnErr_ClearError
	OnErr_Install_Handler
End if 