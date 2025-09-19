//%attributes = {}
// STR_isDate (srcText) : isDate
// STR_isDate (text) : boolean
// 
// DESCRIPTION
//   Returns true is the passed date matches the
//   "MM/DD/YYYY" or "MM/DD/YY" date format.

C_TEXT:C284($1; $vt_srcText)
C_BOOLEAN:C305($0; $vb_isFormattedCorrectly)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (02/26/10)
//   Mod by: Dani Beaubien (2020-02-14) - Moved logic to STR_isDate_GetDate
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)
$vb_isFormattedCorrectly:=False:C215
$vt_srcText:=$1

$vb_isFormattedCorrectly:=(STR_isDate_GetDate($vt_srcText)#!00-00-00!)

$0:=$vb_isFormattedCorrectly