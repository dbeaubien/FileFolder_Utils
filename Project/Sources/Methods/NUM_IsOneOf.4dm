//%attributes = {"invisible":true,"preemptive":"capable"}
// NUM_IsOneOf (srcNum; choice1; ... ; choiceN) : match
// 
// DESCRIPTION
//   Returns true is the first parameter matches one of the other
//   parameters. Use this method to see if the value is part of a
//   certain list.
//
#DECLARE($srcNumber : Integer;  ...  : Integer)->$matchWasFound : Boolean
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259>=2; Current method name:C684+" expects at least 2 paramters.")

var $i : Integer
For ($i; 2; Count parameters:C259)
	If ($srcNumber=${$i})
		$matchWasFound:=True:C214
		break
	End if 
End for 
