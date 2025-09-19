//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// Folder_isOnMountedVolume (pathToFolder) : is Valid Volume
// 
// DESCRIPTION
//   Returns true if the path is on a volume that is
//   currently mounted.
//
C_TEXT:C284($1; $vt_thePath)
C_BOOLEAN:C305($0; $vb_volumeIsValid)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)

$vb_volumeIsValid:=False:C215
$vt_thePath:=$1

ARRAY TEXT:C222($at_volumes; 0)
VOLUME LIST:C471($at_volumes)

C_LONGINT:C283($i)
For ($i; 1; Size of array:C274($at_volumes))
	If (Is Windows:C1573)
		If ($vt_thePath=($at_volumes{$i}+"@"))
			$vb_volumeIsValid:=True:C214
		End if 
	Else 
		If ($vt_thePath=($at_volumes{$i}+Folder separator:K24:12+"@"))
			$vb_volumeIsValid:=True:C214
		End if 
	End if 
End for 

$0:=$vb_volumeIsValid
