//%attributes = {"invisible":true,"shared":true,"preemptive":"capable","lang":"en"}
  // FileBuffer_FetchTabDelimitedLne (eol ; array of values) 
  // FileBuffer_FetchTabDelimitedLne (eol ; array of values)
  //
  // DESCRIPTION
  //   Fills the array with the next line of tab delimited values
  //   from the open file.
  //
C_TEXT:C284($1;$vt_eol)
C_POINTER:C301($2;$vp_valuesArrayPtr)

ASSERT:C1129(Count parameters:C259=2)
$vt_eol:=$1
$vp_valuesArrayPtr:=$2

C_TEXT:C284($vt_nextLine)
$vt_nextLine:=FileBuffer_FetchData_ByString ($vt_eol)  // fetch so at the start of the next value
If ($vt_nextLine=("@"+$vt_eol))  // strip out our EOL
	$vt_nextLine:=Substring:C12($vt_nextLine;1;Length:C16($vt_nextLine)-Length:C16($vt_eol))
End if 

If ($vt_nextLine#"")
	C_COLLECTION:C1488($values)
	$values:=Split string:C1554($vt_nextLine;Char:C90(Tab:K15:37))
	COLLECTION TO ARRAY:C1562($values;$vp_valuesArrayPtr->)
Else 
	ARRAY TEXT:C222($vp_valuesArrayPtr->;0)
End if 
