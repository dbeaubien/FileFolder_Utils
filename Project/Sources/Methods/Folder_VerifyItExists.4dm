//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// ----------------------------------------------------
// METHOD: Folder_VerifyItExists (path to folder)
// 
// DESCRIPTION:
//   Creates a folder if it does not exist. If necessary, it will
//   recursively create the parent folders as well.
// ----------------------------------------------------
#DECLARE($path_to_folder : Text)
// ----------------------------------------------------

Folder_VerifyExistance($path_to_folder)