//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// File_ExportTableSelection2CSV (tablePtr; fieldsToSkip; exportToFilePath) : results
// File_ExportTableSelection2CSV (pointer; collection of field Ptrs; text) : object
//
// DESCRIPTION
//   Exports the current selection of records
//
C_POINTER:C301($1; $tablePtr)
C_COLLECTION:C1488($2; $fieldPtrsToSkip)
C_TEXT:C284($3; $exportToFilePath)
C_OBJECT:C1216($0; $exportResults)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (06/06/2020)
// ----------------------------------------------------

$exportResults:=New object:C1471("status"; "pending")
If (Asserted:C1132(Count parameters:C259=3))
	$tablePtr:=$1
	$fieldPtrsToSkip:=$2
	$exportToFilePath:=$3
	
	C_COLLECTION:C1488($fieldNosToSkip)
	$fieldNosToSkip:=New collection:C1472
	If (True:C214)  // need to convert to #s
		C_LONGINT:C283($i)
		For ($i; 0; $fieldPtrsToSkip.length-1)
			$fieldNosToSkip.push(Field:C253($fieldPtrsToSkip[$i]))
		End for 
	End if 
	
	
	C_COLLECTION:C1488($fieldsToExport)
	If (True:C214)  // Build up the list of fields to export
		$fieldsToExport:=New collection:C1472
		
		C_LONGINT:C283($fieldNo; $tableNo)
		C_POINTER:C301($fieldPtr)
		$tableNo:=Table:C252($tablePtr)
		For ($fieldNo; 1; Get last field number:C255($tableNo))
			If (Is field number valid:C1000($tableNo; $fieldNo))
				$fieldPtr:=Field:C253($tableNo; $fieldNo)
				If ($fieldNosToSkip.indexOf($fieldNo)<0)
					$fieldsToExport.push($fieldPtr)
				End if 
			End if 
		End for 
	End if 
	
	
	File_Delete($exportToFilePath)
	
	C_TIME:C306($docRef)
	$docRef:=Create document:C266($exportToFilePath)
	If (OK=1)
		C_TEXT:C284($eol)
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
		C_TEXT:C284($buffer)
		For ($i; 1; Records in selection:C76($tablePtr->))
			If (Mod:C98($i; 100000)=0)
				//Log_INFO("  exported "+String($i; "###,###,###,##0")+" "+Table name($tablePtr)+" records ("+String($i/Records in selection($tablePtr->)*100; "##0.00")+"%)")
			End if 
			$buffer:=$buffer+CSV_LineFromFieldCollection($fieldsToExport; $eol)
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
$0:=$exportResults