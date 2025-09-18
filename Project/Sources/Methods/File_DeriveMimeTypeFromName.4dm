//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// File_DeriveMimeTypeFromName (fileName) : mimeType
// File_DeriveMimeTypeFromName (text) : text
// 
// DESCRIPTION
//   Returns the mime type based on the file extension of
//   the passed filename.
//
C_TEXT:C284($1; $vt_fileName)
C_TEXT:C284($0; $vt_mime_type)
// ----------------------------------------------------
// HISTORY
//   Created by: DB (10/24/07)
//   Mod: DB (10/24/07) - Added more types
//   Mod: DB (01/10/2012) - add direct support for HTML
// ----------------------------------------------------


// Microsoft mime types
//   https://blogs.msdn.microsoft.com/vsofficedeveloper/2008/05/08/office-2007-file-format-mime-types-for-http-content-streaming-2/

// See Also: https://msdn.microsoft.com/en-us/library/bb742440.aspx

$vt_mime_type:="text/html"
If (DEV_ASSERT_PARMCOUNT(Current method name:C684; 1; Count parameters:C259))
	$vt_fileName:=$1
	
	C_TEXT:C284($vt_fileExtension)
	$vt_fileExtension:=File_GetExtension($vt_fileName)
	
	Case of 
		: ($vt_fileExtension="mpeg") | ($vt_fileExtension="mpg")  //   Mod: DB (09/12/2012)
			$vt_mime_type:="video/mpeg"
			
		: ($vt_fileExtension="pic") | ($vt_fileExtension="pict")  //   Mod: DB (09/12/2012)
			$vt_mime_type:="image/pict"
			
		: ($vt_fileExtension="tif") | ($vt_fileExtension="tiff")
			$vt_mime_type:="image/tiff"
			
		: ($vt_fileExtension="jpg") | ($vt_fileExtension="jpeg") | ($vt_fileExtension="jpe")
			$vt_mime_type:="image/jpeg"
			
		: ($vt_fileExtension="gif") | ($vt_fileExtension="bmp") | ($vt_fileExtension="png")
			$vt_mime_type:="image/"+$vt_fileExtension
			
		: ($vt_fileExtension="json")  //   Mod: DB (09/12/2012)
			$vt_mime_type:="application/json"
			
		: ($vt_fileExtension="js")  //   Mod: DB (09/12/2012)
			$vt_mime_type:="application/javascript"
			
		: ($vt_fileExtension="css")
			$vt_mime_type:="text/css"
			
		: ($vt_fileExtension="txt") | ($vt_fileExtension="text")
			$vt_mime_type:="text/plain"
			
		: ($vt_fileExtension="csv")
			$vt_mime_type:="text/csv"
			
		: ($vt_fileExtension="pdf")
			$vt_mime_type:="application/pdf"
			
		: ($vt_fileExtension="xls") | ($vt_fileExtension="slk")
			$vt_mime_type:="application/vnd.ms-excel"
			
		: ($vt_fileExtension="doc")
			$vt_mime_type:="application/msword"
			
		: ($vt_fileExtension="ppt")
			$vt_mime_type:="application/vnd.ms-powerpoint"
			
		: ($vt_fileExtension="xlsx")
			$vt_mime_type:="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
			
		: ($vt_fileExtension="docx")
			$vt_mime_type:="application/vnd.openxmlformats-officedocument.wordprocessingml.document"
			
		: ($vt_fileExtension="pptx")
			$vt_mime_type:="application/vnd.openxmlformats-officedocument.presentationml.presentation"
			
		: ($vt_fileExtension="xml")  //   Mod: DB (09/12/2012)
			$vt_mime_type:="application/xml"
			
		: ($vt_fileExtension="rtf")
			$vt_mime_type:="application/rtf"
			
		: ($vt_fileExtension="zip")
			$vt_mime_type:="application/zip"
			
		: ($vt_fileExtension="html") | ($vt_fileExtension="htm") | ($vt_fileExtension="shtml") | ($vt_fileExtension="shtm")  //   Mod: DB (01/10/2012) - add direct support for HTML
			$vt_mime_type:="text/html"
			
		Else 
			//$vt_mime_type:="text/plain"
			$vt_mime_type:="application/octet-stream"
			
	End case 
	
End if   // ASSERT
$0:=$vt_mime_type