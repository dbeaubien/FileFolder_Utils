//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// Method: FileBuffer_Init (docRef {; buffer size})
// Method: FileBuffer_Init (time {; longint})
//
// DESCRIPTION
//   Initializes the necessary vars and pre-fills the buffer from
//   the already opened file.
//
C_TIME:C306($1; fileBuffer_DocRef)  // reference to an already open document
C_LONGINT:C283($2; fileBuffer_MaxSize)  // OPTIONAL byte size to set the buffer to be

If (Asserted:C1132((Count parameters:C259=1) | (Count parameters:C259=2)))
	fileBuffer_DocRef:=$1
	
	fileBuffer_MaxSize:=1024*1024*5  // default buffer to 5MB
	If (Count parameters:C259=2)  // check the max size of the buffer
		ASSERT:C1129($2>0; "The max size of the buffer cannot be set to 0 bytes. Leave out the 2nd param to have it default to 5MB.")
		ASSERT:C1129($2<=(1024*1024*50); "The max size of the buffer must be below "+String:C10(1024*1024*50)+" bytes (50MB).")
		fileBuffer_MaxSize:=$2
	End if 
	
	// record the size of the document
	C_LONGINT:C283(fileBuffer_DocSize; fileBuffer_curPos)
	fileBuffer_DocSize:=Get document size:C479(fileBuffer_DocRef)
	fileBuffer_curPos:=1
	
	C_TEXT:C284(fileBuffer_buffer; fileBuffer_charSet; fileBuffer_csv_separator)
	fileBuffer_charSet:=""
	fileBuffer_buffer:=""
	fileBuffer_csv_separator:=","  // by default
	
	FileBuffer_DetectBOM
	FileBuffer__FillBuffer  // load some data
End if 