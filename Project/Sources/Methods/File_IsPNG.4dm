  //%attributes = {"invisible":true,"shared":true,"preemptive":"capable","lang":"en"} comment added and reserved by 4D.
  // File_IsPNG (pathToImage) : isPNG
  // File_IsPNG (text) : boolean
  //
  // DESCRIPTION
  //   Returns true if the image file is a PNG.
  //   The file extension is ignored, it looks at the image directly.
  //
C_TEXT($1;$pathToImage)
C_BOOLEAN($0;$isPNG)
  // ----------------------------------------------------
  // HISTORY
  //   Created by: Dani Beaubien (09/11/2018)
  // ----------------------------------------------------

$isPNG:=False
If (Asserted(Count parameters=1))
$pathToImage:=$1

If (File_DoesExist ($pathToImage))
C_PICTURE($theImage)
READ PICTURE FILE($pathToImage;$theImage)

ARRAY TEXT($codecIDs;0)
GET PICTURE FORMATS($theImage;$codecIDs)

C_LONGINT($i)
For ($i;1;Size of array($codecIDs))
If (STR_IsOneOf ($codecIDs{$i};".png";"image/png"))
$isPNG:=True
End if 
End for 
End if 

End if 
$0:=$isPNG