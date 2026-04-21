//%attributes = {"invisible":true,"preemptive":"incapable"}
// (PM) UnitTest_AssertEqualReal
// Asserts whether two reals are equal
// $1 = Expected
// $2 = Actual
// $3 = Failure message (optional)
#DECLARE($expected : Pointer; $actual : Pointer; $message : Text)
// ----------------------------------------------------

If (Count parameters:C259<3)
	$message:="AssertEqualReal Expected "+String:C10($expected)+" but got "+String:C10($actual)
End if 

UnitTest_Assert($expected=$actual; $message)