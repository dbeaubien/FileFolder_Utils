//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// Folder_VerifyExistance (pathToFolder)
// 
// DESCRIPTION:
//   Creates a folder if it does not exist. If necessary, it will
//   recursively create the parent folders as well.
#DECLARE($path_to_folder : Text)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)

If ($path_to_folder#"")
	If (Not:C34(Folder_DoesExist($path_to_folder)))
		CREATE FOLDER:C475($path_to_folder; *)
	End if 
End if 