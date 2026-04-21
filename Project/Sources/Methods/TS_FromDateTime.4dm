//%attributes = {"invisible":true,"preemptive":"capable"}
// METHOD: TS_FromDateTime
// $0 = Date and time put into a Longint
// $1 = Date
// $2 = Time
#DECLARE($Date : Date; $Time : Time) : Integer
// ----------------------------------------------------
var $Offset : Integer
var $RefDate : Date
$RefDate:=!1990-01-01!
$Offset:=86400  // aka 24*60*60

Case of 
	: (Count parameters:C259=0)  // Get the date and time on the server
		$Date:=Current date:C33
		$Time:=Current time:C178
		
	: (Count parameters:C259=1)  // Get the time on the server
		$Time:=Current time:C178
		
End case 

If ($Date#!00-00-00!)
	return (($Date-$RefDate)*$Offset)+($Time+0)
Else 
	return 0  // no date means a zero
End if 