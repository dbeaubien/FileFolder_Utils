//%attributes = {"invisible":true,"preemptive":"capable"}
// NUM_GetMaxLongint (long1; long2): maxLong
// 
// DESCRIPTION
//   Returns the larger of the two Longints
//
#DECLARE($value_1 : Integer; $value_2 : Integer) : Integer
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=2)

return (($value_1>$value_2) ? $value_1 : $value_2)