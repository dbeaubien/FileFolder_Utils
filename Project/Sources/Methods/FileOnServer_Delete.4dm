//%attributes = {"invisible":true,"shared":true,"executedOnServer":true,"preemptive":"capable"}
// FileOnServer_Delete (filePathOnServer)
// FileOnServer_Delete (text)
// 
// DESCRIPTION
//   Deletes the specified document on the 4D Server.
//
#DECLARE($vt_filePathOnServer : Text)
// ----------------------------------------------------

Folder_VerifyExistance(Folder_ParentName($vt_filePathOnServer))

File_Delete($vt_filePathOnServer)