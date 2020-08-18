//%attributes = {"invisible":true,"shared":true,"preemptive":"capable","lang":"en"}
  // FileBuffer_FetchCSVLine (eol ; array of values)
  // FileBuffer_FetchCSVLine (text ; pointer to text array)
  //
  // DESCRIPTION
  //   Populates the array with the parsed values from the line.
  //   Recognizes a 1st line of "sep=" line.
  //

C_TEXT:C284($1;$eol)
C_POINTER:C301($2;$valuesArrayPtr)

ASSERT:C1129(Count parameters:C259=2)
$eol:=$1
$valuesArrayPtr:=$2

C_TEXT:C284(fileBuffer_csv_separator)  // defaulted to "," in FileBuffer_Init
C_TEXT:C284($nextLine)

  // # first line?; check to see if we have a "sep=" line
If (FileBuffer_GetFilePostion <=1)
	$nextLine:=FileBuffer_FetchData_PeekAhead (50)  // grab some stuff
	$nextLine:=STR_GetLeftOfChar ($nextLine;$eol)  // reduce down to the line
	If ($nextLine="sep=@") & ((Length:C16($nextLine)=5) | (Length:C16($nextLine)=6))  // check that we have a 1 or 2 char delimiter
		fileBuffer_csv_separator:=Replace string:C233($nextLine;"sep=";"")
		$nextLine:=FileBuffer_FetchData_ByString ($eol)  // fetch the first line so that it is skipped
	End if 
End if 

  // # Fetch a line from the file
$nextLine:=FileBuffer_FetchData_ByString ($eol)
If ($nextLine=("@"+$eol))  // strip out our EOL
	$nextLine:=Substring:C12($nextLine;1;Length:C16($nextLine)-Length:C16($eol))
End if 

C_LONGINT:C283($pos)
C_BOOLEAN:C305($atEOL;$doneValue)
C_TEXT:C284($nextChar;$theValue)
ARRAY TEXT:C222($valuesArrayPtr->;0)
$atEOL:=False:C215
Repeat 
	  // ASSUMPTION: we are at the start of a new value OR eol
	
	  // Is next char a quote or a comma?
	$nextChar:=Substring:C12($nextLine;1;1)
	
	If ($nextChar#"")
		  // NOP, ALL DONE
		If ($nextChar=fileBuffer_csv_separator)  // we have an empty value.
			APPEND TO ARRAY:C911($valuesArrayPtr->;"")
			$nextLine:=Substring:C12($nextLine;2)  // consume the comma to leave at the start of the next values
			
		Else 
			
			  // We have a non-empty valuec
			  // need to consume and then get to start of next value
			If ($nextChar=Char:C90(Double quote:K15:41))  // We have a value that is quote delimited, scan until next quote.
				$nextLine:=Substring:C12($nextLine;2)  // consume the opening quote
				$theValue:=""
				
				  // Scan through text until find closing quote
				$doneValue:=False:C215
				Repeat 
					$pos:=Position:C15(Char:C90(Double quote:K15:41);$nextLine)  // Try to find closing quote
					
					If ($pos>0)  // Found a quote
						$theValue:=$theValue+Substring:C12($nextLine;1;$pos-1)  // try to fetch to the closing quote or to an embedded quote
						$nextLine:=Substring:C12($nextLine;$pos+1)  // remove what we have grabbed, including the quote
						
						If (Substring:C12($nextLine;1;1)=Char:C90(Double quote:K15:41))  // did we find an embedded quote?
							$theValue:=$theValue+Char:C90(Double quote:K15:41)  // Add the embedded quote
							$nextLine:=Substring:C12($nextLine;2)  // consume the embedded quote
						Else 
							$doneValue:=True:C214
						End if 
						
					Else   // no quote found, so need to pull more from buffer (EOL embedded in quotes)
						$nextLine:=$nextLine+Char:C90(Carriage return:K15:38)+FileBuffer_FetchData_ByString ($eol)  // fetch to next EOL, embedded in a quote so need to go beyond
						If ($nextLine=("@"+$eol))  // strip out our EOL
							$nextLine:=Substring:C12($nextLine;1;Length:C16($nextLine)-Length:C16($eol))
						End if 
					End if 
				Until ($doneValue) | (FileBuffer_EOF )
				APPEND TO ARRAY:C911($valuesArrayPtr->;$theValue)
				
				If (Substring:C12($nextLine;1;1)=fileBuffer_csv_separator)
					$nextLine:=Substring:C12($nextLine;2)  // skip past the comma
				End if 
				
			Else   // normal value
				$pos:=Position:C15(fileBuffer_csv_separator;$nextLine)
				If ($pos=0)
					$pos:=Length:C16($nextLine)
				End if 
				$theValue:=Substring:C12($nextLine;1;$pos)  // try to fetch to the next comma
				$nextLine:=Substring:C12($nextLine;$pos+1)  // remove what we have grabbed
				
				If (Position:C15(fileBuffer_csv_separator;$theValue)>0)  // has a comma?
					$theValue:=Replace string:C233($theValue;fileBuffer_csv_separator;"")  // strip this from the value
				End if 
				APPEND TO ARRAY:C911($valuesArrayPtr->;$theValue)
				
			End if 
			
		End if 
		
	End if 
	
Until ($nextLine="")

