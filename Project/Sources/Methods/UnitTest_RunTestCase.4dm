//%attributes = {"invisible":true,"preemptive":"incapable"}
// (PM) UnitTest_RunTestCase
// Runs a single testcase
// $1 = Test case
#DECLARE($testcase : Text)
// ----------------------------------------------------

UnitTest_CurrentTestCase:=$testcase

// Run the testcase
EXECUTE METHOD:C1007($testcase; *; "RunTests")