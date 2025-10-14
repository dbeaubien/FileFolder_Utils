//%attributes = {"invisible":true,"preemptive":"capable"}
// OnErr_Clear ()
// 
// DESCRIPTION
//   Clears the internal error var
// ----------------------------------------------------

ARRAY TEXT:C222(gErrorTextArr; 0)
C_LONGINT:C283(gError)
gError:=0