//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// METHOD: File_GenerateUniqueName ()
// 
// DESCRIPTION
//   This method returns a file name that is unique.
//
C_TEXT:C284($0; $uniqueFileName)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (10/23/07)
// ----------------------------------------------------

$uniqueFileName:=""
If (Asserted:C1132(Count parameters:C259=0))
	$uniqueFileName:=Date2String(Current date:C33; "YYYYMMDD")
	$uniqueFileName:=$uniqueFileName+"-"
	$uniqueFileName:=$uniqueFileName+Time2String(Current time:C178; "24hhmmss")
	$uniqueFileName:=$uniqueFileName+"-"
	$uniqueFileName:=$uniqueFileName+String:C10(Mod:C98(Milliseconds:C459; 10000))
End if   // ASSERT
$0:=$uniqueFileName