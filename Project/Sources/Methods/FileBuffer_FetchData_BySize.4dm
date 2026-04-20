//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// Method: FileBuffer_FetchData_BySize (numBytesToFetch) : fileContent

// This method returns the specified number of bytes. If it cannot
// then that means that the file is empty.
#DECLARE($number_of_bytes_left : Integer)->$temporary_text : Text
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)

var $no_more_data_to_read : Boolean

If ($number_of_bytes_left<0)
	$number_of_bytes_left:=0
End if 

Repeat 
	Case of 
		: (Length:C16(fileBuffer_buffer)=0)
			FileBuffer__FillBuffer
			If (Length:C16(fileBuffer_buffer)=0)  // buffer still empty so must be done
				$no_more_data_to_read:=True:C214
			End if 
			
		: ($number_of_bytes_left<=Length:C16(fileBuffer_buffer))
			$temporary_text:=$temporary_text+Substring:C12(fileBuffer_buffer; 1; $number_of_bytes_left)
			fileBuffer_buffer:=Substring:C12(fileBuffer_buffer; $number_of_bytes_left+1)
			$number_of_bytes_left:=0
			
		: ($number_of_bytes_left>Length:C16(fileBuffer_buffer))
			$temporary_text:=$temporary_text+fileBuffer_buffer
			$number_of_bytes_left:=$number_of_bytes_left-Length:C16(fileBuffer_buffer)
			fileBuffer_buffer:=""
			
	End case 
	
Until ($number_of_bytes_left=0) || ($no_more_data_to_read)

// Increment our current position in the file
var fileBuffer_curPos : Integer
Case of 
	: (fileBuffer_charSet="UTF-16@")
		fileBuffer_curPos:=fileBuffer_curPos+Length:C16($temporary_text*2)
		
	: (fileBuffer_charSet="UTF-32@")
		fileBuffer_curPos:=fileBuffer_curPos+Length:C16($temporary_text*4)
		
	Else 
		var $temporary_blob : Blob
		TEXT TO BLOB:C554($temporary_text; $temporary_blob; UTF8 text without length:K22:17)
		fileBuffer_curPos:=fileBuffer_curPos+BLOB size:C605($temporary_blob)
End case 
