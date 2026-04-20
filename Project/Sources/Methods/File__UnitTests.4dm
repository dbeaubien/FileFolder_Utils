//%attributes = {"invisible":true,"preemptive":"incapable"}
// (PM) File__UnitTests 
// $1 = Action

// CALLED BY: UnitTest_Setup_IHCore
#DECLARE($action : Text)

If (Count parameters:C259=0)
	UnitTest_RunAll
	return 
End if 

var $filePath : Text
var $filename; $vt : Text
var $fileRef : Time
Case of 
		
	: ($action="RunTests")
		UnitTest_RunTest("File_DeriveMimeTypeFromName")
		UnitTest_RunTest("File_GetExtension")
		UnitTest_RunTest("File_GetFileName")
		UnitTest_RunTest("File_GetFolderName")
		UnitTest_RunTest("File_Position")
		UnitTest_RunTest("File_GenerateUniqueName")
		UnitTest_RunTest("File_ImportTabDelimited2Arrays")
		
		UnitTest_RunTest("File Delimiter Detection")
		
		
	: ($action="Setup")
		
	: ($action="TearDown")
		
		
		
	: ($action="File_GenerateUniqueName")
		$vt:=File_GenerateUniqueName
		UnitTest_AssertFalse($vt="")
		DELAY PROCESS:C323(Current process:C322; 1)
		UnitTest_AssertFalse($vt=File_GenerateUniqueName)
		
		
	: ($action="File_Position")
		$filename:=Get 4D folder:C485(Data folder:K5:33)+"File_Position.txt"
		File_Delete($filename)
		$fileRef:=Create document:C266($filename)
		If (OK=1)
			SEND PACKET:C103($fileRef; "123456789\r")
			SEND PACKET:C103($fileRef; "123456789\r")
			SEND PACKET:C103($fileRef; "123456789\r")
			SEND PACKET:C103($fileRef; "Dani Beaubien\r")
			SEND PACKET:C103($fileRef; "123456789\r")
			SEND PACKET:C103($fileRef; "Shelley Beaubien\r")
			SEND PACKET:C103($fileRef; "123456789\r")
			CLOSE DOCUMENT:C267($fileRef)
		End if 
		
		$fileRef:=Open document:C264(Get 4D folder:C485(Data folder:K5:33)+"File_Position.txt"; Read mode:K24:5)
		UnitTest_AssertEqualLongint(1; OK)
		UnitTest_AssertEqualLongint(0; File_Position("1"; $fileRef))
		UnitTest_AssertEqualLongint(8; File_Position("9"; $fileRef))
		UnitTest_AssertEqualLongint(30; File_Position("Dani"; $fileRef))
		UnitTest_AssertEqualLongint(54; File_Position("Shelley"; $fileRef))
		UnitTest_AssertEqualLongint(54; File_Position("Shelley Beaubien"; $fileRef))
		UnitTest_AssertEqualLongint(30; File_Position("Dani Beaubien"; $fileRef))
		UnitTest_AssertEqualLongint(35; File_Position("Beaubien"; $fileRef))
		UnitTest_AssertEqualLongint(35; File_Position("Beaubien"; $fileRef; 10))
		UnitTest_AssertEqualLongint(35; File_Position("Beaubien"; $fileRef; -6000))
		UnitTest_AssertEqualLongint(-1; File_Position("Beaubien"; $fileRef; 6000))
		UnitTest_AssertEqualLongint(35; File_Position("Beaubien"; $fileRef; -60))
		UnitTest_AssertEqualLongint(62; File_Position("Beaubien"; $fileRef; 36))
		UnitTest_AssertEqualLongint(62; File_Position("Beaubien"; $fileRef; -20))
		CLOSE DOCUMENT:C267($fileRef)
		
		File_Delete(Get 4D folder:C485(Data folder:K5:33)+"File_Position.txt")
		
		
	: ($action="File_DeriveMimeTypeFromName")
		UnitTest_AssertEqualText("image/png"; File_DeriveMimeTypeFromName("teest.png"))
		UnitTest_AssertEqualText("text/html"; File_DeriveMimeTypeFromName("teest.htm"))
		UnitTest_AssertEqualText("text/html"; File_DeriveMimeTypeFromName("teest.html"))
		UnitTest_AssertEqualText("application/octet-stream"; File_DeriveMimeTypeFromName("teest.htmll"))
		
		
	: ($action="File_GetExtension")
		UnitTest_AssertEqualText(""; File_GetExtension("test"))
		UnitTest_AssertEqualText("test"; File_GetExtension("test.test"))
		UnitTest_AssertEqualText("zip"; File_GetExtension("test.txt.zip"))
		UnitTest_AssertEqualText(""; File_GetExtension("happy.place"+Folder separator:K24:12+"test"))
		
		
	: ($action="File_GetFileName")
		UnitTest_AssertEqualText(""; File_GetFileName("test"+Folder separator:K24:12))
		UnitTest_AssertEqualText("test"; File_GetFileName("test"))
		UnitTest_AssertEqualText("tes$t"; File_GetFileName("tes$t"))
		UnitTest_AssertEqualText("word2"; File_GetFileName("word"+Folder separator:K24:12+"word2"))
		UnitTest_AssertEqualText("word2"; File_GetFileName("word"+Folder separator:K24:12+"word3"+Folder separator:K24:12+"word2"))
		
		
	: ($action="File_GetFolderName")
		$filePath:="Root"+Folder separator:K24:12+"child1"+Folder separator:K24:12+"child2"
		UnitTest_AssertEqualText("Root"+Folder separator:K24:12+"child1"+Folder separator:K24:12; File_GetFolderName($filePath+Folder separator:K24:12))
		UnitTest_AssertEqualText("Root"+Folder separator:K24:12+"child1"+Folder separator:K24:12; File_GetFolderName($filePath))
		
		$filePath:="Root"
		UnitTest_AssertEqualText(""; File_GetFolderName($filePath))
		UnitTest_AssertEqualText(""; File_GetFolderName($filePath+Folder separator:K24:12))
		
		UnitTest_AssertEqualText("word"+Folder separator:K24:12; File_GetFolderName("word"+Folder separator:K24:12+"word2"))
		UnitTest_AssertEqualText("word"+Folder separator:K24:12; File_GetFolderName("word"+Folder separator:K24:12+"word2"+Folder separator:K24:12))
		UnitTest_AssertEqualText("word"+Folder separator:K24:12+"word3"+Folder separator:K24:12; File_GetFolderName("word"+Folder separator:K24:12+"word3"+Folder separator:K24:12+"word2"))
		
		UnitTest_AssertEqualText(Structure file:C489; File_GetFolderName(Structure file:C489)+File_GetFileName(Structure file:C489))
		
		
	: ($action="File_ImportTabDelimited2Arrays")
		ARRAY TEXT:C222($at_ColumnName; 0)
		ARRAY TEXT:C222($at_Type; 0)
		ARRAY TEXT:C222($at_MaxLength; 0)
		ARRAY TEXT:C222($at_Required; 0)
		ARRAY TEXT:C222($at_ValidValues; 0)
		
		$filePath:=Get 4D folder:C485(Current resources folder:K5:16)+"Tests"+Folder separator:K24:12+"File - Tab 2 col test CRs.txt"
		File_ImportTabDelimited2Arrays($filePath; ->$at_ColumnName; ->$at_Type; ->$at_MaxLength; ->$at_Required; ->$at_ValidValues)
		UnitTest_AssertArraySize(4; ->$at_ColumnName)
		UnitTest_AssertArraySize(4; ->$at_Type)
		UnitTest_AssertArraySize(4; ->$at_MaxLength)
		UnitTest_AssertArraySize(4; ->$at_Required)
		UnitTest_AssertArraySize(4; ->$at_ValidValues)
		UnitTest_AssertFalse($at_ValidValues{1}="@\r")
		
		$filePath:=Get 4D folder:C485(Current resources folder:K5:16)+"Tests"+Folder separator:K24:12+"File - Tab 2 col test LFs.txt"
		File_ImportTabDelimited2Arrays($filePath; ->$at_ColumnName; ->$at_Type; ->$at_MaxLength; ->$at_Required; ->$at_ValidValues)
		UnitTest_AssertArraySize(4; ->$at_ColumnName)
		UnitTest_AssertArraySize(4; ->$at_Type)
		UnitTest_AssertArraySize(4; ->$at_MaxLength)
		UnitTest_AssertArraySize(4; ->$at_Required)
		UnitTest_AssertArraySize(4; ->$at_ValidValues)
		
		ARRAY TEXT:C222($at_Column1; 0)
		ARRAY TEXT:C222($at_Column2; 0)
		ARRAY TEXT:C222($at_Column3; 0)
		ARRAY TEXT:C222($at_Column4; 0)
		$filePath:=Get 4D folder:C485(Current resources folder:K5:16)+"Tests"+Folder separator:K24:12+"Index - Expected Fields.txt"
		File_ImportTabDelimited2Arrays($filePath; ->$at_Column1; ->$at_Column2; ->$at_Column3; ->$at_Column4)
		UnitTest_AssertArraySize(63; ->$at_Column1)
		UnitTest_AssertArraySize(63; ->$at_Column2)
		UnitTest_AssertArraySize(63; ->$at_Column3)
		UnitTest_AssertArraySize(63; ->$at_Column4)
		
		ARRAY TEXT:C222($at_Column1; 0)
		ARRAY TEXT:C222($at_Column2; 0)
		$filePath:=Get 4D folder:C485(Current resources folder:K5:16)+"Tests"+Folder separator:K24:12+"Index - Expected Fields.txt"
		File_ImportTabDelimited2Arrays($filePath; ->$at_Column1; ->$at_Column2)
		UnitTest_AssertArraySize(63; ->$at_Column1)
		UnitTest_AssertArraySize(63; ->$at_Column2)
		
		
	: ($action="File Delimiter Detection")
		var $txt : Text
		$txt:="test1,test2\rdata1,data2"
		$filePath:=System folder:C487(User preferences_user:K41:4)+"File_IsCSV.csv"
		TEXT TO DOCUMENT:C1237($filePath; $txt)
		UnitTest_AssertTrue(File_IsCSV($filePath); "T1: Is CSV")
		UnitTest_AssertFalse(File_IsTabDelimited($filePath); "T1: Is not tsv #1")
		UnitTest_AssertFalse(File_IsDelimited($filePath; Char:C90(Tab:K15:37)); "T1: Is not tsv #2")
		UnitTest_AssertTrue(File_IsDelimited($filePath; ","); "T1: Is not comma delimted")
		DELETE DOCUMENT:C159($filePath)
		
		$txt:="test1,test2\rdata1,data2"
		$filePath:=System folder:C487(User preferences_user:K41:4)+"File_IsCSV.txt"
		TEXT TO DOCUMENT:C1237($filePath; $txt)
		UnitTest_AssertTrue(File_IsCSV($filePath); "T2: Is CSV")
		UnitTest_AssertFalse(File_IsTabDelimited($filePath); "T2: Is not tsv #1")
		UnitTest_AssertFalse(File_IsDelimited($filePath; Char:C90(Tab:K15:37)); "T2: Is not tsv #2")
		UnitTest_AssertTrue(File_IsDelimited($filePath; ","); "T2: Is comma delimted")  // true since file name is .txt
		DELETE DOCUMENT:C159($filePath)
		
		$txt:="test1"+Char:C90(Tab:K15:37)+"test2\rdata1"+Char:C90(Tab:K15:37)+"data2"
		$filePath:=System folder:C487(User preferences_user:K41:4)+"File_IsTSV.txt"
		TEXT TO DOCUMENT:C1237($filePath; $txt)
		UnitTest_AssertFalse(File_IsCSV($filePath); "T3: Is not CSV")
		UnitTest_AssertTrue(File_IsTabDelimited($filePath); "T3: Is tsv #1")
		UnitTest_AssertTrue(File_IsDelimited($filePath; Char:C90(Tab:K15:37)); "T3: Is tsv #2")
		UnitTest_AssertFalse(File_IsDelimited($filePath; ","); "T3: Is not comma delimted")  // true since file name is .txt
		DELETE DOCUMENT:C159($filePath)
		
		$txt:="test1|test2\rdata1|data2"
		$filePath:=System folder:C487(User preferences_user:K41:4)+"File_IsPipe.txt"
		TEXT TO DOCUMENT:C1237($filePath; $txt)
		UnitTest_AssertFalse(File_IsCSV($filePath); "T3: Is not CSV")
		UnitTest_AssertFalse(File_IsTabDelimited($filePath); "T3: Is tsv #1")
		UnitTest_AssertFalse(File_IsDelimited($filePath; Char:C90(Tab:K15:37)); "T3: Is tsv #2")
		UnitTest_AssertTrue(File_IsDelimited($filePath; "|"); "T3: Is pio delimted")  // true since file name is .txt
		DELETE DOCUMENT:C159($filePath)
		
		
	Else 
		UnitTest_Assert(False:C215; "unexpected action of \""+$action+"\".")
		
End case 