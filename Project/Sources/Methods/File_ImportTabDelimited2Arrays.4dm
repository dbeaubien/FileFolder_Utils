//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// File_ImportTabDelimited2Arrays (filePath; arr1, ... , arrN)
// 
// DESCRIPTION
//   A generic method for importing delimited files into passed arrays.
//
var $1; $import_file_platformPath : Text
C_POINTER:C301(${2})
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259>=1)
ASSERT:C1129(Count parameters:C259<=20)
$import_file_platformPath:=$1

// # setup our arrays
var $num_cols; $i : Integer
$num_cols:=Count parameters:C259-1
ARRAY POINTER:C280($vp_ArrayOfArrayPtrs; $num_cols)
For ($i; 2; Count parameters:C259)
	ASSERT:C1129(PTR_IsArray(${$i}); Current method name:C684+" $"+String:C10($i)+" is not an array ptr.")
	$vp_ArrayOfArrayPtrs{$i-1}:=${$i}
	ARRAY TEXT:C222($vp_ArrayOfArrayPtrs{$i-1}->; 0)
End for 

// # open the file and start importing the data
If (File_DoesExist($import_file_platformPath))
	var $docRef : Time
	var $eol; $one_line : Text
	$docRef:=Open document:C264($import_file_platformPath; ""; Read mode:K24:5)
	If (OK=1)
		FileBuffer_Init($docRef)
		$eol:=FileBuffer_TellMeTheEOL
		
		var $line_parts : Collection
		Repeat 
			$one_line:=FileBuffer_FetchData_ByString($eol)
			$one_line:=Replace string:C233($one_line; $eol; "")  // ensure the eol is not there
			
			If ($one_line#"")
				$line_parts:=Split string:C1554($one_line; Char:C90(Tab:K15:37))
				For ($i; 1; $num_cols)
					If ($line_parts.length>=$i)
						APPEND TO ARRAY:C911($vp_ArrayOfArrayPtrs{$i}->; $line_parts[$i-1])
					Else 
						APPEND TO ARRAY:C911($vp_ArrayOfArrayPtrs{$i}->; "")
					End if 
				End for 
			End if 
		Until (FileBuffer_EOF)
		
		CLOSE DOCUMENT:C267($docRef)
	End if 
End if 
