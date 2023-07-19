//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// Method: Array_Empty (array of values)
// Method: Array_Empty (pointer to array)
// 
// DESCRIPTION
//   Removes any and all elements in the array
//
C_POINTER:C301($1; $arrayPtr)
// ----------------------------------------------------
// HISTORY
//    Created by: DB (09/19/04)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)
$arrayPtr:=$1

ASSERT:C1129(PTR_IsArray($arrayPtr); Current method name:C684+" $1 is not an array ptr.")

var $type : Integer
$type:=Type:C295($arrayPtr->)

Case of 
	: ($type=Blob array:K8:30)
		ARRAY BLOB:C1222($arrayPtr->; 0)
		
	: ($type=Boolean array:K8:21)
		ARRAY BOOLEAN:C223($arrayPtr->; 0)
		
	: ($type=Date array:K8:20)
		ARRAY DATE:C224($arrayPtr->; 0)
		
	: ($type=Integer array:K8:18)
		ARRAY INTEGER:C220($arrayPtr->; 0)
		
	: ($type=LongInt array:K8:19)
		ARRAY LONGINT:C221($arrayPtr->; 0)
		
	: ($type=Object array:K8:28)
		ARRAY OBJECT:C1221($arrayPtr->; 0)
		
	: ($type=Picture array:K8:22)
		ARRAY PICTURE:C279($arrayPtr->; 0)
		
	: ($type=Pointer array:K8:23)
		ARRAY POINTER:C280($arrayPtr->; 0)
		
	: ($type=Real array:K8:17)
		ARRAY REAL:C219($arrayPtr->; 0)
		
	: ($type=Text array:K8:16)
		ARRAY TEXT:C222($arrayPtr->; 0)
		
	: ($type=Time array:K8:29)
		ARRAY TIME:C1223($arrayPtr->; 0)
		
End case 
