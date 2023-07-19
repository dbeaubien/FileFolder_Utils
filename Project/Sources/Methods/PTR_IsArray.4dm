//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// PTR_IsArray (pointer) : isArray
// PTR_IsArray (pointer) : boolean
//
// DESCRIPTION
//   Returns true if the passed pointer is a pointer to
//   an array.
//
C_POINTER:C301($1; $ptr)
C_BOOLEAN:C305($0; $isArray)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (02/25/2020)
// ----------------------------------------------------

$isArray:=False:C215
If (Asserted:C1132(Count parameters:C259=1))
	$ptr:=$1
	
	Case of 
		: (Type:C295($ptr)#Is pointer:K8:14)
			
		: (Is nil pointer:C315($ptr))
			
		Else 
			$isArray:=True:C214
			
			C_LONGINT:C283($type)
			$type:=Type:C295($ptr->)
			Case of 
				: ($type=Blob array:K8:30)
				: ($type=Boolean array:K8:21)
				: ($type=Date array:K8:20)
				: ($type=Integer array:K8:18)
				: ($type=LongInt array:K8:19)
				: ($type=Object array:K8:28)
				: ($type=Picture array:K8:22)
				: ($type=Pointer array:K8:23)
				: ($type=Real array:K8:17)
				: ($type=Text array:K8:16)
				: ($type=Time array:K8:29)
				Else 
					$isArray:=False:C215
			End case 
	End case 
	
End if 
$0:=$isArray