//%attributes = {"invisible":true,"preemptive":"incapable"}
// (PM) UnitTest_RunAll
// Runs all unit tests

C_LONGINT:C283($index)

// Initialise our variables and setup the test cases
UnitTest_Init("all")
UnitTest_Init("all_soft")
UnitTest_AddTestCase("FileBuffer__UnitTests")
UnitTest_AddTestCase("CSV__UnitTests")

If (Structure file:C489(*)=Structure file:C489)  // Only open dialog if this structure is the host
	UnitTest_ShowDialog
End if 

UnitTest__Stopwatch("start")

// Run all testcases
For ($index; 1; Size of array:C274(UnitTest_TestCases))
	UnitTest_RunTestCase(UnitTest_TestCases{$index})
End for 

UnitTest__Stopwatch("stop")
