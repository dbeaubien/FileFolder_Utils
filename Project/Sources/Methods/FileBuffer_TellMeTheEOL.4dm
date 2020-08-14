//%attributes = {"invisible":true,"shared":true,"preemptive":"capable","lang":"en"}
  // FileBuffer_TellMeTheEOL
  // 
  // DESCRIPTION
  //   Scans the filebuffer to figure out what the EOL
  //   is.
  //
  // PARAMETERS:
  //   none
  // RETURNS:
C_TEXT:C284($0;$vt_theEOL)
  // ----------------------------------------------------
  // HISTORY
  //   Created by: DB (08/20/10)
  // ----------------------------------------------------

FileBuffer_FillBuffer   // top off the buffer
$vt_theEOL:=STR_TellMeTheEOL (fileBuffer_buffer)

$0:=$vt_theEOL
