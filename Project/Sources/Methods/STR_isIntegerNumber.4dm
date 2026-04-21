//%attributes = {"invisible":true,"preemptive":"capable"}
// STR_isIntegerNumber (NumAsStr) : IsInteger
// 
// DESCRIPTION
//   Returns true is the string passed is an integer.
//
#DECLARE($vt_srcText : Text)->$vb_isFormattedCorrectly : Boolean
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)

var $i : Integer
var $vt_curChar : Text
$vb_isFormattedCorrectly:=True:C214  // assume all is good
For ($i; 1; Length:C16($vt_srcText))
	$vt_curChar:=$vt_srcText[[$i]]
	Case of 
		: ($vt_curChar="-") && ($i=1)  // ignore these
		: ($vt_curChar=",")  // ignore these
		: ($vt_curChar="0")
		: ($vt_curChar="1")
		: ($vt_curChar="2")
		: ($vt_curChar="3")
		: ($vt_curChar="4")
		: ($vt_curChar="5")
		: ($vt_curChar="6")
		: ($vt_curChar="7")
		: ($vt_curChar="8")
		: ($vt_curChar="9")
		Else 
			$vb_isFormattedCorrectly:=False:C215
			break
	End case 
End for 