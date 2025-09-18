//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// STR_GetLeftOfChar (textToSplit; pivotChar) : textToTheLeftOfPivotChar
// STR_GetLeftOfChar (text; text) : text
// 
// DESCRIPTION
//   Returns the text from the textToSplit that appears
//   to the left of the first occurance of the pivotChar.
//   Returns the full string if the pivotChar is not in the source.
//
#DECLARE($vt_textToSplit : Text; $vt_pivotChar : Text)->$vt_textToTheLeftOfPivotChar : Text
// ----------------------------------------------------
// HISTORY
//   Created by: DB (03/04/2015)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=2)
$vt_textToTheLeftOfPivotChar:=""

var $pos : Integer
$pos:=Position:C15($vt_pivotChar; $vt_textToSplit)

If ($pos>0)
	$vt_textToTheLeftOfPivotChar:=Substring:C12($vt_textToSplit; 1; $pos-1)
Else 
	$vt_textToTheLeftOfPivotChar:=$vt_textToSplit
End if 
