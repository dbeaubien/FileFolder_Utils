//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// FileBuffer_TellMeTheEOL : theEOL
// 
// DESCRIPTION
//   Scans the filebuffer to figure out what the EOL is.
//
#DECLARE()->$end_of_line : Text
// ----------------------------------------------------
// HISTORY
//   Created by: DB (08/20/10)
// ----------------------------------------------------

FileBuffer__FillBuffer  // top off the buffer
$end_of_line:=STR_TellMeTheEOL(fileBuffer_buffer)