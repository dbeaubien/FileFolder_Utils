//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// FileBuffer_FetchTabDelimitedLne (eol ; array of values) 
// FileBuffer_FetchTabDelimitedLne (eol ; array of values)
//
// DESCRIPTION
//   Fills the array with the next line of tab delimited values
//   from the open file.
//
#DECLARE($end_of_line : Text; $vp_valuesArrayPtr : Pointer)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=2)
FileBuffer_FetchDelimitedLne($end_of_line; $vp_valuesArrayPtr; Char:C90(Tab:K15:37))