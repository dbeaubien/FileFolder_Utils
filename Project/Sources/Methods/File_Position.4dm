//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// File_Position (find, fileRef{; offset}) : positionInFile
// File_Position (string, fileRef{; longint}) : longint
//
// DESCRIPTION
//   Acts just like the Position 4D command except that this
//   function sets (and returns) the first position in the file
//   where the "find" text appears.
//   An offset can be provided to indicate where to start looking. 
//   - Positive values 
//
#DECLARE($find : Text; $fileRef : Time; $offset : Integer)->$docPos : Integer
// ----------------------------------------------------

$docPos:=-1
If (Asserted:C1132((Count parameters:C259=2) || (Count parameters:C259=3)))
	var $docSize : Integer
	SET DOCUMENT POSITION:C482($fileRef; 0; 2)  // In relation to the end of the file
	$docSize:=Get document position:C481($fileRef)
	If ($offset<0) && ($docSize<Abs:C99($offset))
		$offset:=0-$docSize
	End if 
	
	Case of 
		: ($offset>0)  // In relation to the beginning of the file
			SET DOCUMENT POSITION:C482($fileRef; $offset; 1)
		: ($offset<0)  // In relation to the end of the file
			SET DOCUMENT POSITION:C482($fileRef; $offset; 2)
		Else   // In relation to the beginning of the file
			SET DOCUMENT POSITION:C482($fileRef; 0; 1)
	End case 
	
	var $buffer : Text
	var $count; $pos : Integer
	$count:=0
	While (Get document position:C481($fileRef)<$docSize) && ($docPos=-1)
		RECEIVE PACKET:C104($fileRef; $buffer; 102400)
		$pos:=Position:C15($find; $buffer)
		If ($pos>0)
			Case of 
				: ($offset>0)  // In relation to the beginning of the file
					$docPos:=$offset+($count*102400)+$pos-1
				: ($offset<0)  // In relation to the end of the file
					$docPos:=$docSize+($count*102400)+$offset+$pos-1
				Else 
					$docPos:=($count*102400)+$pos-1
			End case 
			SET DOCUMENT POSITION:C482($fileRef; $docPos; 1)
		Else 
			$count:=$count+1
		End if 
	End while 
	
End if 