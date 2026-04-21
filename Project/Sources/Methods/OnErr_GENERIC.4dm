//%attributes = {}
// OnErr_GENERIC ()
//
// DESCRIPTION
//   The simplest error handler. Information is sent to the log.
//
// ----------------------------------------------------
// HISTORY
//   Mod by: Dani Beaubien (9/9/13) - Enhanced the information that is coming out
//   Mod by: Dani Beaubien (2020-02-14) - Added gErrorTextArr
// ----------------------------------------------------

ARRAY TEXT:C222(gErrorTextArr; 0)
var gError : Integer
gError:=Error


var $t_alertText : Text
$t_alertText:="error "+String:C10(ERROR)
$t_alertText:=" ** ERR ** --> "+Error method+" line #"+String:C10(Error line)+"- "+$t_alertText+". Check On Err log for more detail"
APPEND TO ARRAY:C911(gErrorTextArr; $t_alertText)

var $last_error_stack : Collection:=Last errors:C1799
var $last_error : Object
var $i : Integer

For each ($last_error; $last_error_stack)
	$i+=1
	APPEND TO ARRAY:C911(gErrorTextArr; "     #"+String:C10($i)+"/"+String:C10($last_error_stack.length)+" ERROR: "+String:C10($last_error.errCode)+"; MESSAGE: \""+$last_error.message+"\"")
End for each 

APPEND TO ARRAY:C911(gErrorTextArr; "CALL CHAIN: \r"+CallChain_FormatPretty(Call chain:C1662)+Char:C90(Carriage return:K15:38))

If (Not:C34(Is compiled mode:C492(*)))
	$i:=0
	var $error : Text
	For ($i; 1; Size of array:C274(gErrorTextArr))
		$error+=gErrorTextArr{$i}+"\r"
	End for 
	ASSERT:C1129(False:C215; $error)
End if 

If (gError=-10518) && (Not:C34(Is compiled mode:C492(*)))  // assertion error
	ALERT:C41("ASSERT ERROR: Occurred. Check logs.")
End if 