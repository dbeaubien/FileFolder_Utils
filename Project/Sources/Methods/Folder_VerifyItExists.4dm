//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// ----------------------------------------------------
// METHOD: Folder_VerifyItExists (path to folder)
// 
// DESCRIPTION:
//   Creates a folder if it does not exist. If necessary, it will
//   recursively create the parent folders as well.
// ----------------------------------------------------
// PARAMETERS:
//   $1: path to folder
// RETURNS:
//   none
// ----------------------------------------------------
// MODIFICATION HISTORY:
//   Added: DB (7/17/03 @ 15:28:57)
// ----------------------------------------------------

Folder_VerifyExistance($1)