//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// Array_ReduceToSortedUnique (ArrayPointer)
// 
// DESCRIPTION
//   This procedure scans the values of the array and 
//   removes all non-duplicates.
//
C_POINTER:C301($1; $ap_srcArray)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (07/17/2011) 
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)
$ap_srcArray:=$1

ASSERT:C1129(PTR_IsArray($ap_srcArray); Current method name:C684+" $1 is not an array ptr.")

If (Size of array:C274($ap_srcArray->)>1)
	var $list : Collection
	$list:=New collection:C1472()
	ARRAY TO COLLECTION:C1563($list; $ap_srcArray->)
	$list:=$list.distinct(ck ascending:K85:9)
	
	COLLECTION TO ARRAY:C1562($list; $ap_srcArray->)
End if 
