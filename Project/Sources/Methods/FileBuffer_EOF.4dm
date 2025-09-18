//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// FileBuffer_EOF () : isEOF
// FileBuffer_EOF () : boolean
// 
// DESCRIPTION
//   Returns true if we are at the end of file.
//
#DECLARE()->$is_end_of_file : Boolean
// ----------------------------------------------------
// HISTORY
//   Created by: DB (09/14/09)
//   Mod: DB (04/01/2012) - Used different logic
// ----------------------------------------------------

If (fileBuffer_buffer="")  // Buffer must be empty
	If (fileBuffer_DocSize=Get document position:C481(fileBuffer_DocRef))  // Must be at end of file
		$is_end_of_file:=True:C214
	End if 
End if 
