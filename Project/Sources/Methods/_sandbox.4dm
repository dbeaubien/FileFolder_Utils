//%attributes = {}


ARRAY TEXT:C222($select_document; 0)
var $t : Text
$t:=Select document:C905(124; ""; "Select the file to import"; Use sheet window:K24:11; $select_document)
If (ok=0)
	return 
End if 

var $validateFilePath : Text:=$select_document{1}
var $validateFileFormat : Text:="csv"
var $fileRef : Time
$fileRef:=Open document:C264($validateFilePath; Read mode:K24:5)  // Task 4527
If (OK=1)
	FileBuffer_Init($fileRef)
	
	var $eol : Text
	$eol:=FileBuffer_TellMeTheEOL
	
	ARRAY TEXT:C222($rawLineElementsArr; 0)
	var $rawLineCollection; $validateFileLines2ValidateList : Collection
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
		
		$rawLineCollection:=[]
		ARRAY TO COLLECTION:C1563($rawLineCollection; $rawLineElementsArr)
		$validateFileLines2ValidateList.push($rawLineCollection)
		
	End while 
	CLOSE DOCUMENT:C267($fileRef)
End if 
