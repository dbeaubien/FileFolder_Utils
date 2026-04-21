//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// Method: FileBuffer__FillBuffer

// Gets as much data as is possible so that the buffer is full

var $temporary_text : Text
var $data_size_in_bytes : Integer
$data_size_in_bytes:=fileBuffer_MaxSize-Length:C16(fileBuffer_buffer)

If ($data_size_in_bytes=0)  // if there is room in the buffer
	return 
End if 

var fileBuffer_charSet : Text
Case of 
	: (fileBuffer_charSet="UTF-8")
		RECEIVE PACKET:C104(fileBuffer_DocRef; $temporary_text; $data_size_in_bytes)  // let 4D handle it
		
	: (fileBuffer_charSet="UTF-16@")
		RECEIVE PACKET:C104(fileBuffer_DocRef; $temporary_text; $data_size_in_bytes)  // let 4D handle it
		
	: (fileBuffer_charSet="UTF-32@")
		RECEIVE PACKET:C104(fileBuffer_DocRef; $temporary_text; $data_size_in_bytes)  // let 4D handle it
		
	Else 
		
		var $blob : Blob
		RECEIVE PACKET:C104(fileBuffer_DocRef; $blob; $data_size_in_bytes)
		
		If (BLOB size:C605($blob)=$data_size_in_bytes) && ($data_size_in_bytes>=3)  // Did we fetch all that we asked for? Means not at end of file yet?
			// Check to make sure we didn't cut up an UTF-8 character
			// See: https://www.instructables.com/id/Programming--how-to-detect-and-read-UTF-8-charact/
			
			// Check to see if the last byte loaded is part of a unicode character
			var $numBytes_lastChar; $numBytes_2ndlastChar; $numBytes_3rdlastChar : Integer
			$numBytes_lastChar:=UTF8_GetByteCountFrom1stChar($blob{$data_size_in_bytes-1})
			$numBytes_2ndlastChar:=UTF8_GetByteCountFrom1stChar($blob{$data_size_in_bytes-2})
			$numBytes_3rdlastChar:=UTF8_GetByteCountFrom1stChar($blob{$data_size_in_bytes-3})
			
			var $num_extra_bytes_to_load : Integer
			Case of 
				: ($numBytes_lastChar>1)
					$num_extra_bytes_to_load:=$numBytes_lastChar-1
					
				: ($numBytes_2ndlastChar>1)
					$num_extra_bytes_to_load:=$numBytes_2ndlastChar-2
					
				: ($numBytes_3rdlastChar>1)
					$num_extra_bytes_to_load:=$numBytes_3rdlastChar-3
					
				Else 
					$num_extra_bytes_to_load:=0
			End case 
			
			If ($num_extra_bytes_to_load>0)
				var $temporary_blob : Blob
				SET BLOB SIZE:C606($temporary_blob; 0)
				RECEIVE PACKET:C104(fileBuffer_DocRef; $temporary_blob; $num_extra_bytes_to_load)
				
				var $blob_offset : Integer
				SET BLOB SIZE:C606($blob; BLOB size:C605($blob)+$num_extra_bytes_to_load)
				COPY BLOB:C558($temporary_blob; $blob; $blob_offset; $data_size_in_bytes; $num_extra_bytes_to_load)
			End if 
			
		End if 
		
		// Remove the BOM if there is one
		If (BLOB size:C605($blob)>3)
			// https://en.wikipedia.org/wiki/Byte_order_mark
			If ($blob{0}=239) && ($blob{1}=187) && ($blob{2}=191)  // starts with the UTF-8 BOM?
				DELETE FROM BLOB:C560($blob; 0; 3)  // remove the BOM
			End if 
		End if 
		
		OnErr_Install_Handler("OnErr_GENERIC")
		OnErr_ClearError()
		$temporary_text:=Convert to text:C1012($blob; fileBuffer_charSet)
		If (OnErr_GetLastError#0)
			$temporary_text:=BLOB to text:C555($blob; UTF8 text without length:K22:17)
		End if 
		If ($temporary_text="") && (BLOB size:C605($blob)>0)
			$temporary_text:=BLOB to text:C555($blob; UTF8 C string:K22:15)
			
			If ($temporary_text="") && (BLOB size:C605($blob)>0)
				$temporary_text:=BLOB to text:C555($blob; Mac text without length:K22:10)
			End if 
		End if 
		OnErr_Install_Handler()
End case 

fileBuffer_buffer+=$temporary_text