//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// Method: Array_AddTextElement (arrayPtr; text item to add)

// This method appends the text item to the end of the array passed

ASSERT:C1129(2=Count parameters:C259; Current method name:C684+" expects 2 parm.")

C_POINTER:C301($1; $arrayPtr)
C_TEXT:C284($2; $itemText)
$arrayPtr:=$1
$itemText:=$2

APPEND TO ARRAY:C911($arrayPtr->; $itemText)
