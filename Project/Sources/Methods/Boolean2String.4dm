//%attributes = {}
// Boolean2String (boolean{; trueValue; falseValue}) : string
// Boolean2String (boolean{; text; text}) : text
// 
// DESCRIPTION
//   Turns a boolean into a nice string.
//   The trueValue/falseValue default to "true" / "false"
//
C_BOOLEAN:C305($1)
C_TEXT:C284($2; $trueValue)
C_TEXT:C284($3; $falseValue)
// ----------------------------------------------------
// Created by: DB (04/12/04)
//   Mod by: Dani Beaubien (05/24/2019) - param 2 & 3 are now optional
// ----------------------------------------------------

C_TEXT:C284($0)
$0:=""

If (Asserted:C1132((Count parameters:C259=1) | (Count parameters:C259=3)))
	If (Count parameters:C259=3)
		$trueValue:=$2
		$falseValue:=$3
	Else 
		$trueValue:="true"
		$falseValue:="false"
	End if 
	
	If ($1)
		$0:=$trueValue
	Else 
		$0:=$falseValue
	End if 
	
End if 
