//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// File_DoesExist (file_path) : does_file_exist
// 
// DESCRIPTION:
//   Returns true if the file exists. 
//   Any missing parent folders will be created if missing.
//
#DECLARE($file_path : Text)->$does_file_exist : Boolean

ASSERT:C1129(Count parameters:C259=1)

If ($file_path#"")
	Folder_VerifyExistance(Folder_ParentName($file_path))  // ensure the parent folder exists
	$does_file_exist:=(Test path name:C476($file_path)=Is a document:K24:1)
End if 
