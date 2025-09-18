//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// Array_ConvertToTextDelimited (arrayPtr{; delimiter}) : delimitedText
// 
// DESCRIPTION
//   Converts the passed array into a delimited
//   text string. The delimiter defaults to "," if not supplied.
//
C_POINTER:C301($1; $vp_arrayPtr)
C_TEXT:C284($2; $vt_theDelimiter)  // OPTIONAL
C_TEXT:C284($vt_delimitedText)
// ----------------------------------------------------
//   Created by: DB (04/20/07)
//   Mod by: Dani Beaubien (11/19/2021) - Refactored to use collection
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259>=1)
ASSERT:C1129(Count parameters:C259<=2)
$vp_arrayPtr:=$1
If (Count parameters:C259=2)
	$vt_theDelimiter:=$2
Else 
	$vt_theDelimiter:=","
End if 

ASSERT:C1129(PTR_IsArray($vp_arrayPtr); Current method name:C684+" $1 is not an array ptr.")

var $valueList : Collection
$valueList:=New collection:C1472()

ARRAY TO COLLECTION:C1563($valueList; $vp_arrayPtr->)
$vt_delimitedText:=$valueList.join($vt_theDelimiter)


$0:=$vt_delimitedText