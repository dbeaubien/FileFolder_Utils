//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// File_Import2Collection (importObject) : importedRowCollection
//
// DESCRIPTION
//   Peform the import based on the defined columns.
//   A collection of imported rows is returned.
//
#DECLARE($importObj : Object)->$importedRowCollection : Collection
// ----------------------------------------------------
// HISTORY
//   Created by: DB (08/23/2019)
//   Mod by: DB (01/22/2021) - Task 6836 - Added support for a pipe delimiter and header aliases
//   Mod: DB (10/26/2022) - Task 7825 - trim extra spaces
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)
$importedRowCollection:=New collection:C1472

Case of 
	: (Not:C34(File_DoesExist($importObj.importFilePath)))
		$importObj.status:="failed"
		$importObj.errorMessage:="File does not exist"
		
	: ($importObj.fileFormat="") | ($importObj.fileFormat="unknown")
		$importObj.status:="failed"
		$importObj.errorMessage:="File format is not supported. Only CSV, tab-delimited, pipe-delimited is supported."
		
	Else 
		
		var $fileRef : Time
		$fileRef:=Open document:C264($importObj.importFilePath; Read mode:K24:5)
		If (OK=1)
			FileBuffer_Init($fileRef)
			
			var $eol : Text
			$eol:=FileBuffer_TellMeTheEOL
			
			// Clear any previously imported data
			$importObj.importedData:=$importedRowCollection
			
			If (True:C214)  // Load the header row and determine positions of each column in the collection
				ARRAY TEXT:C222($columnValuesArr; 0)
				If ($importObj.fileFormat="CSV")
					FileBuffer_FetchCSVLine($eol; ->$columnValuesArr)
				End if 
				If ($importObj.fileFormat="TSV")
					FileBuffer_FetchTabDelimitedLne($eol; ->$columnValuesArr)
				End if 
				If ($importObj.fileFormat="pipe")
					FileBuffer_FetchDelimitedLne($eol; ->$columnValuesArr; "|")
				End if 
				
				var $i : Integer
				For ($i; 1; Size of array:C274($columnValuesArr))  // clean up headers
					$columnValuesArr{$i}:=STR_TrimExcessSpaces($columnValuesArr{$i})
				End for 
				
				C_TEXT:C284($alias)
				C_OBJECT:C1216($column)
				C_LONGINT:C283($numColumns)
				For each ($column; $importObj.columnDefinitions)
					$column.columnPosition:=Find in array:C230($columnValuesArr; $column.headerLabel)
					For each ($alias; $column.headerLabelAliases)  // Task 6836
						If ($column.columnPosition<=0)  // not found yet?
							$column.columnPosition:=Find in array:C230($columnValuesArr; $alias)
						End if 
					End for each 
					$numColumns:=NUM_GetMaxLong($numColumns; $column.columnPosition)
				End for each 
			End if 
			
			While (Not:C34(FileBuffer_EOF))
				// Load one line and put into an array for easier processing
				If ($importObj.fileFormat="CSV")
					FileBuffer_FetchCSVLine($eol; ->$columnValuesArr)
				End if 
				If ($importObj.fileFormat="TSV")
					FileBuffer_FetchTabDelimitedLne($eol; ->$columnValuesArr)
				End if 
				If ($importObj.fileFormat="pipe")
					FileBuffer_FetchDelimitedLne($eol; ->$columnValuesArr; "|")
				End if 
				If ($numColumns>Size of array:C274($columnValuesArr))  // ensure our array matches the # of columns we have defined
					ARRAY TEXT:C222($columnValuesArr; $numColumns)
				End if 
				
				C_OBJECT:C1216($rowObject)
				$rowObject:=New object:C1471
				For each ($column; $importObj.columnDefinitions)
					If ($column.columnPosition<=0)  // skip over since column was not found
						$rowObject[$column.objectAttributeName]:=$column.defaultValue
						
					Else 
						If (NUM_IsOneOf($column.valueType; Is boolean:K8:9; Is real:K8:4; Is longint:K8:6; Is date:K8:7))
							$columnValuesArr{$column.columnPosition}:=STR_TrimExcessQuotes($columnValuesArr{$column.columnPosition})
						End if 
						$columnValuesArr{$column.columnPosition}:=STR_TrimExcessSpaces($columnValuesArr{$column.columnPosition})
						
						Case of 
							: ($column.valueType=Is boolean:K8:9)
								$rowObject[$column.objectAttributeName]:=STR_IsOneOf($columnValuesArr{$column.columnPosition}; "Yes"; "Y"; "True"; "1")
								
							: ($column.valueType=Is real:K8:4)
								$rowObject[$column.objectAttributeName]:=Num:C11($columnValuesArr{$column.columnPosition})
								
							: ($column.valueType=Is longint:K8:6)
								$rowObject[$column.objectAttributeName]:=Int:C8(Num:C11($columnValuesArr{$column.columnPosition}))
								
							: ($column.valueType=Is date:K8:7) & (STR_isDate_MMDDYYYY($columnValuesArr{$column.columnPosition}))
								$rowObject[$column.objectAttributeName]:=String2Date($columnValuesArr{$column.columnPosition}; "mm-dd-yyyy")
								
							: ($column.valueType=Is date:K8:7) & (STR_isDate($columnValuesArr{$column.columnPosition}))
								$rowObject[$column.objectAttributeName]:=STR_isDate_GetDate($columnValuesArr{$column.columnPosition})
								
							: ($column.valueType=Is date:K8:7) & (STR_isISODate($columnValuesArr{$column.columnPosition}))
								$rowObject[$column.objectAttributeName]:=String2Date($columnValuesArr{$column.columnPosition}; "yyyy-mm-dd")
								
							: ($column.valueType=Is date:K8:7)
								$rowObject[$column.objectAttributeName]:=!00-00-00!
								
							Else 
								$rowObject[$column.objectAttributeName]:=$columnValuesArr{$column.columnPosition}
						End case 
					End if 
				End for each 
				$importedRowCollection.push($rowObject)
			End while 
			
			$importObj.status:="success"
			
			CLOSE DOCUMENT:C267($fileRef)
		End if 
End case 