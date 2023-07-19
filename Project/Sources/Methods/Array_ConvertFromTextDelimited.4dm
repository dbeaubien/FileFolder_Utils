//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// Array_ConvertFromTextDelimited (ArrayPtr, srcText{; delimiter})
// Array_ConvertFromTextDelimited (pointer; text{; text})
//
// DESCRIPTION
//   Converts a delimited text string into values
//   in the passed text array.  The delimiter defaults to "," if not supplied.
//
C_POINTER:C301($1; $vp_arrayPtr)
C_TEXT:C284($2; $vt_srcTxt)
C_TEXT:C284($3; $theDelimiter)  // OPTIONAL
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (04/19/07)
//   Mod: DB (09/25/2012) - Fixed bug if last character of srcTxt is the delimiter
//   Mod: DB (09/25/2012) - Removed code that trimed extra spaces
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259>=2)
ASSERT:C1129(Count parameters:C259<=3)
$vp_arrayPtr:=$1
$vt_srcTxt:=$2
If (Count parameters:C259=3)
	$theDelimiter:=$3
Else 
	$theDelimiter:=","
End if 

If ($theDelimiter=Char:C90(Escape:K15:39)) | ($theDelimiter=Char:C90(1))  // work around a limitation of Split String
	$vt_srcTxt:=Replace string:C233($vt_srcTxt; $theDelimiter; "**ESCAPE**"; *)
	$theDelimiter:="**ESCAPE**"
End if 

var $valueList : Collection
$valueList:=Split string:C1554($vt_srcTxt; $theDelimiter)
COLLECTION TO ARRAY:C1562($valueList; $vp_arrayPtr->)
