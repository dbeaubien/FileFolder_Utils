//%attributes = {"invisible":true,"preemptive":"capable"}
// STR_IsOneOf (srcTxt; choice1; ... ; choiceN) : match
// STR_IsOneOf (txt; txt; ... ; txt) : boolean
// 
// DESCRIPTION
//   Returns true is the first parameter matches one of the other
//   parameters. Use this method to see if the value is part of a
//   certain list.
//
// #DECLARE($source_text : Text; ... : Text)->$match_was_found : Boolean
C_TEXT:C284($1; $source_text)
C_TEXT:C284(${2})  // values to match against
C_BOOLEAN:C305($0; $match_was_found)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (11/05/09)
// ----------------------------------------------------

ASSERT:C1129(Count parameters:C259>=2; Current method name:C684+" expects at least 2 paramters.")

var $index : Integer
For ($index; 2; Count parameters:C259)
	If ($source_text=${$index})
		$match_was_found:=True:C214
		return 
	End if 
End for 
