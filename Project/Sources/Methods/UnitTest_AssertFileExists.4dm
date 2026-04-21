//%attributes = {"invisible":true,"preemptive":"incapable"}
// (PM) UnitTest_AssertFileExists
// Asserts whether a file exists
// $1 = Filename
// $2 = Failure message (optional)
#DECLARE($filename : Text; $message : Text)

If (Count parameters:C259<2)
	$message:="AssertFileExists Expected file \""+$filename+"\""
End if 

UnitTest_Assert(Test path name:C476($filename)=Is a document:K24:1; $message)