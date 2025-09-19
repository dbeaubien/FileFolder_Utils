//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// FileBuffer_EOF () : isEOF
// 
// DESCRIPTION
//   Returns true if we are at the end of file.
//
#DECLARE()->$is_end_of_file : Boolean
// ----------------------------------------------------
$is_end_of_file:=False:C215

If (fileBuffer_buffer="")  // Buffer must be empty
	If (fileBuffer_DocSize=Get document position:C481(fileBuffer_DocRef))  // Must be at end of file
		$is_end_of_file:=True:C214
	End if 
End if 
