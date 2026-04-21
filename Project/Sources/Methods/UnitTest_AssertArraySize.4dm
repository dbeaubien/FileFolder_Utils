//%attributes = {"invisible":true,"preemptive":"incapable"}
// (PM) UnitTest_AssertArraySize
// Asserts whether an arrays is of a given size
// $1 = Expected size
// $2 = Pointer to array
// $3 = Failure message (optional)
//
#DECLARE($expected : Integer; $array : Pointer; $message : Text)
// ----------------------------------------------------

If (Count parameters:C259<3)
	$message:="AssertArraySize Expected "+String:C10($expected)+" but got "+String:C10(Size of array:C274($array->))
End if 

UnitTest_Assert($expected=Size of array:C274($array->); $message)