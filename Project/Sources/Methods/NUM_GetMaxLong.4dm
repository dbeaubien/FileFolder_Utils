//%attributes = {"invisible":true,"preemptive":"capable"}
// NUM_GetMaxLongint (long1; long2): maxLong
// 
// DESCRIPTION
//   Returns the larger of the two Longints
//
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($0)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=2)

If ($1>$2)
	$0:=$1
Else 
	$0:=$2
End if 