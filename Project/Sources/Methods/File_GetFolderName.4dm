//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// File_GetFolderName (filePath) : folderName
// 
// DESCRIPTION
//   Given the path to a document, returns the path
//   to the folder the document is in.
//
#DECLARE($document_platformPath : Text)->$folder_platformPath : Text
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)
ASSERT:C1129($document_platformPath#"")

$folder_platformPath:=File:C1566($document_platformPath; fk platform path:K87:2).parent.platformPath