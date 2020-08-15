//%attributes = {"invisible":true,"shared":true,"preemptive":"capable","folder":"File + Folder","lang":"en"}
  // FileBuffer_FetchData_ByString (matchOnText{; matchOnText2}) : fileContent
  // FileBuffer_FetchData_ByString (text{; text}) : text
  //
  // DESCRIPTION
  //   Returns text from the buffer up to AND INCLUDING
  //   the "text to match on".
  //   NOTE: This differs from RECEIVE PACKET.
  //
C_TEXT:C284($1;$matchOnText)
C_TEXT:C284($2;$matchOnText2)
C_TEXT:C284($0;$tmpTxt)
  // ----------------------------------------------------
  // HISTORY
  //   Created by: Dani Beaubien (03/05/2019)
  //   Mod by: Dani Beaubien (12/12/2019) - Task 6201 - Handle if the eol char is \r\n and is split across the buffer
  // ----------------------------------------------------

$matchOnText:=$1
$matchOnText2:=""
If (Count parameters:C259=2)
	$matchOnText2:=$2
End if 

C_LONGINT:C283($pos;$pos2)
$tmpTxt:=""
$pos:=0
$pos2:=0

If (Asserted:C1132((Length:C16($matchOnText)>0);"String being passed to search for is empty."))
	
	C_BOOLEAN:C305($fileIsDone)
	If (fileBuffer_buffer="")  // empty buffer, empty it
		FileBuffer__FillBuffer 
		
		If (fileBuffer_buffer="")
			$fileIsDone:=FileBuffer_EOF 
		End if 
	End if 
	
	If (Not:C34($fileIsDone))
		  // where is it in the string?
		$pos:=Position:C15($matchOnText;fileBuffer_buffer;*)
		If ($matchOnText2#"")
			$pos2:=Position:C15($matchOnText2;fileBuffer_buffer;*)
		End if 
		
		C_LONGINT:C283(fileBuffer_curPos)
		C_BLOB:C604($vx_tmpBuffer)
		C_BOOLEAN:C305($doIncrementPosition)
		$doIncrementPosition:=False:C215
		
		If ($pos>0) | ($pos2>0)
			$doIncrementPosition:=True:C214
			If (($pos=0) | ($pos2<$pos) & ($pos2#0))  // if 2nd parm was found first then use that one
				$pos:=$pos2
				$matchOnText:=$matchOnText2
			End if 
			
			  // text found, return all data PLUS the found text
			If ($pos>0) & (fileBuffer_buffer#"")
				$pos:=$pos+(Length:C16($matchOnText)-1)
				$tmpTxt:=Substring:C12(fileBuffer_buffer;1;$pos)
				fileBuffer_buffer:=Substring:C12(fileBuffer_buffer;$pos+1)  // advance to next char
			End if 
			
		Else   // not found in our buffer, then add more data and try again
			$tmpTxt:=fileBuffer_buffer
			fileBuffer_buffer:=""
			
			FileBuffer__FillBuffer   // Force the buffer to refill
			If (FileBuffer_EOF )
				$doIncrementPosition:=True:C214
			Else 
				fileBuffer_buffer:=$tmpTxt+fileBuffer_buffer  // reconstruct the buffer in case our matching text is split across the previous buffer and what was loaded
				$tmpTxt:=FileBuffer_FetchData_ByString ($matchOnText;$matchOnText2)
			End if 
			
		End if 
		
		
		If ($doIncrementPosition)
			  // Increment our current position in the file based on what is in the buffer
			Case of 
				: (fileBuffer_charSet="UTF-16@")
					fileBuffer_curPos:=fileBuffer_curPos+Length:C16($tmpTxt*2)
					
				: (fileBuffer_charSet="UTF-32@")
					fileBuffer_curPos:=fileBuffer_curPos+Length:C16($tmpTxt*4)
					
				Else 
					C_BLOB:C604($vx_tmpBuffer)
					TEXT TO BLOB:C554($tmpTxt;$vx_tmpBuffer;UTF8 text without length:K22:17)
					fileBuffer_curPos:=fileBuffer_curPos+BLOB size:C605($vx_tmpBuffer)
			End case 
		End if 
		
	End if 
	
End if   // ASSERT

$0:=$tmpTxt