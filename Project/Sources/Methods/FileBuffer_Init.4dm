//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// Method: FileBuffer_Init (docRef {; buffer size; fileBuffer_charSet})
// Method: FileBuffer_Init (time {; longint; text})
//
// DESCRIPTION
//   Initializes the necessary vars and pre-fills the buffer from
//   the already opened file.
// ===============================================================
// ---- PARAMETERS AND RESULTS ----
//   $1 [in]: reference to an already open document
//   $2 [optional in]: byte size to set the buffer to be
//   no return result
// ---- DESCRIPTION ----
//   This method, initalizes the necessary vars and pre-fills the buffer.
// ---- CHANGE HISTORY ----
//   2000/02/28   DB   Created
// ===============================================================
#DECLARE($fileBuffer_DocRef : Time; $fileBuffer_MaxSize : Integer; $fileBuffer_charSet : Text)
var fileBuffer_buffer; fileBuffer_charSet : Text
fileBuffer_DocRef:=$fileBuffer_DocRef

// set the max size of the buffer
If (Count parameters:C259=2)
	If (Asserted:C1132($fileBuffer_MaxSize<=(1024*1024); "The max size of the buffer must be below "+String:C10(1024*1024)+" bytes"))
		fileBuffer_MaxSize:=$fileBuffer_MaxSize
	Else 
		fileBuffer_MaxSize:=1024*1024
	End if   // ASSERT
Else 
	fileBuffer_MaxSize:=1024*100  // default to buffer to 100k
End if 

// record the size of the document
var fileBuffer_DocSize; fileBuffer_curPos : Integer
fileBuffer_DocSize:=Get document size:C479(fileBuffer_DocRef)
fileBuffer_curPos:=1

If (Count parameters:C259=3)
	fileBuffer_charSet:=$fileBuffer_charSet
End if 
FileBuffer_DetectBOM

// load some data
fileBuffer_buffer:=""
FileBuffer__FillBuffer

var fileBuffer_csv_separator : Text
fileBuffer_csv_separator:=","  // by default