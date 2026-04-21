//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// File_IsCSV (pathToFile) : isCSV
// File_IsCSV (text) : boolean
//
// DESCRIPTION
//   Returns true if the file is a CSV.
//   Recognizes a 1st line of of the csv file is a "sep=" line.
//
// TESTS performed:
//   1. Is file extension ".csv" or ".txt"
//   2. Look at first line, expect line of comma separated values.
//   3. At least 2 non-empty values in the header line.
//
#DECLARE($path_to_file : Text)->$is_file_csv : Boolean
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)

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
			FileBuffer_FetchCSVLine($end_of_line; ->$valuesArr)
			
			// Must have more than one element
			$is_file_csv:=(Size of array:C274($valuesArr)>1)
			
			CLOSE DOCUMENT:C267($document_reference)
		End if 
		
End case 
