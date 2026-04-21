//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// Folder_CopyFolderMoveFiles (srcFolderPath; dstFolderPath)
// 
// DESCRIPTION
//   This is a specialized routine that will move the contents from one folder
//   to another folder leaving the existing folder structure behind. Only the files
//   will be moved.
//
#DECLARE($vt_srcFolderPath : Text; $vt_dstFolderPath : Text)->$vl_numFilesMoved : Integer
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=2)

OnErr_Install_Handler("OnErr_GENERIC")

// Make sure that our paths are still valid
If (Length:C16($vt_srcFolderPath)>0) && (Length:C16($vt_dstFolderPath)>0)
	// Make sure that our paths end with a delimiter
	If ($vt_srcFolderPath#("@"+Folder separator:K24:12))
		$vt_srcFolderPath:=$vt_srcFolderPath+Folder separator:K24:12
	End if 
	If ($vt_dstFolderPath#("@"+Folder separator:K24:12))
		$vt_dstFolderPath:=$vt_dstFolderPath+Folder separator:K24:12
	End if 
	
	// Make sure both sides exist already
	Folder_VerifyExistance($vt_srcFolderPath)
	Folder_VerifyExistance($vt_dstFolderPath)
	
	
	// Loop through each document and do what is necessary
	DOCUMENT LIST:C474($vt_srcFolderPath; $at_containedDocuments)
	var $i : Integer
	For ($i; 1; Size of array:C274($at_containedDocuments))
		
		// Check to see if it already exists in our dst location, if so then delete it
		If (Test path name:C476($vt_dstFolderPath+$at_containedDocuments{$i})=Is a document:K24:1)
			DELETE DOCUMENT:C159($vt_dstFolderPath+$at_containedDocuments{$i})
		End if 
		
		// Now move it if everything is okay, if not, just skip it and try it again next time around
		If (OnErr_GetLastError=0)
			OnErr_ClearError
			MOVE DOCUMENT:C540($vt_srcFolderPath+$at_containedDocuments{$i}; $vt_dstFolderPath+$at_containedDocuments{$i})
			If (OnErr_GetLastError=0)  // All was okay
				$vl_numFilesMoved:=$vl_numFilesMoved+1
			End if 
		End if 
		
	End for 
	
	
	// Loop through each folder and do what is necessary
	FOLDER LIST:C473($vt_srcFolderPath; $at_containedDocuments)
	For ($i; 1; Size of array:C274($at_containedDocuments))
		OnErr_ClearError
		$vl_numFilesMoved:=$vl_numFilesMoved+Folder_CopyFolderMoveFiles($vt_srcFolderPath+$at_containedDocuments{$i}; $vt_dstFolderPath+$at_containedDocuments{$i})
	End for 
	
Else 
	ALERT:C41("One or both of the paths is empty.")
End if 

OnErr_ClearError
OnErr_Install_Handler
