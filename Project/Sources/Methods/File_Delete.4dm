//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// File_Delete (path to file)
// 
// DESCRIPTION
//   Deletes the specified document.
//   Tries to apply some intelligence if the file
//   is still locked by the operating system. It gives
//   a bit of extra time before it aborts.
//
#DECLARE($file_platformPath : Text)
// ----------------------------------------------------

If (Not:C34(File_DoesExist($file_platformPath)))
	return 
End if 

var $file : 4D:C1709.File
var $stop_after_time : Time
$stop_after_time:=Current time:C178+?00:00:05?  // 5 seconds in the future
Repeat 
	$file:=File:C1566($file_platformPath; fk platform path:K87:2)
	
	If (Not:C34($file.isWritable))
		DELAY PROCESS:C323(Current process:C322; 20)  // delay 20 ticks
	End if 
Until ($file.isWritable || (Current time:C178>$stop_after_time))

If ($file.isWritable)
	DELETE DOCUMENT:C159($file_platformPath)
Else 
	var $msg : Text
	$msg:=Current method name:C684+": Failed to delete \""+$file_platformPath+"\" after 5 seconds of trying...\rCALL CHAIN: \r"+CallChain_FormatPretty(Call chain:C1662)
End if 