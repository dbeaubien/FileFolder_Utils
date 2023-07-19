//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// CSV_LineIsComplete (lineToCheck; separator) : isComplete
//
// DESCRIPTION
//   Returns true if the lineToCheck is a complete CSV line.
//   In other words, the last field in the line is complete
//   and that there is no embedded new line in quotes.
//
#DECLARE($lineToCheck : Text; $separator : Text)->$isComplete : Boolean
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (03/29/2021)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=2)
$isComplete:=True:C214

// Scan for values that are in quotes
var $value : Text
var $inQuotedValue : Boolean
For each ($value; Split string:C1554($lineToCheck; $separator))
	
	If (Not:C34($inQuotedValue) & ($value="@\"@"))  // contains quotes
		If ($value="\"@")
			$value:=Substring:C12($value; 2)  // trim opening quote
		End if 
		$inQuotedValue:=True:C214
	End if 
	
	If ($inQuotedValue)
		$value:=Replace string:C233($value; "\"\""; "")  // get rid of the double quotes so it doesn't mess up our ending quote check
		If ($value="@\"")  // ending quote of a quoted value
			$inQuotedValue:=False:C215
			$value:=Substring:C12($value; 1; Length:C16($value)-1)  // strip the trailing quote
		End if 
	End if 
	
End for each 

$isComplete:=Not:C34($inQuotedValue)