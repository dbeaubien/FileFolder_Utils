//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
  // File_IsJPG (pathToImage) : isJPG
  // File_IsJPG (text) : boolean
  //
  // DESCRIPTION
  //   Returns true if the image file is a JPG.
  //   The file extension is ignored, it looks at the image directly.
  //
C_TEXT:C284($1;$pathToImage)
C_BOOLEAN:C305($0;$isJPG)
  // ----------------------------------------------------
  // HISTORY
  //   Created by: Dani Beaubien (09/11/2018)
  // ----------------------------------------------------

$isJPG:=False:C215
If (Asserted:C1132(Count parameters:C259=1))
	$pathToImage:=$1
	
	If (File_DoesExist($pathToImage))
		C_PICTURE:C286($theImage)
		READ PICTURE FILE:C678($pathToImage;$theImage)
		
		ARRAY TEXT:C222($codecIDs;0)
		GET PICTURE FORMATS:C1406($theImage;$codecIDs)
		
		C_LONGINT:C283($i)
		For ($i;1;Size of array:C274($codecIDs))
			If (STR_IsOneOf($codecIDs{$i};".jpg";"image/jpeg"))
				$isJPG:=True:C214
			End if 
		End for 
	End if 
	
End if 
$0:=$isJPG