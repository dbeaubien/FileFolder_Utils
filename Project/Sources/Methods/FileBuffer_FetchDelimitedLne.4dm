//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// FileBuffer_FetchDelimitedLne (eol ; array of values; delimiterChar) 
// FileBuffer_FetchDelimitedLne (eol ; array of values; text)
//
// DESCRIPTION
//   Fills the array with the next line of  delimited values
//   from the open file.
//
C_TEXT:C284($1; $vt_eol)
C_POINTER:C301($2; $vp_valuesArrayPtr)
C_TEXT:C284($3; $delimiterChar)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (01/22/2021) - support any delimiter
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=3)
$vt_eol:=$1
$vp_valuesArrayPtr:=$2
$delimiterChar:=$3

Array_Empty($vp_valuesArrayPtr)

C_TEXT:C284($vt_nextLine)
$vt_nextLine:=FileBuffer_FetchData_ByString($vt_eol)  // fetch so at the start of the next value
If ($vt_nextLine=("@"+$vt_eol))  // strip out our EOL
	$vt_nextLine:=Substring:C12($vt_nextLine; 1; Length:C16($vt_nextLine)-Length:C16($vt_eol))
End if 

If ($vt_nextLine#"")
	Array_ConvertFromTextDelimited($vp_valuesArrayPtr; $vt_nextLine; $delimiterChar)
End if 
