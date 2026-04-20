//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// File_GetTailAsText (filePath; numbytes) : tailOfFile
// File_GetTailAsText (text; longint) : text
// 
// DESCRIPTION
//   Returns the tail of the text file.
//   Only the number of bytes requested are returned.
//   If the file is a text file, unicode considerations
//   should be taken.
// ----------------------------------------------------
#DECLARE($vt_filePath : Text; $vl_numChars : Integer)->$vt_tailOfFile : Text
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=2)

// Get the doc information
If (File_DoesExist($vt_filePath)) && ($vl_numChars>0)
	var $vl_docSize : Integer
	$vl_docSize:=Get document size:C479($vt_filePath)
	
	If ($vl_docSize>$vl_numChars)
		
		var $fileRef : Time
		$fileRef:=Open document:C264($vt_filePath; Read mode:K24:5)
		If (OK=1)
			SET DOCUMENT POSITION:C482($fileRef; $vl_docSize-$vl_numChars)
			RECEIVE PACKET:C104($fileRef; $vt_tailOfFile; $vl_numChars)
			CLOSE DOCUMENT:C267($fileRef)
		End if 
		
	Else   // File is smaller than what is being requested, grab everything
		$vt_tailOfFile:=Document to text:C1236($vt_filePath)
	End if 
	
End if 