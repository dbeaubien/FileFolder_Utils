//%attributes = {"invisible":true,"preemptive":"incapable"}
// (PM) UnitTest_AssertTrue
// Asserts whether a boolean is True
// $1 = Boolean
// $2 = Failure message (optional)
#DECLARE($boolean : Boolean; $message : Text)
// ----------------------------------------------------

If (Count parameters:C259<2)
	$message:="AssertTrue Expected True but got False"
End if 

UnitTest_Assert($boolean; $message)