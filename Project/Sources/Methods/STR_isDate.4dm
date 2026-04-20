//%attributes = {}
// STR_isDate (srcText) : isDate
// STR_isDate (text) : boolean
// 
// DESCRIPTION
//   Returns true is the passed date matches the
//   "MM/DD/YYYY" or "MM/DD/YY" date format.
// ----------------------------------------------------
#DECLARE($vt_srcText : Text)->$vb_isFormattedCorrectly : Boolean
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)

$vb_isFormattedCorrectly:=(STR_isDate_GetDate($vt_srcText)#!00-00-00!)