//%attributes = {}
// Boolean2String (boolean{; trueValue; falseValue}) : string
// Boolean2String (boolean{; text; text}) : text
// 
// DESCRIPTION
//   Turns a boolean into a nice string.
//   The trueValue/falseValue default to "true" / "false"
//
#DECLARE($boolean_value : Boolean; $true_value : Text; $false_value : Text) : Text
// ----------------------------------------------------
ASSERT:C1129((Count parameters:C259=1) || (Count parameters:C259=3))

If (Count parameters:C259<3)
	$true_value:="true"
	$false_value:="false"
End if 

return ($boolean_value) ? $true_value : $false_value