//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
  // STR_GetLeftOfChar (textToSplit; pivotChar) : textToTheLeftOfPivotChar
  // STR_GetLeftOfChar (text; text) : text
  // 
  // DESCRIPTION
  //   Returns the text from the textToSplit that appears
  //   to the left of the first occurance of the pivotChar.
  //   Returns the full string if the pivotChar is not in the source.
  //
C_TEXT($1;$vt_textToSplit)
C_TEXT($2;$vt_pivotChar)
C_TEXT($0;$vt_textToTheLeftOfPivotChar)
  // ----------------------------------------------------
  // HISTORY
  //   Created by: DB (03/04/2015)
  // ----------------------------------------------------

$vt_textToTheLeftOfPivotChar:=""
If (Asserted(Count parameters=2))
$vt_textToSplit:=$1
$vt_pivotChar:=$2

C_LONGINT($pos)
$pos:=Position($vt_pivotChar;$vt_textToSplit)

If ($pos>0)
$vt_textToTheLeftOfPivotChar:=Substring($vt_textToSplit;1;$pos-1)
Else 
$vt_textToTheLeftOfPivotChar:=$vt_textToSplit
End if 

End if   // ASSERT
$0:=$vt_textToTheLeftOfPivotChar