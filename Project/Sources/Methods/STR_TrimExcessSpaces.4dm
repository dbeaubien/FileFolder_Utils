//%attributes = {"invisible":true,"preemptive":"capable"}
// STR_TrimExcessSpaces (srcTxt) : resultTxt
// 
// DESCRIPTION
//   Removes any beginning / trailing spaces (and NBSP) from the string
//   Need to take care not to remove any spaces that are "inside" the string
//
#DECLARE($vt_srcTxt : Text)->$resultTxt : Text
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)

$resultTxt:=STR_TrimExcessCharacter($vt_srcTxt; Char:C90(Space:K15:42))
$resultTxt:=STR_TrimExcessCharacter($resultTxt; Char:C90(NBSP ASCII CODE:K15:43))