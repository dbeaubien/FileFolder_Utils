//%attributes = {"invisible":true,"preemptive":"capable"}
// STR_isISODate (srcText) : isDate
// STR_isISODate (text) : boolean
// 
// DESCRIPTION
//   Returns true is the passed date starts with
//   "YYYY-MM-DD" date format. Any time information is ignored.
#DECLARE($srcText : Text)->$isFormattedCorrectly : Boolean
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)

If (Length:C16($srcText)<10)
	return 
End if 

$srcText:=Substring:C12($srcText; 1; 10)  // Reduce to just the date part (in case there is more)

var $dateStringParts : Collection
$dateStringParts:=Split string:C1554($srcText; "-")
If ($dateStringParts.length=3)
	var $theMonthAsStr; $theDayAsStr; $theYearAsStr : Text
	$theYearAsStr:=$dateStringParts[0]
	$theMonthAsStr:=$dateStringParts[1]
	$theDayAsStr:=$dateStringParts[2]
	
	If (STR_isIntegerNumber($theYearAsStr) && STR_isIntegerNumber($theMonthAsStr) && STR_isIntegerNumber($theDayAsStr))
		var $vd_theDate : Date
		$vd_theDate:=Add to date:C393(!00-00-00!; Num:C11($theYearAsStr); Num:C11($theMonthAsStr); Num:C11($theDayAsStr))
		If (Date2String($vd_theDate; "yyyy-mm-dd")=$srcText)  // makes sure that the date is valid
			$isFormattedCorrectly:=True:C214
		End if 
	End if 
End if 