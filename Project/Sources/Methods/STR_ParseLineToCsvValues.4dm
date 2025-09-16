//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// STR_ParseLineToCsvValues (csvLineAsText{; separator}) : values
// STR_ParseLineToCsvValues (text{, text}) : collection
//
// DESCRIPTION
//   Converts a line is csv text into a collection of the values.
//
#DECLARE($csv_line_as_text : Text; $separator : Text)
var $values : Collection
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (05/25/2020)
// ----------------------------------------------------
$values:=[]
ASSERT:C1129((Count parameters:C259=1) | (Count parameters:C259=2))
If ($separator="")
	$separator:=","
End if 

$values:=Split string:C1554($csv_line_as_text; $separator)

// Scan for values that are in quotes
var $in_quoted_value : Boolean
var $element_number : Integer
var $elements_to_merge_to_previous : Collection
var $temporary_value : Text

$elements_to_merge_to_previous:=[]
For ($element_number; 0; $values.length-1)
	If ($values[$element_number]="\"\"")  // handle special case of an empty value that is quoted
		$values[$element_number]:=""
	End if 
	
	$temporary_value:=$values[$element_number]
	$temporary_value:=Replace string:C233($temporary_value; "\"\""; "")  // strip double quotes to make our checks easier
	
	Case of 
		: ($in_quoted_value)
			$elements_to_merge_to_previous.push($element_number)
			If ($temporary_value="@\"")  // ending quote of a quoted value
				$in_quoted_value:=False:C215
				$values[$element_number]:=Substring:C12($values[$element_number]; 1; Length:C16($values[$element_number])-1)  // strip the trailing quote
			End if 
			$values[$element_number]:=Replace string:C233($values[$element_number]; "\"\""; "\"")  // replace double quotes with single quotes
			
			
		: ($temporary_value="\"@\"")  // starts and ends with a quote
			$values[$element_number]:=Substring:C12($values[$element_number]; 2; Length:C16($values[$element_number])-2)  // strip the leading and trailing quotes
			$values[$element_number]:=Replace string:C233($values[$element_number]; "\"\""; "\"")  // replace double quotes with single quotes
			
			
		: ($temporary_value="\"@")  // starts with a quote
			$in_quoted_value:=True:C214
			$values[$element_number]:=Substring:C12($values[$element_number]; 2)  // strip the leading quote
			$values[$element_number]:=Replace string:C233($values[$element_number]; "\"\""; "\"")  // replace double quotes with single quotes
			
			
		Else 
			// nothing to do
	End case 
End for 

// Merge and clean up the collection
$elements_to_merge_to_previous:=$elements_to_merge_to_previous.orderBy(ck descending:K85:8)
For each ($element_number; $elements_to_merge_to_previous)
	$values[$element_number-1]:=$values[$element_number-1]+$separator+$values[$element_number]
	$values.remove($element_number)
End for each 
