//%attributes = {}


ARRAY TEXT:C222($select_document; 0)
var $t : Text
$t:=Select document:C905(124; ""; "Select the file to import"; Use sheet window:K24:11; $select_document)
If (ok=0)
	return 
End if 

$validateFilePath:=$select_document{1}
$validateFileFormat:="csv"
C_TIME:C306($fileRef)
$fileRef:=Open document:C264($validateFilePath; Read mode:K24:5)  // Task 4527
If (OK=1)
	FileBuffer_Init($fileRef)
	
	C_TEXT:C284($eol)
	$eol:=FileBuffer_TellMeTheEOL
	
	ARRAY TEXT:C222($rawLineElementsArr; 0)
	C_COLLECTION:C1488($rawLineCollection; $validateFileLines2ValidateList)
	$validateFileLines2ValidateList:=[]
	While (Not:C34(FileBuffer_EOF))
		
		If ($validateFileFormat="csv")
			FileBuffer_FetchCSVLine($eol; ->$rawLineElementsArr)
		End if 
		If ($validateFileFormat="tsv")
			FileBuffer_FetchTabDelimitedLne($eol; ->$rawLineElementsArr)
		End if 
		If ($validateFileFormat="pipe")
			FileBuffer_FetchDelimitedLne($eol; ->$rawLineElementsArr; "|")
		End if 
		
		$rawLineCollection:=New collection:C1472
		ARRAY TO COLLECTION:C1563($rawLineCollection; $rawLineElementsArr)
		$validateFileLines2ValidateList.push($rawLineCollection)
		
	End while 
	CLOSE DOCUMENT:C267($fileRef)
End if 
