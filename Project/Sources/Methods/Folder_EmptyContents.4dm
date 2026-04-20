//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// ----------------------------------------------------
// METHOD: Folder_EmptyContents
// 
// DESCRIPTION
//   This method deletes all the files within the specified folder.
//
// PARAMETERS:
#DECLARE($vt_folderPath : Text)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)

// Make sure we have a nice ending to our string, We will add one below
If (Substring:C12($vt_folderPath; Length:C16($vt_folderPath); 1)=Folder separator:K24:12)
	$vt_folderPath:=Substring:C12($vt_folderPath; 1; Length:C16($vt_folderPath)-1)
End if 

If (Not:C34(Folder_DoesExist($vt_folderPath)))
	return 
End if 
$vt_folderPath+=Folder separator:K24:12  // ready for our code below

OnErr_Install_Handler("OnErr_GENERIC")

var $PROC_vL_Count : Integer
ARRAY TEXT:C222($PROC_aT_Folders; 0)
ARRAY TEXT:C222($PROC_aT_Files; 0)

//First let's just merrily delete all of the documents in this folder...
DOCUMENT LIST:C474($vt_folderPath; $PROC_aT_Files)
For ($PROC_vL_Count; 1; Size of array:C274($PROC_aT_Files))
	DELETE DOCUMENT:C159($vt_folderPath+$PROC_aT_Files{$PROC_vL_Count})
End for 

//Now that there are only folders left, let's recursively delete them and all thier po' li'l chillen...
FOLDER LIST:C473($vt_folderPath; $PROC_aT_Folders)
For ($PROC_vL_Count; 1; Size of array:C274($PROC_aT_Folders))
	Folder_Delete($vt_folderPath+$PROC_aT_Folders{$PROC_vL_Count}+Folder separator:K24:12)
End for 

OnErr_Install_Handler