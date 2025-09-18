//%attributes = {"invisible":true,"preemptive":"capable"}
// STR_TellMeTheEOL (string) : theEOL
// STR_TellMeTheEOL (text) : text
// 
// DESCRIPTION
//   scans the text and returns what the EOLs are.
//
#DECLARE($source : Text)->$end_of_line : Text
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)
$end_of_line:=""

var $carriage_return_position; $line_feed_position : Integer
$carriage_return_position:=Position:C15(Char:C90(Carriage return:K15:38); $source; *)
$line_feed_position:=Position:C15(Char:C90(Line feed:K15:40); $source; *)

Case of 
	: ($carriage_return_position=0) & ($line_feed_position=0)  // NOT GOOD
		$end_of_line:=Char:C90(Carriage return:K15:38)  // GUESS
		
	: ($carriage_return_position=0) & ($line_feed_position#0)
		$end_of_line:=Char:C90(Line feed:K15:40)
		
	: ($line_feed_position=0) & ($carriage_return_position#0)
		$end_of_line:=Char:C90(Carriage return:K15:38)
		
	: ($carriage_return_position#0) & ($line_feed_position=($carriage_return_position+1))
		$end_of_line:=Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
		
	: ($line_feed_position#0) & ($carriage_return_position<$line_feed_position)
		$end_of_line:=Char:C90(Carriage return:K15:38)
		
	: ($carriage_return_position#0) & ($line_feed_position<$carriage_return_position)
		$end_of_line:=Char:C90(Line feed:K15:40)
		
	Else 
		$end_of_line:=Char:C90(Carriage return:K15:38)  // GUESS
		
End case 
