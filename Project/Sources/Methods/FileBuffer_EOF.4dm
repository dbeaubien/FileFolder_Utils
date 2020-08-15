//%attributes = {"invisible":true,"shared":true,"preemptive":"capable","folder":"File + Folder","lang":"en"}
  // FileBuffer_EOF () : isEOF
  // 
  // DESCRIPTION
  //   Returns true if we are at the end of file.
  //
C_BOOLEAN:C305($0;$isEOF)
  // ----------------------------------------------------
  // HISTORY
  //   Created by: DB (09/14/09)
  //   Mod: DB (04/01/2012) - Used different logic
  // ----------------------------------------------------

$isEOF:=False:C215
If (fileBuffer_buffer="")  // Buffer must be empty
	If (fileBuffer_DocSize=Get document position:C481(fileBuffer_DocRef))  // Must be at end of file
		$isEOF:=True:C214
	End if 
End if 

$0:=$isEOF