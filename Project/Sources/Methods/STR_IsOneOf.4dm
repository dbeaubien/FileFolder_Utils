//%attributes = {"invisible":true,"preemptive":"capable"}
// STR_IsOneOf (srcTxt; choice1; ... ; choiceN) : match
// STR_IsOneOf (txt; txt; ... ; txt) : boolean
// 
// DESCRIPTION
//   Returns true is the first parameter matches one of the other
//   parameters. Use this method to see if the value is part of a
//   certain list.
//
#DECLARE($source_text : Text;  ...  : Text) : Boolean
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259>=2; Current method name:C684+" expects at least 2 paramters.")

var $index : Integer
For ($index; 2; Count parameters:C259)
	If ($source_text=${$index})
		return True:C214
	End if 
End for 

return False:C215