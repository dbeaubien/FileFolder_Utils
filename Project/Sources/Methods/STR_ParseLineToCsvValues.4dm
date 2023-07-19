//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// STR_ParseLineToCsvValues (csvLineAsText{; separator}) : values
// STR_ParseLineToCsvValues (text{, text}) : collection
//
// DESCRIPTION
//   Converts a line is csv text into a collection of the values.
//
C_TEXT:C284($1; $csvLineAsText)
C_TEXT:C284($2; $separator)  // optional, defaults to ","
C_COLLECTION:C1488($values)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (05/25/2020)
// ----------------------------------------------------

$values:=New collection:C1472
If (Asserted:C1132((Count parameters:C259=1) | (Count parameters:C259=2)))
	$csvLineAsText:=$1
	If (Count parameters:C259=2)
		$separator:=$2
	End if 
	If ($separator="")
		$separator:=","
	End if 
	
	$values:=Split string:C1554($csvLineAsText; $separator)
	
	// Scan for values that are in quotes
	var $inQuotedValue : Boolean
	var $elementNo : Integer
	var $elementsToMergeToPrevious : Collection
	var $tmpValue : Text
	
	$elementsToMergeToPrevious:=New collection:C1472
	For ($elementNo; 0; $values.length-1)
		If ($values[$elementNo]="\"\"")  // handle special case of an empty value that is quoted
			$values[$elementNo]:=""
		End if 
		
		$tmpValue:=$values[$elementNo]
		$tmpValue:=Replace string:C233($tmpValue; "\"\""; "")  // strip double quotes to make our checks easier
		
		Case of 
			: ($inQuotedValue)
				$elementsToMergeToPrevious.push($elementNo)
				If ($tmpValue="@\"")  // ending quote of a quoted value
					$inQuotedValue:=False:C215
					$values[$elementNo]:=Substring:C12($values[$elementNo]; 1; Length:C16($values[$elementNo])-1)  // strip the trailing quote
				End if 
				$values[$elementNo]:=Replace string:C233($values[$elementNo]; "\"\""; "\"")  // replace double quotes with single quotes
				
				
			: ($tmpValue="\"@\"")  // starts and ends with a quote
				$values[$elementNo]:=Substring:C12($values[$elementNo]; 2; Length:C16($values[$elementNo])-2)  // strip the leading and trailing quotes
				$values[$elementNo]:=Replace string:C233($values[$elementNo]; "\"\""; "\"")  // replace double quotes with single quotes
				
				
			: ($tmpValue="\"@")  // starts with a quote
				$inQuotedValue:=True:C214
				$values[$elementNo]:=Substring:C12($values[$elementNo]; 2)  // strip the leading quote
				$values[$elementNo]:=Replace string:C233($values[$elementNo]; "\"\""; "\"")  // replace double quotes with single quotes
				
				
			Else 
				// nothing to do
		End case 
	End for 
	
	// Merge and clean up the collection
	$elementsToMergeToPrevious:=$elementsToMergeToPrevious.orderBy(ck descending:K85:8)
	For each ($elementNo; $elementsToMergeToPrevious)
		$values[$elementNo-1]:=$values[$elementNo-1]+$separator+$values[$elementNo]
		$values.remove($elementNo)
	End for each 
	
End if 
$0:=$values
