//%attributes = {"invisible":true,"shared":true,"preemptive":"capable","folder":"File + Folder","lang":"en"}
  // Method: FileBuffer_FetchData_PeekAhead ({length})

C_LONGINT:C283($1;$sizeToReturn)
C_TEXT:C284($0)

If (Count parameters:C259=1)
	$sizeToReturn:=$1
End if 
If (Count parameters:C259=0) | ($sizeToReturn<0)
	$sizeToReturn:=0
End if 

If ($sizeToReturn>0)
	If (Length:C16(fileBuffer_buffer)<$sizeToReturn)
		FileBuffer_FillBuffer   // top off the buffer
	End if 
	
	  // check to see if the buffer is just too small, return what we can
	If (Length:C16(fileBuffer_buffer)<$sizeToReturn)
		$0:=fileBuffer_buffer
	Else 
		$0:=Substring:C12(fileBuffer_buffer;1;$sizeToReturn)
	End if 
End if 
