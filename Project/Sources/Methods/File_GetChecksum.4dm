//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// File_GetChecksum (filePath; hashAlgorithm) : checksum
// File_GetChecksum (text; text) : text
// 
// DESCRIPTION
//   This method returns the checksum for a file.
//   Supported hash algorithms of "mdf5" or "sha1",
//    everything else resolves to "md5"
//   NOTE: The file is loaded into memory.
// ----------------------------------------------------
#DECLARE($vt_filePath : Text; $vt_hash_algorithm : Text)->$checksum_out_t : Text
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=2)
var $fileToHash_t : Text

If (Not:C34(File_DoesExist($vt_filePath)))
	return 
End if 

OnErr_Install_Handler("OnErr_GENERIC")

var $FirstBlob : Blob
var $vhDocRef1 : Time
$vhDocRef1:=Open document:C264($vt_filePath; "*"; Read mode:K24:5)
If (OK=1)  // If a document is selected
	DOCUMENT TO BLOB:C525(Document; $FirstBlob)  // Load document
	If (OK=1)
		Case of 
			: ($vt_hash_algorithm="md5")
				$checksum_out_t:=Generate digest:C1147($FirstBlob; MD5 digest:K66:1)
			: ($vt_hash_algorithm="sha1")
				$checksum_out_t:=Generate digest:C1147($FirstBlob; SHA1 digest:K66:2)
			Else 
				$checksum_out_t:=Generate digest:C1147($FirstBlob; MD5 digest:K66:1)
		End case 
	End if 
	
	CLOSE DOCUMENT:C267($vhDocRef1)
End if 
SET BLOB SIZE:C606($FirstBlob; 0)

OnErr_Install_Handler