//%attributes = {"invisible":true,"shared":true,"preemptive":"capable","lang":"en"}
  // File_IsTabDelimited (pathToFile) : isTabDelimited
  // File_IsTabDelimited (text) : boolean
  //
  // DESCRIPTION
  //   Returns true if the file is a CSV.
  //
  // TESTS performed:
  //   1. Is file extension ".txt"
  //   2. Look at first line, expect line of tab delimited values.
  //   3. At least 2 non-empty values in the header line.
  //
C_TEXT:C284($1;$pathToFile)
C_BOOLEAN:C305($0;$isTabDelimited)

$isTabDelimited:=False:C215
If (Asserted:C1132(Count parameters:C259=1))
	$pathToFile:=$1
	
	Case of 
		: (Not:C34(STR_IsOneOf ($pathToFile;"@.txt")))
		: (Not:C34(File_DoesExist ($pathToFile)))
		Else 
			C_TIME:C306($docRef)
			$docRef:=Open document:C264($pathToFile;"";Read mode:K24:5)
			If (OK=1)
				FileBuffer_Init ($docRef)
				
				C_TEXT:C284($eol)
				$eol:=FileBuffer_TellMeTheEOL 
				
				ARRAY TEXT:C222($valuesArr;0)
				FileBuffer_FetchTabDelimitedLne ($eol;->$valuesArr)
				
				  // Must have more than one element
				$isTabDelimited:=(Size of array:C274($valuesArr)>1)
				
				CLOSE DOCUMENT:C267($docRef)
			End if 
			
	End case 
	
End if 
$0:=$isTabDelimited