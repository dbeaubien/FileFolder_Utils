//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// File_CompressIt (src_file; dst_zip)
// 
// DESCRIPTION
//   Compresses the specified file to the specified dst zip file.
//
#DECLARE($src_file_platformPath : Text; $dest_zip_file_platformPath : Text)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=2)

var $src_file; $destination_file : 4D:C1709.File
$destination_file:=File:C1566($dest_zip_file_platformPath; fk platform path:K87:2)
$src_file:=File:C1566($src_file_platformPath; fk platform path:K87:2)

If ($destination_file.exists)
	$destination_file.delete()
End if 

var $status : Object
$status:=ZIP Create archive:C1640($src_file; $destination_file)