//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// File_DeriveMimeTypeFromName (fileName) : mimeType
// 
// DESCRIPTION
//   Returns the mime type based on the file extension of
//   the passed filename.
//
//   Microsoft mime types
//   https://blogs.msdn.microsoft.com/vsofficedeveloper/2008/05/08/office-2007-file-format-mime-types-for-http-content-streaming-2/
//
//   See Also: https://msdn.microsoft.com/en-us/library/bb742440.aspx
//
#DECLARE($file_name : Text)->$mime_type : Text
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)
$mime_type:="text/html"

var $file_extension : Text
$file_extension:=File_GetExtension($file_name)

Case of 
	: ($file_extension="mpeg") | ($file_extension="mpg")  //   Mod: DB (09/12/2012)
		$mime_type:="video/mpeg"
		
	: ($file_extension="pic") | ($file_extension="pict")  //   Mod: DB (09/12/2012)
		$mime_type:="image/pict"
		
	: ($file_extension="tif") | ($file_extension="tiff")
		$mime_type:="image/tiff"
		
	: ($file_extension="jpg") | ($file_extension="jpeg") | ($file_extension="jpe")
		$mime_type:="image/jpeg"
		
	: ($file_extension="gif") | ($file_extension="bmp") | ($file_extension="png")
		$mime_type:="image/"+$file_extension
		
	: ($file_extension="json")  //   Mod: DB (09/12/2012)
		$mime_type:="application/json"
		
	: ($file_extension="js")  //   Mod: DB (09/12/2012)
		$mime_type:="application/javascript"
		
	: ($file_extension="css")
		$mime_type:="text/css"
		
	: ($file_extension="txt") | ($file_extension="text")
		$mime_type:="text/plain"
		
	: ($file_extension="csv")
		$mime_type:="text/csv"
		
	: ($file_extension="pdf")
		$mime_type:="application/pdf"
		
	: ($file_extension="xls") | ($file_extension="slk")
		$mime_type:="application/vnd.ms-excel"
		
	: ($file_extension="doc")
		$mime_type:="application/msword"
		
	: ($file_extension="ppt")
		$mime_type:="application/vnd.ms-powerpoint"
		
	: ($file_extension="xlsx")
		$mime_type:="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
		
	: ($file_extension="docx")
		$mime_type:="application/vnd.openxmlformats-officedocument.wordprocessingml.document"
		
	: ($file_extension="pptx")
		$mime_type:="application/vnd.openxmlformats-officedocument.presentationml.presentation"
		
	: ($file_extension="xml")  //   Mod: DB (09/12/2012)
		$mime_type:="application/xml"
		
	: ($file_extension="rtf")
		$mime_type:="application/rtf"
		
	: ($file_extension="zip")
		$mime_type:="application/zip"
		
	: ($file_extension="html") | ($file_extension="htm") | ($file_extension="shtml") | ($file_extension="shtm")  //   Mod: DB (01/10/2012) - add direct support for HTML
		$mime_type:="text/html"
		
	Else 
		//$mime_type:="text/plain"
		$mime_type:="application/octet-stream"
		
End case 
