//%attributes = {"invisible":true,"shared":true,"preemptive":"capable","folder":"File + Folder","lang":"en"}
  // Method: FileBuffer_FetchData_BySize (num bytes)

  // This method returns the specified number of bytes. If it cannot
  // then that means that the file is empty.

C_LONGINT:C283($1;$numBytesLeft)
C_TEXT:C284($0;$tmpTxt)

$tmpTxt:=""
If (Asserted:C1132(Count parameters:C259=1))
	$numBytesLeft:=$1
	C_BOOLEAN:C305($noMoreDataToRead)
	$noMoreDataToRead:=False:C215  // set true when at EOF
	
	If ($numBytesLeft<0)
		$numBytesLeft:=0
	End if 
	
	Repeat 
		Case of 
			: (Length:C16(fileBuffer_buffer)=0)
				FileBuffer_FillBuffer 
				If (Length:C16(fileBuffer_buffer)=0)  // buffer still empty so must be done
					$noMoreDataToRead:=True:C214
				End if 
				
			: ($numBytesLeft<=Length:C16(fileBuffer_buffer))
				$tmpTxt:=$tmpTxt+Substring:C12(fileBuffer_buffer;1;$numBytesLeft)
				fileBuffer_buffer:=Substring:C12(fileBuffer_buffer;$numBytesLeft+1)
				$numBytesLeft:=0
				
			: ($numBytesLeft>Length:C16(fileBuffer_buffer))
				$tmpTxt:=$tmpTxt+fileBuffer_buffer
				$numBytesLeft:=$numBytesLeft-Length:C16(fileBuffer_buffer)
				fileBuffer_buffer:=""
				
		End case 
		
	Until ($numBytesLeft=0) | ($noMoreDataToRead)
	
	  // Increment our current position in the file
	C_LONGINT:C283(fileBuffer_curPos)
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
	
End if   // ASSERT
$0:=$tmpTxt