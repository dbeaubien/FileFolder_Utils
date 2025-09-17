//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// Array_CopyAndRemoveDuplicates (srcArrayPtr; dstArrayPtr)
// Array_CopyAndRemoveDuplicates (pointer; pointer)
// 
// DESCRIPTION
//   Copies and then removes duplicate values from the array
//
C_POINTER:C301($1; $vp_srcArrayPtr)
C_POINTER:C301($2; $vp_dstArrayPtr)
// ----------------------------------------------------
// CALLED BY
//   
// ----------------------------------------------------
// HISTORY
//   Created by: DB (02/05/11)
//   Mod: DB (03/05/2013) - Ensure that the array is sorted
// ----------------------------------------------------

If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 2; Count parameters:C259))
	$vp_srcArrayPtr:=$1
	$vp_dstArrayPtr:=$2
	
	Array_Empty($vp_dstArrayPtr)
	Array_Copy($vp_srcArrayPtr; $vp_dstArrayPtr)
	
	SORT ARRAY:C229($vp_dstArrayPtr->; >)  //   Mod: DB (03/05/2013)
	
	C_LONGINT:C283($len; $i; $pos)
	$len:=Size of array:C274($vp_dstArrayPtr->)
	For ($i; 1; $len)
		$pos:=($len-$i)+1
		If ($pos>1)
			If ($vp_dstArrayPtr->{$pos}=$vp_dstArrayPtr->{$pos-1})  // remove the duplicate
				DELETE FROM ARRAY:C228($vp_dstArrayPtr->; $pos; 1)
			End if 
		End if 
	End for 
End if   // ASSERT
