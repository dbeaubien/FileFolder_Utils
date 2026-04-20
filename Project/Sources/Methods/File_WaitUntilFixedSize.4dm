//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// File_WaitUntilFixedSize (filePath {; numSecs {;ticks2Wait}})
// 
// DESCRIPTION
//   Waits for the file to appear and to be fixed size.
//   Returns true if the file is there.
//
#DECLARE($documentFullPath : Text; $vl_maxSecondsToWait : Integer; $vl_ticksToPauseBetweenChecks : Integer)->$vb_doesExistFixedSize : Boolean
// ----------------------------------------------------
ASSERT:C1129((Count parameters:C259>=1) && (Count parameters:C259<=3))

If ($vl_maxSecondsToWait<=0)
	$vl_maxSecondsToWait:=20  // default to 20 seconds
End if 
If ($vl_ticksToPauseBetweenChecks<=0)
	$vl_ticksToPauseBetweenChecks:=30  // default to 30 ticks
End if 

var $vl_timeout : Integer
$vl_timeout:=60*20  // delay in ticks (20 seconds)

OnErr_Install_Handler("OnErr_GENERIC")

If (File_WaitUntilDoesExist($documentFullPath; $vl_maxSecondsToWait))
	// Now wait for the file to settle down and stop changing
	var $vl_startTime; $vl_endTime; $vl_timeoutTickCount; $lastsize; $size : Integer
	var $vb_OkayToContinue : Boolean
	$vl_startTime:=Tickcount:C458
	$vl_timeoutTickCount:=Tickcount:C458+$vl_timeout
	$vb_OkayToContinue:=True:C214
	Repeat 
		$lastsize:=Get document size:C479($documentFullPath)
		DELAY PROCESS:C323(Current process:C322; $vl_ticksToPauseBetweenChecks)
		$size:=Get document size:C479($documentFullPath)
		If (Tickcount:C458>$vl_timeoutTickCount)
			$vb_OkayToContinue:=False:C215
		End if 
	Until (($size=$lastsize) && ($size>0)) || (Not:C34($vb_OkayToContinue))
	
	// Is the file fixed size?
	If ($vb_OkayToContinue)
		$vb_doesExistFixedSize:=True:C214
	End if 
	
	$vl_endTime:=Tickcount:C458
End if 

OnErr_Install_Handler