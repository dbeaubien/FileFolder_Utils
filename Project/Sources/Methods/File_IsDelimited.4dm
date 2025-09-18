//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// File_IsDelimited (pathToFile; delimiterChar) : isDelimited
// File_IsDelimited (text) : boolean
//
// DESCRIPTION
//   Returns true if the file is a delimited with the supplied delimiter.
//
// TESTS performed:
//   1. Is file extension ".txt"
//   2. Look at first line, expect line of delimited values.
//   3. At least 2 non-empty values in the header line.
//   4. delimiter is a single character
//
#DECLARE($path_to_file : Text; $delimiter : Text)->$is_file_delimited : Boolean
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (01/22/2021) - support any delimiter
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=2)

Case of 
	: (Not:C34(STR_IsOneOf($path_to_file; "@.csv"; "@.txt")))
	: (Not:C34(File_DoesExist($path_to_file)))
	Else 
		var $document_reference : Time
		$document_reference:=Open document:C264($path_to_file; ""; Read mode:K24:5)
		If (OK=1)
			FileBuffer_Init($document_reference)
			
			var $end_of_line : Text
			$end_of_line:=FileBuffer_TellMeTheEOL
			
			ARRAY TEXT:C222($valuesArr; 0)
			FileBuffer_FetchDelimitedLne($end_of_line; ->$valuesArr; $delimiter)
			
			// Must have more than one element
			$is_file_delimited:=(Size of array:C274($valuesArr)>1)
			
			CLOSE DOCUMENT:C267($document_reference)
		End if 
		
End case 
