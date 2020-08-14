  //%attributes = {"invisible":true,"shared":true,"preemptive":"capable","folder":"File + Folder","lang":"en"} comment added and reserved by 4D.
  // FileBuffer_EOF () : isEOF
  // FileBuffer_EOF () : boolean
  // 
  // DESCRIPTION
  //   Returns true if we are at the end of file.
  //
C_BOOLEAN($0;$vb_isEOF)
  // ----------------------------------------------------
  // HISTORY
  //   Created by: DB (09/14/09)
  //   Mod: DB (04/01/2012) - Used different logic
  // ----------------------------------------------------

$vb_isEOF:=False
If (fileBuffer_buffer="")  // Buffer must be empty
If (fileBuffer_DocSize=Get document position(fileBuffer_DocRef))  // Must be at end of file
$vb_isEOF:=True
End if 
End if 

$0:=$vb_isEOF