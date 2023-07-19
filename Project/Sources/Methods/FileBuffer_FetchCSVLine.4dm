//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// FileBuffer_FetchCSVLine (eol ; array of values)
// FileBuffer_FetchCSVLine (text ; pointer to text array)
//
// DESCRIPTION
//   Populates the array with the parsed values from the line.
//   Recognizes a 1st line of "sep=" line.
//

C_TEXT:C284($1; $eol)
C_POINTER:C301($2; $valuesArrayPtr)
ASSERT:C1129(Count parameters:C259=2)
$eol:=$1
$valuesArrayPtr:=$2

C_TEXT:C284(fileBuffer_csv_separator)  // defaulted to "," in FileBuffer_Init

var $nextLine : Text
If (FileBuffer_GetFilePostion<=1)  // first line; check to see if we have a "sep=" line
	$nextLine:=FileBuffer_FetchData_PeekAhead(50)  // grab some stuff
	$nextLine:=STR_GetLeftOfChar($nextLine; $eol)  // reduce down to the line
	If ($nextLine="sep=@") & ((Length:C16($nextLine)=5) | (Length:C16($nextLine)=6))  // check that we have a 1 or 2 char delimiter
		fileBuffer_csv_separator:=Replace string:C233($nextLine; "sep="; "")
		$nextLine:=FileBuffer_FetchData_ByString($eol)  // fetch the first line so that it is skipped
	End if 
End if 
$nextLine:=FileBuffer_FetchData_ByString($eol)  // fetch so at the start of the next value

var $buffer; $lineToTest : Text
If ($nextLine=("@"+$eol))  // strip out our EOL
	$lineToTest:=Substring:C12($nextLine; 1; Length:C16($nextLine)-Length:C16($eol))
Else 
	$lineToTest:=$nextLine
End if 
While (Not:C34(CSV_LineIsComplete($lineToTest; fileBuffer_csv_separator)) & (Not:C34(FileBuffer_EOF)))
	$nextLine:=$nextLine+FileBuffer_FetchData_ByString($eol)  // fetch so at the start of the next value
	If ($nextLine=("@"+$eol))  // strip out our EOL
		$lineToTest:=Substring:C12($nextLine; 1; Length:C16($nextLine)-Length:C16($eol))
	Else 
		$lineToTest:=$nextLine
	End if 
End while 

If ($nextLine=("@"+$eol))  // strip out our EOL
	$lineToTest:=Substring:C12($nextLine; 1; Length:C16($nextLine)-Length:C16($eol))
Else 
	$lineToTest:=$nextLine
End if 
C_COLLECTION:C1488($valuesList)
$valuesList:=STR_ParseLineToCsvValues($lineToTest; fileBuffer_csv_separator)
Array_Empty($valuesArrayPtr)
If ($valuesList.length>0)
	COLLECTION TO ARRAY:C1562($valuesList; $valuesArrayPtr->)
Else 
	APPEND TO ARRAY:C911($valuesArrayPtr->; "")  // always at least 1 value
End if 
