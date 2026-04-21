//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// File_IsPNG (pathToImage) : isPNG
// File_IsPNG (text) : boolean
//
// DESCRIPTION
//   Returns true if the image file is a PNG.
//   The file extension is ignored, it looks at the image directly.
//
#DECLARE($path_to_image : Text)->$is_file_png : Boolean
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)

If (File_DoesExist($path_to_image))
	var $image : Picture
	READ PICTURE FILE:C678($path_to_image; $image)
	
	ARRAY TEXT:C222($codec_id_list; 0)
	GET PICTURE FORMATS:C1406($image; $codec_id_list)
	
	var $index : Integer
	For ($index; 1; Size of array:C274($codec_id_list))
		If (STR_IsOneOf($codec_id_list{$index}; ".png"; "image/png"))
			$is_file_png:=True:C214
		End if 
	End for 
End if 
