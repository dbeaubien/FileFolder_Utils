//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// FileBuffer_TellMeTheEOL : theEOL
// 
// DESCRIPTION
//   Scans the filebuffer to figure out what the EOL is.
//
#DECLARE()->$end_of_line : Text
// ----------------------------------------------------

FileBuffer__FillBuffer  // top off the buffer
$end_of_line:=STR_TellMeTheEOL(fileBuffer_buffer)