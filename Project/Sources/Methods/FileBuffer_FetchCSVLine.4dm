//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// FileBuffer_FetchCSVLine (eol ; array of values)
// FileBuffer_FetchCSVLine (text ; pointer to text array)
//
// DESCRIPTION
//   Populates the array with the parsed values from the line.
//   Recognizes a 1st line of "sep=" line.
//
#DECLARE($end_of_line : Text; $valuesArrayPtr : Pointer)
ASSERT:C1129(Count parameters:C259=2)

var fileBuffer_csv_separator : Text  // defaulted to "," in FileBuffer_Init

var $next_line : Text
If (FileBuffer_GetFilePostion<=1)  // first line; check to see if we have a "sep=" line
	$next_line:=FileBuffer_FetchData_PeekAhead(50)  // grab some stuff
	$next_line:=STR_GetLeftOfChar($next_line; $end_of_line)  // reduce down to the line
	If ($next_line="sep=@") && ((Length:C16($next_line)=5) || (Length:C16($next_line)=6))  // check that we have a 1 or 2 char delimiter
		fileBuffer_csv_separator:=Replace string:C233($next_line; "sep="; "")
		$next_line:=FileBuffer_FetchData_ByString($end_of_line)  // fetch the first line so that it is skipped
	End if 
End if 
$next_line:=FileBuffer_FetchData_ByString($end_of_line)  // fetch so at the start of the next value

var $buffer; $line_to_test : Text
If ($next_line=("@"+$end_of_line))  // strip out our EOL
	$line_to_test:=Substring:C12($next_line; 1; Length:C16($next_line)-Length:C16($end_of_line))
Else 
	$line_to_test:=$next_line
End if 
While (Not:C34(CSV_LineIsComplete($line_to_test; fileBuffer_csv_separator)) && (Not:C34(FileBuffer_EOF)))
	$next_line:=$next_line+FileBuffer_FetchData_ByString($end_of_line)  // fetch so at the start of the next value
	If ($next_line=("@"+$end_of_line))  // strip out our EOL
		$line_to_test:=Substring:C12($next_line; 1; Length:C16($next_line)-Length:C16($end_of_line))
	Else 
		$line_to_test:=$next_line
	End if 
End while 

If ($next_line=("@"+$end_of_line))  // strip out our EOL
	$line_to_test:=Substring:C12($next_line; 1; Length:C16($next_line)-Length:C16($end_of_line))
Else 
	$line_to_test:=$next_line
End if 
var $values_list : Collection
$values_list:=STR_ParseLineToCsvValues($line_to_test; fileBuffer_csv_separator)
Array_Empty($valuesArrayPtr)
If ($values_list.length>0)
	COLLECTION TO ARRAY:C1562($values_list; $valuesArrayPtr->)
Else 
	APPEND TO ARRAY:C911($valuesArrayPtr->; "")  // always at least 1 value
End if 
