//%attributes = {"shared":true,"preemptive":"incapable"}
// UnitTest_Setup_IHCore
//
// This is the place to setup your testcases

UnitTest_Init("all_soft")

UnitTest_AddTestCase("Array__UnitTests")
UnitTest_AddTestCase("Date__UnitTests")
UnitTest_AddTestCase("File__UnitTests")
UnitTest_AddTestCase("FileBuffer__UnitTests")
UnitTest_AddTestCase("Folder__UnitTests")

If (Structure file:C489(*)=Structure file:C489)  // Only open dialog if this structure is the host
	UnitTest_AddTestCase("Field__UnitTests")
End if 

UnitTest_AddTestCase("ICD10__UnitTests")

UnitTest_AddTestCase("NUM__UnitTests")
UnitTest_AddTestCase("STR__UnitTests")
UnitTest_AddTestCase("Record__UnitTests")
UnitTest_AddTestCase("String__UnitTests")
UnitTest_AddTestCase("Text__UnitTests")
UnitTest_AddTestCase("Time__UnitTests")  //   Mod: DB (03/04/2015) 
UnitTest_AddTestCase("php__UnitTests")  //   Mod: DB (06/16/2017)s
UnitTest_AddTestCase("CSV__UnitTests")

UnitTest_AddTestCase("HIPAA__UnitTests")

If (Structure file:C489(*)=Structure file:C489)  // Only open dialog if this structure is the host
	UnitTest_ShowDialog
End if 