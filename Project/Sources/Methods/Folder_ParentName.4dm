//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// Folder_ParentName (folderPath) : parentFolderPath
//
// DESCRIPTION
//   Returns the parent folder of the folderPath passed in.
#DECLARE($folder_path : Text)->$parent_folder_path : Text
ASSERT:C1129(Count parameters:C259=1)

If ($folder_path=("@"+Folder separator:K24:12))
	$folder_path:=Substring:C12($folder_path; 1; Length:C16($folder_path)-1)
End if 

var $path_parts : Collection
$path_parts:=Split string:C1554($folder_path; Folder separator:K24:12)

var $remove_last_folder_sep : Text
$remove_last_folder_sep:=$path_parts.pop()

$parent_folder_path:=$path_parts.join(Folder separator:K24:12)
If ($parent_folder_path#"")
	$parent_folder_path:=$parent_folder_path+Folder separator:K24:12
End if 
