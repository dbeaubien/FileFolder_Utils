//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// Method: Array_AddPtrElement (arrayPtr; Pointer to add)

// This method appends the Pointer to the end of the array passed

ASSERT:C1129(2=Count parameters:C259; Current method name:C684+" expects 2 parm.")

C_POINTER:C301($1; $arrayPtr)
C_POINTER:C301($2; $itemPtr)
$arrayPtr:=$1
$itemPtr:=$2

APPEND TO ARRAY:C911($arrayPtr->; $itemPtr)