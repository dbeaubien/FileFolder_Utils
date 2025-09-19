//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// ----------------------------------------------------
// METHOD: File_WaitUntilDoesExist
// 
// DESCRIPTION
//   Waits for the file to appear. Returns true if the file is there.
//
// PARAMETERS:
C_TEXT:C284($1; $documentFullPath)
C_LONGINT:C283($2; $vl_maxSecondsToWait)  // default to 20
//
// RETURNS:
C_BOOLEAN:C305($0; $vb_doesExist)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (09/21/09)
// ----------------------------------------------------
ASSERT:C1129((Count parameters:C259>=1) & (Count parameters:C259<=2))

$documentFullPath:=$1
If (Count parameters:C259>=2)
	$vl_maxSecondsToWait:=$2
End if 
If ($vl_maxSecondsToWait<=0)
	$vl_maxSecondsToWait:=20  // default to 20 seconds
End if 

C_LONGINT:C283($vl_timeout)
$vl_timeout:=60*$vl_maxSecondsToWait  // delay in ticks

OnErr_Install_Handler("OnErr_GENERIC")

// Now wait for the file to settle down and stop changing
C_LONGINT:C283($vl_startTime; $vl_timeoutTickCount)
$vl_startTime:=Tickcount:C458
$vl_timeoutTickCount:=Tickcount:C458+$vl_timeout
C_LONGINT:C283($lastsize)
C_LONGINT:C283($size)
Repeat 
	$vb_doesExist:=File_DoesExist($documentFullPath)
	If (Not:C34($vb_doesExist))
		DELAY PROCESS:C323(Current process:C322; 30)  // small 1/2 second delay
	End if 
Until (Tickcount:C458>$vl_timeoutTickCount) | ($vb_doesExist)

OnErr_Install_Handler

$0:=$vb_doesExist