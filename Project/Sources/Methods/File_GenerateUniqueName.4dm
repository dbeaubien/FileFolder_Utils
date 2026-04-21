//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// METHOD: File_GenerateUniqueName ()
// 
// DESCRIPTION
//   This method returns a file name that is unique.
// ----------------------------------------------------
#DECLARE()->$uniqueFileName : Text
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=0)

$uniqueFileName:=Date2String(Current date:C33; "YYYYMMDD")
$uniqueFileName+="-"
$uniqueFileName+=Time2String(Current time:C178; "24hhmmss")
$uniqueFileName+="-"
$uniqueFileName+=String:C10(Mod:C98(Milliseconds:C459; 10000))