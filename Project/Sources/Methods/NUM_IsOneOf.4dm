//%attributes = {"invisible":true,"preemptive":"capable"}
// NUM_IsOneOf (srcNum; choice1; ... ; choiceN) : match
// 
// DESCRIPTION
//   Returns true is the first parameter matches one of the other
//   parameters. Use this method to see if the value is part of a
//   certain list.
//
C_LONGINT:C283($1; $srcNumber)
C_LONGINT:C283(${2})  // values to match against
C_BOOLEAN:C305($0; $matchWasFound)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (04/14/2021)
// ----------------------------------------------------

$matchWasFound:=False:C215
If (Asserted:C1132(Count parameters:C259>=2; Current method name:C684+" expects at least 2 paramters."))
	$srcNumber:=$1
	
	C_LONGINT:C283($i)
	For ($i; 2; Count parameters:C259)
		If ($srcNumber=${$i})
			$matchWasFound:=True:C214
			$i:=10000  // break the loop
		End if 
	End for 
	
End if 
$0:=$matchWasFound