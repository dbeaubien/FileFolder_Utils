//%attributes = {"invisible":true,"preemptive":"incapable"}
// (PM) UnitTest_AssertEqualTextAndCase
// Asserts whether two texts are equal and the same case
// $1 = Expected
// $2 = Actual
// $3 = Failure message (optional)
#DECLARE($expected : Text; $actual : Text; $message : Text)
// ----------------------------------------------------

If (Count parameters:C259<3)
	$message:="AssertEqualTextAndCase Expected \""+$expected+"\" but got \""+$actual+"\""
End if 

var $vb_isGood : Boolean
var $i : Integer
If ($expected=$actual)
	$vb_isGood:=True:C214  // assume is good
	For ($i; 1; Length:C16($expected))
		If (Character code:C91($expected[[$i]])#Character code:C91($actual[[$i]]))
			$vb_isGood:=False:C215
		End if 
	End for 
End if 

UnitTest_Assert($vb_isGood; $message)