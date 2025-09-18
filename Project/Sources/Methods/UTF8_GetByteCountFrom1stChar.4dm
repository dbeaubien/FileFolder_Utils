//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
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
#DECLARE($char_bytes : Integer)->$num_bytes : Integer
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (09/19/2019)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)

var $bit_8; $bit_7; $bit_6; $bit_5; $bit_4 : Boolean
$bit_8:=($char_bytes ?? 7)
$bit_7:=($char_bytes ?? 6)
$bit_6:=($char_bytes ?? 5)
$bit_5:=($char_bytes ?? 4)
$bit_4:=($char_bytes ?? 3)

Case of 
	: (Not:C34($bit_8))
		$num_bytes:=1
		
	: ($bit_8 & $bit_7 & Not:C34($bit_6))  // 110xxxxx means our character is encoded into 2 bytes
		$num_bytes:=2
		
	: ($bit_8 & $bit_7 & $bit_6 & Not:C34($bit_5))  // 1110xxxx means our character is encoded into 3 bytes
		$num_bytes:=3
		
	: ($bit_8 & $bit_7 & $bit_7 & $bit_5 & Not:C34($bit_4))  // 11110xxx means our character is encoded into 4 bytes
		$num_bytes:=4
		
	Else 
		$num_bytes:=0
End case 
