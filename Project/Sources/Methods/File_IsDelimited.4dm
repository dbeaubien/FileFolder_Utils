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
C_TEXT:C284($1; $pathToFile)
C_TEXT:C284($2; $delimiterChar)
C_BOOLEAN:C305($0; $isDelimited)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (01/22/2021) - support any delimiter
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=2)
$pathToFile:=$1
$delimiterChar:=$2
$isDelimited:=False:C215

Case of 
	: (Not:C34(STR_IsOneOf($pathToFile; "@.csv"; "@.txt")))
	: (Not:C34(File_DoesExist($pathToFile)))
	Else 
		C_TIME:C306($docRef)
		$docRef:=Open document:C264($pathToFile; ""; Read mode:K24:5)
		If (OK=1)
			FileBuffer_Init($docRef)
			
			C_TEXT:C284($eol)
			$eol:=FileBuffer_TellMeTheEOL
			
			ARRAY TEXT:C222($valuesArr; 0)
			FileBuffer_FetchDelimitedLne($eol; ->$valuesArr; $delimiterChar)
			
			// Must have more than one element
			$isDelimited:=(Size of array:C274($valuesArr)>1)
			
			CLOSE DOCUMENT:C267($docRef)
		End if 
		
End case 

$0:=$isDelimited