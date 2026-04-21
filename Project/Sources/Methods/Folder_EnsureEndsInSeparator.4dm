//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// Folder_EnsureEndsInSeparator (path) : verifiedPath
// Folder_EnsureEndsInSeparator (text) : text
//
// DESCRIPTION
//   Ensures that the folder path ends in a folder separator.
//   Empty strings are ignored.
//
#DECLARE($verifiedPath : Text) : Text
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)

If ($verifiedPath#"")
	If ($verifiedPath[[Length:C16($verifiedPath)]]#Folder separator:K24:12)  // make sure the path ends in a folder
		$verifiedPath+=Folder separator:K24:12
	End if 
End if 

return $verifiedPath