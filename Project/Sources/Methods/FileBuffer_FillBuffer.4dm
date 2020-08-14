//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
  // Method: FileBuffer_FillBuffer

  // Gets as much data as is possible so that the buffer is full

C_TEXT:C284($tmpTxt)
C_LONGINT:C283($dataSize)
$dataSize:=fileBuffer_MaxSize-Length:C16(fileBuffer_buffer)

If ($dataSize>0)  // if there is room in the buffer
	C_TEXT:C284(fileBuffer_charSet)
	Case of 
		: (fileBuffer_charSet="UTF-16@")
			RECEIVE PACKET:C104(fileBuffer_DocRef;$tmpTxt;$dataSize)  // let 4D handle it
			
		: (fileBuffer_charSet="UTF-32@")
			RECEIVE PACKET:C104(fileBuffer_DocRef;$tmpTxt;$dataSize)  // let 4D handle it
			
		Else 
			
			C_BLOB:C604($blob)
			RECEIVE PACKET:C104(fileBuffer_DocRef;$blob;$dataSize)
			
			If (BLOB size:C605($blob)=$dataSize) & ($dataSize>=3)  // Did we fetch all that we asked for? Means not at end of file yet?
				  // Check to make sure we didn't cut up an UTF-8 character
				  // See: https://www.instructables.com/id/Programming--how-to-detect-and-read-UTF-8-charact/
				
				  // Check to see if the last byte loaded is part of a unicode character
				C_LONGINT:C283($numBytes_lastChar;$numBytes_2ndlastChar;$numBytes_3rdlastChar)
				$numBytes_lastChar:=UTF8_GetByteCountFrom1stChar ($blob{$dataSize-1})
				$numBytes_2ndlastChar:=UTF8_GetByteCountFrom1stChar ($blob{$dataSize-2})
				$numBytes_3rdlastChar:=UTF8_GetByteCountFrom1stChar ($blob{$dataSize-3})
				
				C_LONGINT:C283($numExtraBytesToLoad)
				Case of 
					: ($numBytes_lastChar>1)
						$numExtraBytesToLoad:=$numBytes_lastChar-1
						
					: ($numBytes_2ndlastChar>1)
						$numExtraBytesToLoad:=$numBytes_2ndlastChar-2
						
					: ($numBytes_3rdlastChar>1)
						$numExtraBytesToLoad:=$numBytes_3rdlastChar-3
						
					Else 
						$numExtraBytesToLoad:=0
				End case 
				
				If ($numExtraBytesToLoad>0)
					C_BLOB:C604($tmpBlob)
					SET BLOB SIZE:C606($tmpBlob;0)
					RECEIVE PACKET:C104(fileBuffer_DocRef;$tmpBlob;$numExtraBytesToLoad)
					
					C_LONGINT:C283($offset)
					SET BLOB SIZE:C606($blob;BLOB size:C605($blob)+$numExtraBytesToLoad)
					COPY BLOB:C558($tmpBlob;$blob;$offset;$dataSize;$numExtraBytesToLoad)
				End if 
				
			End if 
			
			  // Remove the BOM if there is one
			If (BLOB size:C605($blob)>3)
				  // https://en.wikipedia.org/wiki/Byte_order_mark
				If ($blob{0}=239) & ($blob{1}=187) & ($blob{2}=191)  // starts with the UTF-8 BOM?
					DELETE FROM BLOB:C560($blob;0;3)  // remove the BOM
				End if 
			End if 
			
			$tmpTxt:=BLOB to text:C555($blob;UTF8 text without length:K22:17)
			
			If ($tmpTxt="") & (BLOB size:C605($blob)>0)
				$tmpTxt:=BLOB to text:C555($blob;UTF8 C string:K22:15)
				
				If ($tmpTxt="") & (BLOB size:C605($blob)>0)
					$tmpTxt:=BLOB to text:C555($blob;Mac text without length:K22:10)
				End if 
			End if 
	End case 
	
	fileBuffer_buffer:=fileBuffer_buffer+$tmpTxt
End if 