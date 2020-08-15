//%attributes = {"invisible":true,"shared":true,"preemptive":"capable","lang":"en"}
  // FileBuffer_TellMeTheEOL : theEOL
  // 
  // DESCRIPTION
  //   Scans the filebuffer to figure out what the EOL is.
  //
C_TEXT:C284($0;$theEOL)
  // ----------------------------------------------------
  // HISTORY
  //   Created by: DB (08/20/10)
  // ----------------------------------------------------

FileBuffer__FillBuffer   // top off the buffer
$theEOL:=STR_TellMeTheEOL (fileBuffer_buffer)

$0:=$theEOL
