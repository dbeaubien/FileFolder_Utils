//%attributes = {"invisible":true,"preemptive":"capable"}
// PTR_IsArray (pointer) : isArray
// PTR_IsArray (pointer) : boolean
//
// DESCRIPTION
//   Returns true if the passed pointer is a pointer to
//   an array.
//
#DECLARE($ptr : Pointer)->$is_array : Boolean
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (02/25/2020)
// ----------------------------------------------------

ASSERT:C1129(Count parameters:C259=1)
If (Type:C295($ptr)#Is pointer:K8:14) || (Is nil pointer:C315($ptr))
	return 
End if 

$is_array:=True:C214

var $pointer_type : Integer
$pointer_type:=Type:C295($ptr->)
Case of 
	: ($pointer_type=Blob array:K8:30)
	: ($pointer_type=Boolean array:K8:21)
	: ($pointer_type=Date array:K8:20)
	: ($pointer_type=Integer array:K8:18)
	: ($pointer_type=LongInt array:K8:19)
	: ($pointer_type=Object array:K8:28)
	: ($pointer_type=Picture array:K8:22)
	: ($pointer_type=Pointer array:K8:23)
	: ($pointer_type=Real array:K8:17)
	: ($pointer_type=Text array:K8:16)
	: ($pointer_type=Time array:K8:29)
	Else 
		$is_array:=False:C215
End case 
