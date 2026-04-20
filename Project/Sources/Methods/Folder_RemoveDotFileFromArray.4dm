//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// Folder_RemoveDotFileFromArray (arrPtr) 
// Folder_RemoveDotFileFromArray (pointer) 
//
// DESCRIPTION
//   Removes any file names that start with ".".
//   The array can contain full file paths and/r just file names.
//
#DECLARE($arrPtr : Pointer)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)

var $fileName : Text
var $i : Integer
For ($i; Size of array:C274($arrPtr->); 1; -1)
	$fileName:=File_GetFileName($arrPtr->{$i})
	If ($fileName=".@")
		DELETE FROM ARRAY:C228($arrPtr->; $i; 1)
	End if 
End for 
