//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// File_GetHeadersFromFirstRow (filePath; headerLabelsArrPtr)
//
// DESCRIPTION
//   Opens the file, and loads the header labels from the first row.
//   If the file doesn't exist then an empty array is returned.
//    If the file is not a CSV or a TSV then the first row is returned
//   as the only element of the array.
//
C_TEXT:C284($1; $filePath)
C_POINTER:C301($2; $headerLabelsArrPtr)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (08/21/2019)
//   Mod by: Dani Beaubien (01/22/2021) - support pipe delimiter
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=2)
$filePath:=$1
$headerLabelsArrPtr:=$2

Array_Empty($headerLabelsArrPtr)

If (File_DoesExist($filePath))
	C_TEXT:C284($fileType)
	Case of 
		: (File_IsTabDelimited($filePath))
			$fileType:="TSV"
		: (File_IsDelimited($filePath; "|"))
			$fileType:="pipe"
		: (File_IsCSV($filePath))
			$fileType:="CSV"
		Else 
			$fileType:="unknown"
	End case 
	
	C_TIME:C306($docRef)
	$docRef:=Open document:C264($filePath; ""; Read mode:K24:5)
	If (OK=1)
		FileBuffer_Init($docRef)
		
		C_TEXT:C284($eol)
		$eol:=FileBuffer_TellMeTheEOL
		
		Case of 
			: ($fileType="CSV")
				FileBuffer_FetchCSVLine($eol; $headerLabelsArrPtr)
				
			: ($fileType="TSV")
				FileBuffer_FetchTabDelimitedLne($eol; $headerLabelsArrPtr)
				
			: ($fileType="pipe")
				FileBuffer_FetchDelimitedLne($eol; $headerLabelsArrPtr; "|")
				
			Else 
				APPEND TO ARRAY:C911($headerLabelsArrPtr->; FileBuffer_FetchData_ByString($eol))
				$headerLabelsArrPtr->{1}:=Replace string:C233($headerLabelsArrPtr->{1}; $eol; "")
		End case 
		
		var $i : Integer
		For ($i; 1; Size of array:C274($headerLabelsArrPtr->))  // clean up headers
			$headerLabelsArrPtr->{$i}:=STR_TrimExcessSpaces($headerLabelsArrPtr->{$i})
		End for 
		
		CLOSE DOCUMENT:C267($docRef)
	End if 
End if 