//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// File_ExportTableSelection2CSV (tablePtr; fieldsToSkip; exportToFilePath) : results
// File_ExportTableSelection2CSV (pointer; collection of field Ptrs; text) : object
//
// DESCRIPTION
//   Exports the current selection of records
// ----------------------------------------------------
#DECLARE($tablePtr : Pointer; $fieldPtrsToSkip : Collection; $exportToFilePath : Text)->$exportResults : Object
// ----------------------------------------------------
$exportResults:={status: "pending"}

If (Asserted:C1132(Count parameters:C259=3))
	
	var $fieldNosToSkip : Collection
	$fieldNosToSkip:=[]
	
	// need to convert to #s
	var $i : Integer
	For ($i; 0; $fieldPtrsToSkip.length-1)
		$fieldNosToSkip.push(Field:C253($fieldPtrsToSkip[$i]))
	End for 
	
	// Build up the list of fields to export
	var $fieldsToExport : Collection
	$fieldsToExport:=[]
	
	var $fieldNo; $tableNo : Integer
	var $fieldPtr : Pointer
	$tableNo:=Table:C252($tablePtr)
	For ($fieldNo; 1; Last field number:C255($tableNo))
		If (Is field number valid:C1000($tableNo; $fieldNo))
			$fieldPtr:=Field:C253($tableNo; $fieldNo)
			If ($fieldNosToSkip.indexOf($fieldNo)<0)
				$fieldsToExport.push($fieldPtr)
			End if 
		End if 
	End for 
	
	File_Delete($exportToFilePath)
	
	var $docRef : Time
	$docRef:=Create document:C266($exportToFilePath)
	If (OK=1)
		var $eol : Text
		$eol:=Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
		
		// output the header
		For ($i; 0; $fieldsToExport.length-1)
			If ($i>0)
				SEND PACKET:C103($docRef; ",")
			End if 
			SEND PACKET:C103($docRef; Field name:C257($fieldsToExport[$i])+":f"+String:C10(Field:C253($fieldsToExport[$i])))  // output field name and field #
		End for 
		SEND PACKET:C103($docRef; $eol)
		
		// output the data
		var $buffer : Text
		For ($i; 1; Records in selection:C76($tablePtr->))
			$buffer+=CSV_LineFromFieldCollection($fieldsToExport; $eol)
			If (Length:C16($buffer)>4096)
				SEND PACKET:C103($docRef; $buffer)
				$buffer:=""
			End if 
			NEXT RECORD:C51($tablePtr->)
		End for 
		SEND PACKET:C103($docRef; $buffer)
		CLOSE DOCUMENT:C267($docRef)
		$exportResults.status:="sucess"
	Else 
		$exportResults.status:="failed"
		$exportResults.errorMessage:="Could not create export file."
	End if 
	
End if 