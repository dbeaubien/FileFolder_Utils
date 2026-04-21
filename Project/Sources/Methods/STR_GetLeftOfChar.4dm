//%attributes = {"invisible":true,"preemptive":"capable"}
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
ASSERT:C1129(Count parameters:C259=2)

var $pos : Integer
$pos:=Position:C15($vt_pivotChar; $vt_textToSplit)

$vt_textToTheLeftOfPivotChar:=($pos>0) ? Substring:C12($vt_textToSplit; 1; $pos-1) : $vt_textToSplit