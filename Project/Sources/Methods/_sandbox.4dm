//%attributes = {}

//If (False)

//ARRAY TEXT($select_document; 0)

//Select document(System folder(Home folder); ""; "Select the file to import"; Use sheet window; $select_document)
//If (ok=0)
//return 
//End if 

//$validateFilePath:=$select_document{1}
//$validateFileFormat:="csv"
//C_TIME($fileRef)
//$fileRef:=Open document($validateFilePath; Read mode)  // Task 4527
//If (OK=1)
//FileBuffer_Init($fileRef)

//C_TEXT($eol)
//$eol:=FileBuffer_TellMeTheEOL

//ARRAY TEXT($rawLineElementsArr; 0)
//C_COLLECTION($rawLineCollection; $validateFileLines2ValidateList)
//$validateFileLines2ValidateList:=[]
//While (Not(FileBuffer_EOF))

//If ($validateFileFormat="csv")
//FileBuffer_FetchCSVLine($eol; ->$rawLineElementsArr)
//End if 
//If ($validateFileFormat="tsv")
//FileBuffer_FetchTabDelimitedLne($eol; ->$rawLineElementsArr)
//End if 
//If ($validateFileFormat="pipe")
//FileBuffer_FetchDelimitedLne($eol; ->$rawLineElementsArr; "|")
//End if 

//$rawLineCollection:=New collection
//ARRAY TO COLLECTION($rawLineCollection; $rawLineElementsArr)
//$validateFileLines2ValidateList.push($rawLineCollection)

//End while 
//CLOSE DOCUMENT($fileRef)
//End if 
//End if 
