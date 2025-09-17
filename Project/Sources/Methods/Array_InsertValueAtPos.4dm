//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// Array_InsertValueAtPos (pos, arrayPtr, valueToInsertPtr) 
// Array_InsertValueAtPos (longint, pointer, pointer) 
//
// DESCRIPTION
//   Inserts the value into the array at the specified position.
//   Anything less that 1 will put it at the beginning.
//   Anything greater than the array size will put it at the end.
//
C_LONGINT:C283($1; $pos)
C_POINTER:C301($2; $arrayPtr)
C_POINTER:C301($3; $valueToInsertPtr)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (02/16/2019)
// ----------------------------------------------------

If (Asserted:C1132(Count parameters:C259=3))
	$pos:=$1
	$arrayPtr:=$2
	$valueToInsertPtr:=$3
	
	Case of 
		: ($pos<1)
			INSERT IN ARRAY:C227($arrayPtr->; 1; 1)
			$arrayPtr->{1}:=$valueToInsertPtr->
			
		: ($pos>Size of array:C274($arrayPtr->))
			APPEND TO ARRAY:C911($arrayPtr->; $valueToInsertPtr->)
			
		Else 
			INSERT IN ARRAY:C227($arrayPtr->; $pos; 1)
			$arrayPtr->{$pos}:=$valueToInsertPtr->
	End case 
	
End if 
