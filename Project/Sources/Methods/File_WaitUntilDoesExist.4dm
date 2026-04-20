//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// ----------------------------------------------------
// METHOD: File_WaitUntilDoesExist
// 
// DESCRIPTION
//   Waits for the file to appear. Returns true if the file is there.
//
// PARAMETERS:
#DECLARE($documentFullPath : Text; $vl_maxSecondsToWait : Integer)->$vb_doesExist : Boolean
// ----------------------------------------------------
ASSERT:C1129((Count parameters:C259>=1) && (Count parameters:C259<=2))

If ($vl_maxSecondsToWait<=0)
	$vl_maxSecondsToWait:=20  // default to 20 seconds
End if 

var $vl_timeout : Integer
$vl_timeout:=60*$vl_maxSecondsToWait  // delay in ticks

OnErr_Install_Handler("OnErr_GENERIC")

// Now wait for the file to settle down and stop changing
var $vl_startTime; $vl_timeoutTickCount : Integer
$vl_startTime:=Tickcount:C458
$vl_timeoutTickCount:=Tickcount:C458+$vl_timeout
var $lastsize : Integer
var $size : Integer
Repeat 
	$vb_doesExist:=File_DoesExist($documentFullPath)
	If (Not:C34($vb_doesExist))
		DELAY PROCESS:C323(Current process:C322; 30)  // small 1/2 second delay
	End if 
Until (Tickcount:C458>$vl_timeoutTickCount) || ($vb_doesExist)

OnErr_Install_Handler