//%attributes = {"invisible":true,"shared":true,"preemptive":"capable","folder":"File + Folder","lang":"en"}
  // FileBuffer_FetchData_PeekAhead (numCharactersToReturn) : fileContent
  //
  //   Returns fileContent up to the number of characters specified without
  //   advancing the current position in the file.
  //
C_LONGINT:C283($1;$numCharactersToReturn)
C_TEXT:C284($0)

If (Asserted:C1132(Count parameters:C259=1))
	$numCharactersToReturn:=$1
	
	If ($numCharactersToReturn>0)
		If (Length:C16(fileBuffer_buffer)<$numCharactersToReturn)
			FileBuffer__FillBuffer   // top off the buffer
		End if 
		
		  // check to see if the buffer is just too small, return what we can
		If (Length:C16(fileBuffer_buffer)<$numCharactersToReturn)
			$0:=fileBuffer_buffer
		Else 
			$0:=Substring:C12(fileBuffer_buffer;1;$numCharactersToReturn)
		End if 
	End if 
End if 