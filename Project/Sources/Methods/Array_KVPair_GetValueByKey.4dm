//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// Array_KVPair_GetValueByKey (key; keyArrayPtr; valueArrayPtr) : Value
// Array_KVPair_GetValueByKey (text; textArrayPtr; textArrayPtr) : text
// 
// DESCRIPTION
//   Returns the value for the key from the two provided
//   Key-Value text arrays
//
C_TEXT:C284($1; $vt_key)
C_POINTER:C301($2; $pa_keyArrayPtr)
C_POINTER:C301($3; $pa_valueArrayPtr)
C_TEXT:C284($0; $vt_value)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (07/17/2014)
// ----------------------------------------------------

$vt_value:=""
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 3; Count parameters:C259))
	$vt_key:=$1
	$pa_keyArrayPtr:=$2
	$pa_valueArrayPtr:=$3
	
	C_LONGINT:C283($pos)
	$pos:=Find in array:C230($pa_keyArrayPtr->; $vt_key)
	If ($pos>0) & (Size of array:C274($pa_valueArrayPtr->)>=$pos)
		$vt_value:=$pa_valueArrayPtr->{$pos}
	End if 
End if   // ASSERT
$0:=$vt_value