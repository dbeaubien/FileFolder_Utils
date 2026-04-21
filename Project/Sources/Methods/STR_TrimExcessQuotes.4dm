//%attributes = {"invisible":true,"preemptive":"capable"}
// Method:str_TrimExcessQuotes (text) : text
// This method removes quotes that might be present at the beginning and the end 
// of the text. Only removes balanced quotes.
//
#DECLARE($tmpTxt : Text) : Text
// ----------------------------------------------------
var $okayToContinue : Boolean
Repeat 
	$okayToContinue:=False:C215
	If (Length:C16($tmpTxt)>1)  // at least two characters
		Case of 
			: ($tmpTxt[[1]]#Char:C90(Double quote:K15:41))
			: ($tmpTxt[[Length:C16($tmpTxt)]]#Char:C90(Double quote:K15:41))
			Else 
				$tmpTxt:=Substring:C12($tmpTxt; 2; Length:C16($tmpTxt)-2)
				$okayToContinue:=True:C214
		End case 
	End if 
Until (Not:C34($okayToContinue))

return $tmpTxt