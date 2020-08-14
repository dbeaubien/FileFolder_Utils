//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
  // Method: FileBuffer_Init (docRef {; buffer size})
  // Method: FileBuffer_Init (time {; longint})
If (False:C215)
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
End if 
  //#Start method

C_TIME:C306($1;fileBuffer_DocRef)
C_LONGINT:C283($2;fileBuffer_MaxSize)
C_TEXT:C284(fileBuffer_buffer;fileBuffer_charSet)
fileBuffer_DocRef:=$1

  // set the max size of the buffer
If (Count parameters:C259=2)
	If (Asserted:C1132($2<=(1024*1024);"The max size of the buffer must be below "+String:C10(1024*1024)+" bytes"))
		fileBuffer_MaxSize:=$2
	Else 
		fileBuffer_MaxSize:=1024*1024
	End if   // ASSERT
Else 
	fileBuffer_MaxSize:=1024*100  // default to buffer to 100k
End if 

  // record the size of the document
C_LONGINT:C283(fileBuffer_DocSize;fileBuffer_curPos)
fileBuffer_DocSize:=Get document size:C479(fileBuffer_DocRef)
fileBuffer_curPos:=1

fileBuffer_charSet:=""
FileBuffer_DetectBOM 

  // load some data
fileBuffer_buffer:=""
FileBuffer_FillBuffer 

C_TEXT:C284(fileBuffer_csv_separator)
fileBuffer_csv_separator:=","  // by default