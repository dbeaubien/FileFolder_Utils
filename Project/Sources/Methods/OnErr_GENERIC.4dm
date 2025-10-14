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
// OnErr_GENERIC_Minimal ()
//
// DESCRIPTION
//   The simplest error handler. No external logging.
//
// ----------------------------------------------------
// HISTORY
//   Mod by: Dani Beaubien (9/9/13) - Enhanced the information that is coming out
//   Mod by: Dani Beaubien (2020-02-14) - Added gErrorTextArr
// ----------------------------------------------------

ARRAY TEXT:C222(gErrorTextArr; 0)
C_LONGINT:C283(gError)
gError:=Error


C_TEXT:C284($t_alertText)
$t_alertText:="error "+String:C10(ERROR)
$t_alertText:=" ** ERR ** --> "+Error method+" line #"+String:C10(Error line)+"- "+$t_alertText+". Check On Err log for more detail"
APPEND TO ARRAY:C911(gErrorTextArr; $t_alertText)

ARRAY LONGINT:C221($al_err_code; 0)
ARRAY TEXT:C222($as_component; 0)
ARRAY TEXT:C222($as_error; 0)
GET LAST ERROR STACK:C1015($al_err_code; $as_component; $as_error)
C_LONGINT:C283($i)
For ($i; 1; Size of array:C274($al_err_code))
	APPEND TO ARRAY:C911(gErrorTextArr; "     #"+String:C10($i)+"/"+String:C10(Size of array:C274($al_err_code))+" ERROR: "+String:C10($al_err_code{$i})+"; MESSAGE: \""+$as_error{$i}+"\"")
End for 

APPEND TO ARRAY:C911(gErrorTextArr; "CALL CHAIN: \r"+CallChain_FormatPretty(Get call chain:C1662)+Char:C90(Carriage return:K15:38))

If (Not:C34(Is compiled mode:C492(*)))
	var $i : Integer
	var $error : Text
	For ($i; 1; Size of array:C274(gErrorTextArr))
		$error+=gErrorTextArr{$i}+"\r"
	End for 
	ASSERT:C1129(False:C215; $error)
End if 

If (gError=-10518) & (Not:C34(Is compiled mode:C492(*)))  // assertion error
	ALERT:C41("ASSERT ERROR: Occurred. Check logs.")
End if 