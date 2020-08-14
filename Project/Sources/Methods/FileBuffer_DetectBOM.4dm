  //%attributes = {"invisible":true,"preemptive":"capable","lang":"en"} comment added and reserved by 4D.
  // FileBuffer_DetectBOM ()
  //
  // DESCRIPTION
  //   
  //
  // ----------------------------------------------------
  // HISTORY
  //   Created by: Dani Beaubien (11/25/2019)
  // ----------------------------------------------------

  // https://en.wikipedia.org/wiki/Byte_order_mark
  // http://www.iana.org/assignments/character-sets
  // https://www.unicode.org/faq/utf_bom.html

C_TEXT(fileBuffer_charSet)

C_BLOB($blob)
RECEIVE PACKET(fileBuffer_DocRef;$blob;10)

If (fileBuffer_charSet="") & (BLOB size($blob)>=4)
If ($blob{0}=0) & ($blob{1}=0) & ($blob{2}=254) & ($blob{4}=255)  // starts with the little-endian UTF-32 BOM?
fileBuffer_charSet:="UTF-32LE"
End if 
If ($blob{0}=255) & ($blob{1}=254) & ($blob{2}=0) & ($blob{4}=0)  // starts with the big-endian UTF-32 BOM?
fileBuffer_charSet:="UTF-32BE"
End if 
End if 

If (fileBuffer_charSet="") & (BLOB size($blob)>=3)
If ($blob{0}=239) & ($blob{1}=187) & ($blob{2}=191)  // starts with the UTF-8 BOM?
fileBuffer_charSet:="UTF-8"
End if 
End if 

If (fileBuffer_charSet="") & (BLOB size($blob)>=2)
If ($blob{0}=255) & ($blob{1}=254)  // starts with the little-endian UTF-16 BOM?
fileBuffer_charSet:="UTF-16LE"
End if 
If ($blob{0}=254) & ($blob{1}=255)  // starts with the big-endian UTF-16 BOM?
fileBuffer_charSet:="UTF-16BE"
End if 
End if 

SET DOCUMENT POSITION(fileBuffer_DocRef;0;1)  // position 0 releative to document start