//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// Array_AddTextElement_Prepend (arrayPtr; text item to add)
//
// Adds the text item to the beginning of the array

ASSERT:C1129(2=Count parameters:C259; Current method name:C684+" expects 2 parm.")

C_POINTER:C301($1; $arrayPtr)
C_TEXT:C284($2; $itemText)
$arrayPtr:=$1
$itemText:=$2

INSERT IN ARRAY:C227($arrayPtr->; 1; 1)
$arrayPtr->{1}:=$itemText