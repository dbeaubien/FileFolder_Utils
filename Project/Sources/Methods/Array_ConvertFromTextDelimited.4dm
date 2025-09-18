//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// Array_ConvertFromTextDelimited (ArrayPtr, srcText{; delimiter})
// Array_ConvertFromTextDelimited (pointer; text{; text})
//
// DESCRIPTION
//   Converts a delimited text string into values
//   in the passed text array.  The delimiter defaults to "," if not supplied.
//
#DECLARE($vp_arrayPtr : Pointer; $source_text : Text; $delimiter : Text)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (04/19/07)
//   Mod: DB (09/25/2012) - Fixed bug if last character of srcTxt is the delimiter
//   Mod: DB (09/25/2012) - Removed code that trimed extra spaces
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259>=2)
ASSERT:C1129(Count parameters:C259<=3)

If (Count parameters:C259<3)
	$delimiter:=","
End if 

If ($delimiter=Char:C90(Escape:K15:39)) || ($delimiter=Char:C90(1))  // work around a limitation of Split String
	$source_text:=Replace string:C233($source_text; $delimiter; "**ESCAPE**"; *)
	$delimiter:="**ESCAPE**"
End if 

var $valueList : Collection
$valueList:=Split string:C1554($source_text; $delimiter)
COLLECTION TO ARRAY:C1562($valueList; $vp_arrayPtr->)
