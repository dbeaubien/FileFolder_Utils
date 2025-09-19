//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// Folder_RemoveDotFileFromArray (arrPtr) 
// Folder_RemoveDotFileFromArray (pointer) 
//
// DESCRIPTION
//   Removes any file names that start with ".".
//   The array can contain full file paths and/r just file names.
//
C_POINTER:C301($1; $arrPtr)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (11/30/2017)
// ----------------------------------------------------

If (Asserted:C1132(Count parameters:C259=1))
	$arrPtr:=$1
	
	C_TEXT:C284($fileName)
	C_LONGINT:C283($i)
	For ($i; Size of array:C274($arrPtr->); 1; -1)
		$fileName:=File_GetFileName($arrPtr->{$i})
		If ($fileName=".@")
			DELETE FROM ARRAY:C228($arrPtr->; $i; 1)
		End if 
	End for 
End if 
