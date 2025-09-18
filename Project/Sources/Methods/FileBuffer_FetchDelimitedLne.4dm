//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// FileBuffer_FetchDelimitedLne (eol ; array of values; delimiterChar) 
// FileBuffer_FetchDelimitedLne (eol ; array of values; text)
//
// DESCRIPTION
//   Fills the array with the next line of  delimited values
//   from the open file.
//
#DECLARE($end_of_line : Text; $vp_valuesArrayPtr : Pointer; $delimiter : Text)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (01/22/2021) - support any delimiter
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=3)
Array_Empty($vp_valuesArrayPtr)

var $next_line : Text
$next_line:=FileBuffer_FetchData_ByString($end_of_line)  // fetch so at the start of the next value
If ($next_line=("@"+$end_of_line))  // strip out our EOL
	$next_line:=Substring:C12($next_line; 1; Length:C16($next_line)-Length:C16($end_of_line))
End if 

If ($next_line#"")
	Array_ConvertFromTextDelimited($vp_valuesArrayPtr; $next_line; $delimiter)
End if 
