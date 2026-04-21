//%attributes = {"invisible":true,"preemptive":"incapable"}
// (PM) FileBuffer__UnitTests 
// $1 = Action

// CALLED BY: UnitTest_Setup_IHCore
#DECLARE($action : Text)
If (Count parameters:C259=0)
	UnitTest_RunAll
	return 
End if 

var $docRef : Time
var $filePath; $fileContents; $eol : Text
ARRAY TEXT:C222($array; 0)
$filePath:=System folder:C487(User preferences_user:K41:4)+"File.txt"
Case of 
	: ($action="Setup") || ($action="TearDown")
	: ($action="RunTests")
		UnitTest_RunTest("Basic Tests")
		UnitTest_RunTest("Basic Delimiter Tests")
		UnitTest_RunTest("CSV Tests")
		UnitTest_RunTest("CSV SEP= Tests")
		
		
	: ($action="Basic Tests")
		$fileContents:="test1,test2\rdata1,data2"
		TEXT TO DOCUMENT:C1237($filePath; $fileContents; "latin1"; Document unchanged:K24:18)
		$docRef:=Open document:C264($filePath; ""; Read mode:K24:5)
		UnitTest_AssertEqualLongint(1; OK)
		FileBuffer_Init($docRef)
		UnitTest_AssertEqualLongint(1; fileBuffer_curPos)
		UnitTest_AssertEqualTextAndCase($fileContents; fileBuffer_buffer)
		UnitTest_AssertEqualText("latin1"; fileBuffer_charSet)
		UnitTest_AssertEqualText("\r"; FileBuffer_TellMeTheEOL)
		UnitTest_AssertEqualText("test1,test2\r"; FileBuffer_FetchData_ByString(FileBuffer_TellMeTheEOL))
		UnitTest_AssertEqualText("data"; FileBuffer_FetchData_ByString("1"; "ta"))
		UnitTest_AssertEqualText("1"; FileBuffer_FetchData_PeekAhead(1))
		UnitTest_AssertEqualText("1,"; FileBuffer_FetchData_PeekAhead(2))
		UnitTest_AssertEqualText("1"; FileBuffer_FetchData_ByString("1"; "2"))
		UnitTest_AssertEqualText(",data2"; FileBuffer_FetchData_ByString("1"; "2"))
		UnitTest_AssertTrue(FileBuffer_EOF)
		UnitTest_AssertEqualText(""; FileBuffer_FetchData_PeekAhead(1))
		CLOSE DOCUMENT:C267($docRef)
		DELETE DOCUMENT:C159($filePath)
		
		
	: ($action="Basic Delimiter Tests")
		$fileContents:="test1"+Char:C90(Tab:K15:37)+"test2\rdata1"+Char:C90(Tab:K15:37)+"data2"
		TEXT TO DOCUMENT:C1237($filePath; $fileContents; "utf-16"; Document unchanged:K24:18)
		$docRef:=Open document:C264($filePath; ""; Read mode:K24:5)
		UnitTest_AssertEqualLongint(1; OK)
		FileBuffer_Init($docRef)
		FileBuffer_FetchDelimitedLne(FileBuffer_TellMeTheEOL; ->$array; "a")
		UnitTest_AssertEqualLongint(1; Size of array:C274($array))
		FileBuffer_FetchDelimitedLne(FileBuffer_TellMeTheEOL; ->$array; "t")
		UnitTest_AssertEqualLongint(3; Size of array:C274($array))
		UnitTest_AssertEqualText("da"; $array{1})
		UnitTest_AssertEqualText("a1\tda"; $array{2})
		UnitTest_AssertEqualText("a2"; $array{3})
		UnitTest_AssertTrue(FileBuffer_EOF)
		CLOSE DOCUMENT:C267($docRef)
		
		$docRef:=Open document:C264($filePath; ""; Read mode:K24:5)
		UnitTest_AssertEqualLongint(1; OK)
		FileBuffer_Init($docRef)
		FileBuffer_FetchTabDelimitedLne(FileBuffer_TellMeTheEOL; ->$array)
		UnitTest_AssertEqualLongint(2; Size of array:C274($array))
		UnitTest_AssertEqualText("test1"; $array{1})
		UnitTest_AssertEqualText("test2"; $array{2})
		FileBuffer_FetchCSVLine(FileBuffer_TellMeTheEOL; ->$array)
		UnitTest_AssertEqualLongint(1; Size of array:C274($array))
		UnitTest_AssertEqualText("data1"+Char:C90(Tab:K15:37)+"data2"; $array{1})
		UnitTest_AssertTrue(FileBuffer_EOF)
		CLOSE DOCUMENT:C267($docRef)
		DELETE DOCUMENT:C159($filePath)
		
		
	: ($action="CSV Tests")
		$fileContents:="test1,\"test2\""
		$fileContents+="\r\ndata1,\"da,ta2\""
		$fileContents+="\r\n"
		$fileContents+="\r\ndata3,\"da,\r\nta4\""
		$fileContents+="\r\ntest1,\"te\"\"s\"\"t2\""
		TEXT TO DOCUMENT:C1237($filePath; $fileContents; "utf-8"; Document unchanged:K24:18)
		$docRef:=Open document:C264($filePath; ""; Read mode:K24:5)
		UnitTest_AssertEqualLongint(1; OK)
		FileBuffer_Init($docRef)
		FileBuffer_FetchCSVLine(FileBuffer_TellMeTheEOL; ->$array)
		UnitTest_AssertEqualLongint(2; Size of array:C274($array)\
			; "line 1 length should be 2 rather than "+String:C10(Size of array:C274($array)))
		If (Size of array:C274($array)>=2)
			UnitTest_AssertEqualText("test1"; $array{1})
			UnitTest_AssertEqualText("test2"; $array{2})
		End if 
		
		FileBuffer_FetchCSVLine(FileBuffer_TellMeTheEOL; ->$array)
		UnitTest_AssertEqualLongint(2; Size of array:C274($array)\
			; "line 2 length should be 2 rather than "+String:C10(Size of array:C274($array)))
		If (Size of array:C274($array)>=2)
			UnitTest_AssertEqualText("data1"; $array{1})
			UnitTest_AssertEqualText("da,ta2"; $array{2})
		End if 
		
		FileBuffer_FetchCSVLine(FileBuffer_TellMeTheEOL; ->$array)
		UnitTest_AssertEqualLongint(1; Size of array:C274($array)\
			; "line 3 length should be 2 rather than "+String:C10(Size of array:C274($array)))
		If (Size of array:C274($array)>=1)
			UnitTest_AssertEqualText(""; $array{1})
		End if 
		UnitTest_AssertFalse(FileBuffer_EOF)
		
		FileBuffer_FetchCSVLine(FileBuffer_TellMeTheEOL; ->$array)
		UnitTest_AssertEqualLongint(2; Size of array:C274($array)\
			; "line 4 length should be 2 rather than "+String:C10(Size of array:C274($array)))
		If (Size of array:C274($array)>=2)
			UnitTest_AssertEqualText("data3"; $array{1})
			UnitTest_AssertEqualText("da,\r\nta4"; $array{2})
		End if 
		
		FileBuffer_FetchCSVLine(FileBuffer_TellMeTheEOL; ->$array)
		UnitTest_AssertEqualLongint(2; Size of array:C274($array)\
			; "line 5 length should be 2 rather than "+String:C10(Size of array:C274($array)))
		If (Size of array:C274($array)>=2)
			UnitTest_AssertEqualText("test1"; $array{1})
			UnitTest_AssertEqualText("te\"s\"t2"; $array{2})
		End if 
		
		UnitTest_AssertTrue(FileBuffer_EOF)
		CLOSE DOCUMENT:C267($docRef)
		DELETE DOCUMENT:C159($filePath)
		
		
		$fileContents:="Server,Record Id,Table no, Value Obj\n"
		$fileContents+="CO2,100008245,5,\"{\"\"ID\"\":\"\"100008245\"\",\"\"Districts_Key\"\":\"\"90\"\",\"\"isDistrictAdminUser_YN\"\":\"\"No\"\",\"\"isSysAdminUser_YN\"\":\"\"No\"\",\"\"Login_Name\"\":\"\"jenni.carlson\"\""
		$fileContents+=",\"\"Login_Password\"\":\"\"1234\"\",\"\"LastPasswordChangeDate\"\":\"\"09/08/2015\"\",\"\"LogOn_Count\"\":\"\"12\"\",\"\"Last_Login_Date\"\":\"\"09/09/2015\"\",\"\"First_Name\"\":\"\"Jenni\"\""
		$fileContents+=",\"\"Last_Name\"\":\"\"Carlson\"\",\"\"Full_Name\"\":\"\"Jenni Carlson\"\",\"\"License_Type\"\":\"\"Speech/Language\"\",\"\"Update_Medicaid_Release\"\":\"\"No\"\""
		$fileContents+=",\"\"Update_Physician_Orders\"\":\"\"No\"\",\"\"Assign_Students\"\":\"\"Yes\"\",\"\"Last_Treatment_Update\"\":\"\"09/09/2015\"\""
		$fileContents+=",\"\"User_Message\"\":\"\"She is not ASHA licensed. 10/1/2015, BSA\"\",\"\"Created_By\"\":\"\"Nicolas Gasquet\"\",\"\"Created_Date_Time_TS\"\":\"\"810576059\"\""
		$fileContents+=",\"\"Modified_By\"\":\"\"Midnight Run\"\",\"\"Modified_Date_Time_TS\"\":\"\"812775340\"\",\"\"Remove\"\":\"\"Del\"\",\"\"Licensed\"\":\"\"No\"\",\"\"Verified\"\":\"\"Yes\"\""
		$fileContents+=",\"\"Supervised\"\":\"\"No\"\",\"\"License_Sub_Type\"\":\"\"Speech Pathologist\"\",\"\"isSysAdminUser_Restricted_YN\"\":\"\"No\"\",\"\"AllowedToBill\"\":\"\"True\"\""
		$fileContents+=",\"\"AllowedTodo_Assessments\"\":\"\"True\"\",\"\"isTCM\"\":\"\"No\"\",\"\"Login_FailedMessageToUser\"\":\"\"You have entered an incorrect password 1 of the 5 allowed failed attempts.\"\""
		$fileContents+=",\"\"UserAgent\"\":\"\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0) Gecko/20100101 Firefox/38.0\"\",\"\"GUID\"\":\"\"9FF5B79D597FA44690B2CDFC63184564\"\"}\"\n"
		$fileContents+="Server,Record Id,Table no, Value Obj\n"
		TEXT TO DOCUMENT:C1237($filePath; $fileContents; "utf-8"; Document unchanged:K24:18)
		$docRef:=Open document:C264($filePath; ""; Read mode:K24:5)
		UnitTest_AssertEqualLongint(1; OK)
		FileBuffer_Init($docRef)
		$eol:=FileBuffer_TellMeTheEOL
		UnitTest_AssertEqualLongint(Line feed:K15:40; Character code:C91($eol))
		FileBuffer_FetchCSVLine($eol; ->$array)
		UnitTest_AssertEqualLongint(4; Size of array:C274($array))
		
		FileBuffer_FetchCSVLine($eol; ->$array)
		UnitTest_AssertEqualLongint(4; Size of array:C274($array); "expecting 4 values, got "+String:C10(Size of array:C274($array)))
		
		FileBuffer_FetchCSVLine($eol; ->$array)
		UnitTest_AssertEqualLongint(4; Size of array:C274($array))
		CLOSE DOCUMENT:C267($docRef)
		DELETE DOCUMENT:C159($filePath)
		
		
	: ($action="CSV SEP= Tests")
		$fileContents:="sep=;"
		$fileContents+="\rte,st1;\"test2\""
		$fileContents+="\r"
		$fileContents+="\rdata1;\"da;ta2\""
		TEXT TO DOCUMENT:C1237($filePath; $fileContents; "utf-8"; Document unchanged:K24:18)
		$docRef:=Open document:C264($filePath; ""; Read mode:K24:5)
		UnitTest_AssertEqualLongint(1; OK)
		FileBuffer_Init($docRef)
		FileBuffer_FetchCSVLine(FileBuffer_TellMeTheEOL; ->$array)
		UnitTest_AssertEqualLongint(2; Size of array:C274($array)\
			; "line 1 length should be 2 rather than "+String:C10(Size of array:C274($array)))
		If (Size of array:C274($array)>=2)
			UnitTest_AssertEqualText("te,st1"; $array{1})
			UnitTest_AssertEqualText("test2"; $array{2})
		End if 
		
		FileBuffer_FetchCSVLine(FileBuffer_TellMeTheEOL; ->$array)
		UnitTest_AssertEqualLongint(1; Size of array:C274($array)\
			; "line 3 length should be 2 rather than "+String:C10(Size of array:C274($array)))
		If (Size of array:C274($array)>=1)
			UnitTest_AssertEqualText(""; $array{1})
		End if 
		
		FileBuffer_FetchCSVLine(FileBuffer_TellMeTheEOL; ->$array)
		UnitTest_AssertEqualLongint(2; Size of array:C274($array)\
			; "line 2 length should be 2 rather than "+String:C10(Size of array:C274($array)))
		If (Size of array:C274($array)>=2)
			UnitTest_AssertEqualText("data1"; $array{1})
			UnitTest_AssertEqualText("da;ta2"; $array{2})
		End if 
		
		UnitTest_AssertTrue(FileBuffer_EOF)
		CLOSE DOCUMENT:C267($docRef)
		DELETE DOCUMENT:C159($filePath)
		
	Else 
		UnitTest_Assert(False:C215; "unexpected action of \""+$action+"\".")
		
End case 