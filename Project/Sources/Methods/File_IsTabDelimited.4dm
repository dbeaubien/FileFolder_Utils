//%attributes = {"invisible":true,"shared":true,"preemptive":"capable","lang":"en"}
  // File_IsTabDelimited (pathToFile) : isTabDelimited
  // File_IsTabDelimited (text) : boolean
  //
  // DESCRIPTION
  //   Returns true if the file is tab-delimited.
  //
  // TESTS performed:
  //   1. Is file extension ".tsv" or ".txt"
  //   2. Look at first line, expect line of tab delimited values.
  //   3. At least 2 non-empty values in the header line.
  //
C_TEXT:C284($1;$pathToFile)
C_BOOLEAN:C305($0;$isTabDelimited)
ASSERT:C1129(Count parameters:C259=1)
$pathToFile:=$1
$isTabDelimited:=False:C215

Case of 
	: (Not:C34(STR_IsOneOf ($pathToFile;"@.txt";"@.tsv")))
	: (Not:C34(File_DoesExist ($pathToFile)))
	Else 
		$isTabDelimited:=File_IsDelimited($pathToFile; Char:C90(Tab:K15:37))			
End case 

$0:=$isTabDelimited