//%attributes = {"invisible":true,"preemptive":"capable"}
  // UTF8_GetByteCountFrom1stChar (charByte) : numBytes
  // UTF8_GetByteCountFrom1stChar (longint) : longint
  //
  // DESCRIPTION
  //   "charByte" is a single byte that is checked to see
  //   If it is the start of a UTF-8 character.
  //    0 - means a badly formed UTF-8 character.
  //    1 - means it is an ascii character
  //    2, 3, 4 - means that is the total length of the UTF-8 character.
  //
  //   110xxxxx means our character is encoded into 2 bytes
  //   1110xxxx means our character is encoded into 3 bytes
  //   11110xxx means our character is encoded into 4 bytes
  //
C_LONGINT:C283($1;$charByte)
C_LONGINT:C283($0;$numBytes)
  // ----------------------------------------------------
  // HISTORY
  //   Created by: Dani Beaubien (09/19/2019)
  // ----------------------------------------------------

$numBytes:=0
If (Asserted:C1132(Count parameters:C259=1))
	$charByte:=$1
	
	C_BOOLEAN:C305($bit8;$bit7;$bit6;$bit5;$bit4)
	$bit8:=($charByte ?? 7)
	$bit7:=($charByte ?? 6)
	$bit6:=($charByte ?? 5)
	$bit5:=($charByte ?? 4)
	$bit4:=($charByte ?? 3)
	
	Case of 
		: (Not:C34($bit8))
			$numBytes:=1
			
		: ($bit8 & $bit7 & Not:C34($bit6))  // 110xxxxx means our character is encoded into 2 bytes
			$numBytes:=2
			
		: ($bit8 & $bit7 & $bit6 & Not:C34($bit5))  // 1110xxxx means our character is encoded into 3 bytes
			$numBytes:=3
			
		: ($bit8 & $bit7 & $bit7 & $bit5 & Not:C34($bit4))  // 11110xxx means our character is encoded into 4 bytes
			$numBytes:=4
			
		Else 
			$numBytes:=0
	End case 
	
End if 
$0:=$numBytes
