//%attributes = {"invisible":true,"preemptive":"incapable"}
// (PM) UnitTest_AssertEqualPointer
// Asserts whether two pointers point to the same thing
// $1 = Expected
// $2 = Actual
// $3 = Failure message (optional)
#DECLARE($expected : Pointer; $actual : Pointer; $message : Text)
// ----------------------------------------------------

If (Count parameters:C259<3)
	$message:="AssertEqualPointer Expected "+UnitTest__ResolvePointer($expected)+" but got "+UnitTest__ResolvePointer($actual)
End if 

UnitTest_Assert($expected=$actual; $message)