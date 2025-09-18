//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// Method: Array_AddLongintElement_UNIQUE (arrayPtr; Longint item to add)

// This method appends the Longint item to the end of the array passed

ASSERT:C1129(2=Count parameters:C259; Current method name:C684+" expects 2 parm.")

C_POINTER:C301($1; $arrayPtr)
C_LONGINT:C283($2; $itemLongint)
$arrayPtr:=$1
$itemLongint:=$2

C_LONGINT:C283($pos)
$pos:=Find in array:C230($arrayPtr->; $itemLongint)
If ($pos<1)
	$pos:=Size of array:C274($arrayPtr->)+1
	INSERT IN ARRAY:C227($arrayPtr->; $pos; 1)  // add an element
	$arrayPtr->{$pos}:=$itemLongint
End if 
