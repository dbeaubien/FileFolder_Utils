//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// File_ExportArrays2CSV (filePath; array1; array2; ... ; arrayn)
// File_ExportArrays2CSV (text; ptr; ptr; ... ; ptr)
// 
// DESCRIPTION
//   A generic method for exporting arrays to a CSV delimited file.
// ----------------------------------------------------
#DECLARE($vt_pathToFile : Text;  ...  : Pointer)
// ----------------------------------------------------
ASSERT:C1129((Count parameters:C259>=2) && (Count parameters:C259<=20))

// Remove the file, prep for writing
File_Delete($vt_pathToFile)

// # setup our arrays
var $vl_numCols : Integer
$vl_numCols:=Count parameters:C259-1

If ($vl_numCols<=0)
	return 
End if 

ARRAY POINTER:C280($vp_ArrayOfArrayPtrs; $vl_numCols)
var $i; $row; $col; $vl_ArrayType : Integer
For ($i; 2; Count parameters:C259)
	ASSERT:C1129(PTR_IsArray(${$i}); Current method name:C684+" $"+String:C10($i)+" is not an array ptr.")
	$vp_ArrayOfArrayPtrs{$i-1}:=${$i}
End for 

// # open the file and start importing the data
var $docRef : Time
$docRef:=File_CreateFile($vt_pathToFile; "TXT")
If (OK=1)
	
	var $vt_tmp : Text
	$vt_tmp:=""
	For ($row; 1; Size of array:C274($vp_ArrayOfArrayPtrs{1}->))
		For ($col; 1; $vl_numCols)
			
			$vl_ArrayType:=Type:C295($vp_ArrayOfArrayPtrs{$col}->)
			Case of 
				: ($vl_ArrayType=String array:K8:15) || ($vl_ArrayType=Text array:K8:16)
					$vt_tmp+="\""+Replace string:C233($vp_ArrayOfArrayPtrs{$col}->{$row}; "\""; "\"\"")+"\""
					
				: ($vl_ArrayType=Date array:K8:20)
					$vt_tmp+="\""+Date2String($vp_ArrayOfArrayPtrs{$col}->{$row}; "Mon dd, yyyy")+"\""
					
				: ($vl_ArrayType=Boolean array:K8:21)
					$vt_tmp+=Boolean2String($vp_ArrayOfArrayPtrs{$col}->{$row}; "True"; "False")
					
				: ($vl_ArrayType=Picture array:K8:22)
					$vt_tmp+="\"picture array element not supported\""
					
				: ($vl_ArrayType=Pointer array:K8:23)
					$vt_tmp+="\"pointer array element not supported\""
					
				Else 
					$vt_tmp+=String:C10($vp_ArrayOfArrayPtrs{$col}->{$row})
			End case 
			
			
			If ($col#$vl_numCols)
				$vt_tmp+=","
			Else 
				$vt_tmp+=Char:C90(Carriage return:K15:38)
			End if 
			
			// If the buffer is bigger than 2k, then write to disk
			If (Length:C16($vt_tmp)>2048)
				SEND PACKET:C103($docRef; $vt_tmp)
				$vt_tmp:=""
			End if 
			
		End for 
	End for 
	
	SEND PACKET:C103($docRef; $vt_tmp)
	$vt_tmp:=""
	
	CLOSE DOCUMENT:C267($docRef)
End if 
