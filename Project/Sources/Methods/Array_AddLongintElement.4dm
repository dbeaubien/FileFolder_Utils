//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// Array_AddLongintElement (arrayPtr; longint)
//
// DESCRIPTION
//   appends the Longint item to the end of the array passed.
//
C_POINTER:C301($1; $arrayPtr)
C_LONGINT:C283($2; $itemLongint)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (02/25/2020)
// ----------------------------------------------------

If (Asserted:C1132(Count parameters:C259=2))
	$arrayPtr:=$1
	$itemLongint:=$2
	
	ASSERT:C1129(PTR_IsArray($arrayPtr); Current method name:C684+" $1 is not an array ptr.")
	
	APPEND TO ARRAY:C911($arrayPtr->; $itemLongint)
End if 