//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// File_WaitUntilFixedSize (filePath {; numSecs {;ticks2Wait}})
// 
// DESCRIPTION
//   Waits for the file to appear and to be fixed size.
//   Returns true if the file is there.
//
C_TEXT:C284($1; $documentFullPath)
C_LONGINT:C283($2; $vl_maxSecondsToWait)  // default to 20
C_LONGINT:C283($3; $vl_ticksToPauseBetweenChecks)  // default to 30
C_BOOLEAN:C305($0; $vb_doesExistFixedSize)
// ----------------------------------------------------
// HISTORY
//   Created by: Ed Pigg (Quest Information Systems) 9/15/2005 10:53
//   Mod by: DB (10/01/09)
// ----------------------------------------------------
ASSERT:C1129((Count parameters:C259>=1) & (Count parameters:C259<=3))
$vb_doesExistFixedSize:=False:C215
$documentFullPath:=$1
If (Count parameters:C259>=2)
	$vl_maxSecondsToWait:=$2
End if 
If (Count parameters:C259>=3)
	$vl_ticksToPauseBetweenChecks:=$3
End if 
If ($vl_maxSecondsToWait<=0)
	$vl_maxSecondsToWait:=20  // default to 20 seconds
End if 
If ($vl_ticksToPauseBetweenChecks<=0)
	$vl_ticksToPauseBetweenChecks:=30  // default to 30 ticks
End if 

C_LONGINT:C283($vl_timeout)
$vl_timeout:=60*20  // delay in ticks (20 seconds)

OnErr_Install_Handler("OnErr_GENERIC")

If (File_WaitUntilDoesExist($documentFullPath; $vl_maxSecondsToWait))
	// Now wait for the file to settle down and stop changing
	C_LONGINT:C283($vl_startTime; $vl_endTime; $vl_timeoutTickCount; $lastsize; $size)
	C_BOOLEAN:C305($vb_OkayToContinue)
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
	Until (($size=$lastsize) & ($size>0)) | (Not:C34($vb_OkayToContinue))
	
	// Is the file fixed size?
	If ($vb_OkayToContinue)
		$vb_doesExistFixedSize:=True:C214
	End if 
	
	$vl_endTime:=Tickcount:C458
End if 

OnErr_Install_Handler

$0:=$vb_doesExistFixedSize