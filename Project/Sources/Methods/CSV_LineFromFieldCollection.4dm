//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// CSV_LineFromFieldCollection (collection; eol) : csvLine
//
// DESCRIPTION
//   Takes a collection of field pointers and returns a
//   properly formatted CSV line.
//   The csv line will end with the EOL.
//
C_COLLECTION:C1488($1; $collection)
C_TEXT:C284($2; $eol)
C_TEXT:C284($0; $csvLine)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (06/05/2020)
// ----------------------------------------------------

$csvLine:=""
If (Asserted:C1132(Count parameters:C259=2))
	$collection:=$1
	$eol:=$2
	
	C_LONGINT:C283($itemType)
	C_VARIANT:C1683($item; $ptr)
	C_TEXT:C284($someText; $encodedText)
	For each ($item; $collection)
		If ($csvLine#"")
			$csvLine:=$csvLine+","
		End if 
		
		If (Value type:C1509($item)=Is pointer:K8:14)
			$itemType:=Type:C295($item->)
			Case of 
				: ($itemType=Is longint:K8:6) | ($itemType=Is integer:K8:5)
					$csvLine:=$csvLine+String:C10($item->)
					
				: ($itemType=Is real:K8:4)
					$csvLine:=$csvLine+String:C10($item->; "&xml")
					
				: ($itemType=Is text:K8:3) | ($itemType=Is alpha field:K8:1) | ($itemType=Is string var:K8:2)
					$someText:=$item->
					If ($someText="@\"@")
						$someText:=Replace string:C233($someText; "\""; "\"\""; *)
					End if 
					$csvLine:=$csvLine+"\""+$someText+"\""
					
				: ($itemType=Is boolean:K8:9)
					$csvLine:=$csvLine+Choose:C955($item->; "true"; "false")
					
				: ($itemType=Is object:K8:27)
					$someText:=JSON Stringify:C1217($item->)
					$someText:="\""+Replace string:C233($someText; "\""; "\"\""; *)+"\""
					$csvLine:=$csvLine+$someText
					
				: ($itemType=Is time:K8:8)
					$csvLine:=$csvLine+String:C10($item->; HH MM SS:K7:1)
					
				: ($itemType=Is date:K8:7)
					$csvLine:=$csvLine+String:C10(Year of:C25($item->); "0000")+"-"+String:C10(Month of:C24($item->); "00")+"-"+String:C10(Day of:C23($item->); "00")  // yyyy-mm-dd
					
				: ($itemType=Is BLOB:K8:12)
					If (BLOB size:C605($item->)=0)
						$csvLine:=$csvLine+""
					Else 
						BASE64 ENCODE:C895($item->; $encodedText)
						$csvLine:=$csvLine+"blob:base64:"+String:C10(BLOB size:C605($item->))+":"+$encodedText
					End if 
					
				: ($itemType=Is picture:K8:10)
					If (Picture size:C356($item->)=0)
						$csvLine:=$csvLine+""
					Else 
						C_BLOB:C604($pictureAsBlob)
						VARIABLE TO BLOB:C532($item->; $pictureAsBlob)
						BASE64 ENCODE:C895($pictureAsBlob; $encodedText)
						$csvLine:=$csvLine+"pictureBlob:base64:"+String:C10(Picture size:C356($item->))+":"+$encodedText
					End if 
					
				Else 
					TRACE:C157
					
			End case 
		End if 
	End for each 
	
	$csvLine:=$csvLine+$eol
End if 
$0:=$csvLine