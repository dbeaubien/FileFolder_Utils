//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// File_DecompressIt (src_file; dst_zip)
// 
// DESCRIPTION
//   Decompresses the specified zip file to the specified dst file.
//
#DECLARE($src_zip_file_platformPath : Text; $dst_file_platformPath : Text)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=2)

var $src_zip_file; $destination_file : 4D:C1709.File
$src_zip_file:=File:C1566($src_zip_file_platformPath; fk platform path:K87:2)
$destination_file:=File:C1566($dst_file_platformPath; fk platform path:K87:2)

var $archive : Object
$archive:=ZIP Read archive:C1637($src_zip_file)

var $files : Collection
If ($archive.root#Null:C1517)
	$files:=$archive.root.files()
End if 

var $issues : Collection
$issues:=New collection:C1472()
If ($files.length=1)
	var $copied_file : 4D:C1709.File
	$copied_file:=$files[0].copyTo($destination_file.parent; $destination_file.fullName; fk overwrite:K87:5)
	If (Not:C34($copied_file.exists))
		$issues.push("Decompressing the file failed.")
	End if 
Else 
	$issues.push("Expecting the zip file to contain a single file. It contains "+String:C10($files.length))
End if 
