//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// File_IsTabDelimited (pathToFile) : isTabDelimited
// File_IsTabDelimited (text) : boolean
//
// DESCRIPTION
//   Returns true if the file is tab-delimited.
//
// TESTS performed:
//   1. Is file extension ".tsv" or ".txt"
//   2. Look at first line, expect line of tab delimited values.
//   3. At least 2 non-empty values in the header line.
//
#DECLARE($path_to_file : Text)->$is_file_tab_delimited : Boolean
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (03/25/2019)
//   Mod by: Dani Beaubien (01/22/2021) - Simplied code
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)

Case of 
	: (Not:C34(STR_IsOneOf($path_to_file; "@.txt"; "@.tsv")))
	: (Not:C34(File_DoesExist($path_to_file)))
	Else 
		$is_file_tab_delimited:=File_IsDelimited($path_to_file; Char:C90(Tab:K15:37))
End case 
