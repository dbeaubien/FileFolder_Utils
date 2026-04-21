//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// CSV_LineFromCollection (collection; eol) : csvLine
//
// DESCRIPTION
//   Takes a collection of scalar values and returns a
//   properly formatted CSV line.
//   The csv line will end with the EOL.
//   NOTE: 4D time scalars are converted to longints.
//
#DECLARE($collection : Collection; $eol : Text)->$csvLine : Text
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=2)

var $itemType : Integer
var $someText : Text
var $item; $ptr : Variant
For each ($item; $collection)
	If ($csvLine#"")
		$csvLine:=$csvLine+","
	End if 
	
	$itemType:=Value type:C1509($item)
	Case of 
		: ($itemType=Is longint:K8:6) || ($itemType=Is integer:K8:5)
			$csvLine:=$csvLine+String:C10($item)
			
		: ($itemType=Is real:K8:4)
			$csvLine:=$csvLine+String:C10($item; "&xml")
			
		: ($itemType=Is text:K8:3) || ($itemType=Is alpha field:K8:1) || ($itemType=Is string var:K8:2)
			$someText:=$item
			If ($someText="@\"@")
				$someText:=Replace string:C233($someText; "\""; "\"\""; *)
			End if 
			$csvLine:=$csvLine+"\""+$someText+"\""
			
		: ($itemType=Is boolean:K8:9)
			$csvLine:=$csvLine+Choose:C955($item; "true"; "false")
			
		: ($itemType=Is object:K8:27)
			$someText:=JSON Stringify:C1217($item)
			$someText:="\""+Replace string:C233($someText; "\""; "\"\""; *)+"\""
			$csvLine:=$csvLine+$someText
			
		: ($itemType=Is time:K8:8)
			$csvLine:=$csvLine+String:C10($item; HH MM SS:K7:1)
			
		: ($itemType=Is date:K8:7)
			$csvLine:=$csvLine+String:C10(Year of:C25($item); "0000")+"-"+String:C10(Month of:C24($item); "00")+"-"+String:C10(Day of:C23($item); "00")  // yyyy-mm-dd
			
		: ($itemType=Is BLOB:K8:12)
			$csvLine:=$csvLine+"BLOB FIELD TYPE NOT SUPPORTED"
			
		: ($itemType=Is picture:K8:10)
			$csvLine:=$csvLine+"PICTURE FIELD TYPE NOT SUPPORTED"
			
		Else 
			TRACE:C157
			
	End case 
End for each 

$csvLine+=$eol