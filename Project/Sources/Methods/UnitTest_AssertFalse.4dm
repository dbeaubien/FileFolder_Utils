//%attributes = {"invisible":true,"preemptive":"incapable"}
// (PM) UnitTest_AssertFalse
// Asserts whether a boolean is False
// $1 = Boolean
// $2 = Failure message (optional)
#DECLARE($boolean : Boolean; $message : Text)
// ----------------------------------------------------

If (Count parameters:C259<2)
	$message:="AssertFalse Expected False but got True"
End if 

UnitTest_Assert($boolean=False:C215; $message)