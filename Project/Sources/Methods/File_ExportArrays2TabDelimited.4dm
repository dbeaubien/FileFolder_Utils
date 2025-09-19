//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// File_ExportArrays2TabDelimited (filePath; array1; array2; ... ; arrayn)
// File_ExportArrays2TabDelimited (text; ptr; ptr; ... ; ptr)
// 
// DESCRIPTION
//   A generic method for importing delimited files into passed arrays.
//
C_TEXT:C284($1; $vt_pathToFileToImport)
C_POINTER:C301(${2})
// ----------------------------------------------------
// HISTORY
//   Created by: DB (08/25/09)
// ----------------------------------------------------
ASSERT:C1129((Count parameters:C259>=2) & (Count parameters:C259<=20))


$vt_pathToFileToImport:=$1

// Remove the file, prep for writing
File_Delete($vt_pathToFileToImport)

// # setup our arrays
C_LONGINT:C283($vl_numCols; $i; $row; $col)
$vl_numCols:=Count parameters:C259-1

If ($vl_numCols>0)
	ARRAY POINTER:C280($vp_ArrayOfArrayPtrs; $vl_numCols)
	For ($i; 2; Count parameters:C259)
		ASSERT:C1129(PTR_IsArray(${$i}); Current method name:C684+" $"+String:C10($i)+" is not an array ptr.")
		$vp_ArrayOfArrayPtrs{$i-1}:=${$i}
	End for 
	
	// # open the file and start importing the data
	C_TIME:C306($docRef)
	$docRef:=File_CreateFile($vt_pathToFileToImport; "TXT")
	If (OK=1)
		
		C_TEXT:C284($vt_tmp)
		For ($row; 1; Size of array:C274($vp_ArrayOfArrayPtrs{1}->))
			For ($col; 1; $vl_numCols)
				$vt_tmp:=$vp_ArrayOfArrayPtrs{$col}->{$row}
				If ($col#$vl_numCols)
					SEND PACKET:C103($docRef; $vt_tmp+Char:C90(Tab:K15:37))
				Else 
					SEND PACKET:C103($docRef; $vt_tmp+Char:C90(Carriage return:K15:38))
				End if 
			End for 
		End for 
		
		CLOSE DOCUMENT:C267($docRef)
	End if 
End if 