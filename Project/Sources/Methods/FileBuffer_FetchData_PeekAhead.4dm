//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// FileBuffer_FetchData_PeekAhead (numCharactersToReturn) : fileContent
//
//   Returns fileContent up to the number of characters specified without
//   advancing the current position in the file.
//
#DECLARE($size_to_return : Integer)->$file_content : Text
// ----------------------------------------------------
If (Count parameters:C259=0) || ($size_to_return<0)
	$size_to_return:=0
End if 

If ($size_to_return=0)
	return 
End if 

If (Length:C16(fileBuffer_buffer)<$size_to_return)
	FileBuffer__FillBuffer  // top off the buffer
End if 

// check to see if the buffer is just too small, return what we can
If (Length:C16(fileBuffer_buffer)<$size_to_return)
	$file_content:=fileBuffer_buffer
Else 
	$file_content:=Substring:C12(fileBuffer_buffer; 1; $size_to_return)
End if 
