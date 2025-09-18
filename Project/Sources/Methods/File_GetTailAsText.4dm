//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// File_GetTailAsText (filePath; numbytes) : tailOfFile
// File_GetTailAsText (text; longint) : text
// 
// DESCRIPTION
//   Returns the tail of the text file.
//   Only the number of bytes requested are returned.
//   If the file is a text file, unicode considerations
//   should be taken.
//
C_TEXT:C284($1; $vt_filePath)
C_LONGINT:C283($2; $vl_numChars)
C_TEXT:C284($0; $vt_tailOfFile)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (06/02/2017)
// ----------------------------------------------------

$vt_tailOfFile:=""
If (Asserted:C1132(Count parameters:C259=2))
	$vt_filePath:=$1
	$vl_numChars:=$2
	
	// Get the doc information
	If (File_DoesExist($vt_filePath)) & ($vl_numChars>0)
		C_LONGINT:C283($vl_docSize)
		$vl_docSize:=Get document size:C479($vt_filePath)
		
		If ($vl_docSize>$vl_numChars)
			
			C_TIME:C306($fileRef)
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
End if 
$0:=$vt_tailOfFile