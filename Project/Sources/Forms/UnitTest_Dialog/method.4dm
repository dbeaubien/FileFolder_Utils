// (FM) [Dialogs];"UnitTest_Dialog"

Case of 
		
	: (Form event code:C388=On Load:K2:1)
		UnitTest_Init("all_soft")  // only init if it has not happened yet
		
		
	: (Form event code:C388=On Data Change:K2:15) | (Form event code:C388=On Clicked:K2:4)
		C_BOOLEAN:C305($isOneSelected)
		C_LONGINT:C283($i)
		$isOneSelected:=False:C215
		For ($i; 1; Size of array:C274(UnitTest_TestCaseEnabled))
			$isOneSelected:=$isOneSelected | UnitTest_TestCaseEnabled{$i}
		End for 
		OBJECT SET ENABLED:C1123(UnitTest_RunButton; $isOneSelected)
		
		
	: (Form event code:C388=On Unload:K2:2)
		UnitTest_Init("all")
		
End case 
