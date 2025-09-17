//%attributes = {"invisible":true,"preemptive":"incapable"}
// (PM) Array__UnitTests 
// $1 = Action

// CALLED BY: UnitTest_Setup_IHCore

If (Count parameters:C259=0)
	UnitTest_Setup_IHCore
Else 
	C_TEXT:C284($1; $action)
	$action:=$1
	
	Case of 
			
		: ($action="RunTests")
			UnitTest_RunTest("Array_AddLongintElement")
			UnitTest_RunTest("Array_AddLongintElement_UNIQUE")
			UnitTest_RunTest("Array_AddPtrElement")  //   Mod: DB (03/01/2013)
			UnitTest_RunTest("Array_AddTextElement")
			UnitTest_RunTest("Array_AddTextElement_Prepend")
			
			UnitTest_RunTest("Array_Empty")  //   Mod: DB (03/05/2013)
			UnitTest_RunTest("Array_CopyAndRemoveDuplicates")  //   Mod: DB (03/05/2013)
			UnitTest_RunTest("Array_Copy-longint&text")  //   Mod: DB (03/05/2013)
			//UnitTest_RunTest ("Array_DistinctValues")  //   Mod: DB (03/05/2013)
			
			UnitTest_RunTest("Array_ConvertFromTextDelimited")  //   Mod: DB (09/25/2012)  
			UnitTest_RunTest("Array_ConvertToTextDelimited")  //   Mod: DB (03/01/2013)
			
			UnitTest_RunTest("Array_KVPair_GetValueByKey")
			UnitTest_RunTest("Array_SetSize")
			UnitTest_RunTest("Array_RemoveElementIfExists")
			
			UnitTest_RunTest("Array_InsertValueAtPos")
			UnitTest_RunTest("Array_ReduceToSortedUnique")
			
			//Array_CountOccurances
			//Array_DistinctValues 
			//Array_SetTextElement_byIndex 
			//Array_SwapElements 
			//Array_Unpack
			
			
		: ($action="Setup")
			// n/a
			
		: ($action="TearDown")
			// n/a
			
			
		: ($action="Array_ReduceToSortedUnique")
			ARRAY TEXT:C222($at_srcArray; 4)
			$at_srcArray{1}:="1"
			$at_srcArray{2}:="3"
			$at_srcArray{3}:="3"
			$at_srcArray{4}:="1"
			Array_ReduceToSortedUnique(->$at_srcArray)
			UnitTest_AssertArraySize(2; ->$at_srcArray; "expected $at_srcArray to be size 2")
			UnitTest_AssertEqualText("1"; $at_srcArray{1})
			UnitTest_AssertEqualText("3"; $at_srcArray{2})
			
			ARRAY LONGINT:C221($al_dstArray; 4)
			$al_dstArray{1}:=1
			$al_dstArray{2}:=3
			$al_dstArray{3}:=3
			$al_dstArray{4}:=1
			Array_ReduceToSortedUnique(->$al_dstArray)
			UnitTest_AssertArraySize(2; ->$al_dstArray; "expected $al_dstArray to be size 2")
			UnitTest_AssertEqualLongint(1; $al_dstArray{1})
			UnitTest_AssertEqualLongint(3; $al_dstArray{2})
			
			
		: ($action="Array_Copy-longint&text")
			// test 1
			C_LONGINT:C283($i)
			ARRAY LONGINT:C221($al_dstArray; 0)
			ARRAY TEXT:C222($at_srcArray; 3)
			$at_srcArray{1}:="1"
			$at_srcArray{2}:="3"
			$at_srcArray{3}:="1"
			Array_Copy(->$at_srcArray; ->$al_dstArray)  // Test copy from text to longint
			UnitTest_AssertArraySize(3; ->$al_dstArray; "expected $al_dstArray to be size 3")
			If (Size of array:C274($al_dstArray)=3)
				UnitTest_AssertEqualText("1"; $at_srcArray{3})
				For ($i; 1; Size of array:C274($at_srcArray))
					UnitTest_AssertEqualText($at_srcArray{$i}; String:C10($al_dstArray{$i}))
				End for 
			End if 
			
			Array_Empty(->$at_srcArray)
			SORT ARRAY:C229($al_dstArray; <)
			Array_Copy(->$al_dstArray; ->$at_srcArray)  // test copy from longint to text
			UnitTest_AssertArraySize(3; ->$at_srcArray; "expected $at_srcArray to be size 3")
			If (Size of array:C274($at_srcArray)=3)
				UnitTest_AssertEqualLongint(1; $al_dstArray{3})
				For ($i; 1; Size of array:C274($al_dstArray))
					UnitTest_AssertEqualLongint($al_dstArray{$i}; Num:C11($at_srcArray{$i}))
				End for 
			End if 
			
			
		: ($action="Array_SetSize")
			// test 1
			ARRAY LONGINT:C221($al; 0)
			ARRAY TEXT:C222($at; 0)
			ARRAY BOOLEAN:C223($ab; 0)
			ARRAY OBJECT:C1221($ao; 0)
			ARRAY DATE:C224($ad; 0)
			Array_SetSize(3; ->$al; ->$at; ->$ab; ->$ao; ->$ad)
			UnitTest_AssertArraySize(3; ->$al)
			UnitTest_AssertArraySize(3; ->$at)
			UnitTest_AssertArraySize(3; ->$ab)
			UnitTest_AssertArraySize(3; ->$ao)
			UnitTest_AssertArraySize(3; ->$ad)
			$al{1}:=1
			$al{2}:=2
			$al{3}:=3
			Array_SetSize(4; ->$al)
			UnitTest_AssertArraySize(4; ->$al)
			UnitTest_AssertEqualLongint(1; $al{1})
			UnitTest_AssertEqualLongint(2; $al{2})
			UnitTest_AssertEqualLongint(3; $al{3})
			UnitTest_AssertEqualLongint(0; $al{4})
			Array_SetSize(2; ->$al)
			UnitTest_AssertArraySize(2; ->$al)
			UnitTest_AssertEqualLongint(1; $al{1})
			UnitTest_AssertEqualLongint(2; $al{2})
			
			
		: ($action="Array_CopyAndRemoveDuplicates")
			// test 1
			ARRAY TEXT:C222($at_srcArray; 3)
			$at_srcArray{1}:="1"
			$at_srcArray{2}:="1"
			$at_srcArray{3}:="1"
			ARRAY TEXT:C222($at_dstArray; 0)
			Array_CopyAndRemoveDuplicates(->$at_srcArray; ->$at_dstArray)
			UnitTest_AssertArraySize(1; ->$at_dstArray; "expected $at_dstArray to be size 1")
			If (Size of array:C274($at_dstArray)>0)
				UnitTest_AssertEqualText("1"; $at_dstArray{1})
			End if 
			
			// Test 2
			$at_srcArray{1}:="1"
			$at_srcArray{2}:="2"
			$at_srcArray{3}:="1"
			Array_CopyAndRemoveDuplicates(->$at_srcArray; ->$at_dstArray)
			UnitTest_AssertArraySize(2; ->$at_dstArray; "expected $at_dstArray to be size 2")
			If (Size of array:C274($at_dstArray)>0)
				UnitTest_AssertEqualText("1"; $at_dstArray{1})
				UnitTest_AssertEqualText("2"; $at_dstArray{2})
			End if 
			
			// test 1
			ARRAY LONGINT:C221($al_srcArray; 3)
			$al_srcArray{1}:=1
			$al_srcArray{2}:=2
			$al_srcArray{3}:=1
			ARRAY LONGINT:C221($al_dstArray; 0)
			Array_CopyAndRemoveDuplicates(->$al_srcArray; ->$al_dstArray)
			UnitTest_AssertArraySize(2; ->$al_dstArray; "expected $al_dstArray to be size 2")
			If (Size of array:C274($al_dstArray)>0)
				UnitTest_AssertEqualLongint(1; $al_dstArray{1})
				UnitTest_AssertEqualLongint(2; $al_dstArray{2})
			End if 
			
			
		: ($action="Array_Empty")
			ARRAY TEXT:C222($at_someArray; 32)
			ARRAY DATE:C224($ad_someArray; 31234)
			ARRAY LONGINT:C221($al_someArray; 0)
			Array_Empty(->$at_someArray)
			Array_Empty(->$ad_someArray)
			Array_Empty(->$al_someArray)
			UnitTest_AssertArraySize(0; ->$at_someArray; "expected $at_someArray to be size 0")
			UnitTest_AssertArraySize(0; ->$ad_someArray; "expected $ad_someArray to be size 0")
			UnitTest_AssertArraySize(0; ->$al_someArray; "expected $al_someArray to be size 0")
			
			
		: ($action="Array_AddTextElement_Prepend")
			ARRAY TEXT:C222($at_someArray; 0)
			Array_AddTextElement_Prepend(->$at_someArray; "2")
			Array_AddTextElement_Prepend(->$at_someArray; "1")
			UnitTest_AssertArraySize(2; ->$at_someArray)
			UnitTest_AssertEqualText("1"; $at_someArray{1})
			UnitTest_AssertEqualText("2"; $at_someArray{2})
			
			
		: ($action="Array_AddTextElement")
			ARRAY TEXT:C222($at_someArray; 0)
			Array_AddTextElement(->$at_someArray; "2")
			Array_AddTextElement(->$at_someArray; "1")
			UnitTest_AssertArraySize(2; ->$at_someArray)
			UnitTest_AssertEqualText("2"; $at_someArray{1})
			UnitTest_AssertEqualText("1"; $at_someArray{2})
			
		: ($action="Array_AddLongintElement")
			ARRAY LONGINT:C221($al_someArray; 0)
			Array_AddLongintElement(->$al_someArray; 2)
			Array_AddLongintElement(->$al_someArray; 1)
			Array_AddLongintElement(->$al_someArray; 1)
			UnitTest_AssertArraySize(3; ->$al_someArray)
			UnitTest_AssertEqualLongint(2; $al_someArray{1})
			UnitTest_AssertEqualLongint(1; $al_someArray{2})
			UnitTest_AssertEqualLongint(1; $al_someArray{3})
			
		: ($action="Array_AddLongintElement_UNIQUE")
			ARRAY LONGINT:C221($al_someArray; 0)
			Array_AddLongintElement_UNIQUE(->$al_someArray; 2)
			Array_AddLongintElement_UNIQUE(->$al_someArray; 1)
			Array_AddLongintElement_UNIQUE(->$al_someArray; 1)
			UnitTest_AssertArraySize(2; ->$al_someArray)
			UnitTest_AssertEqualLongint(2; $al_someArray{1})
			UnitTest_AssertEqualLongint(1; $al_someArray{2})
			
		: ($action="Array_ConvertToTextDelimited")
			ARRAY TEXT:C222($at_someArray; 5)
			$at_someArray{1}:=" 1 "
			$at_someArray{2}:="2"
			$at_someArray{3}:="3"
			$at_someArray{4}:="4"
			$at_someArray{5}:=""
			UnitTest_AssertEqualText(" 1 ,2,3,4,"; Array_ConvertToTextDelimited(->$at_someArray))
			UnitTest_AssertEqualText(" 1 |2|3|4|"; Array_ConvertToTextDelimited(->$at_someArray; "|"))
			UnitTest_AssertEqualText(" 1 , 2, 3, 4, "; Array_ConvertToTextDelimited(->$at_someArray; ", "))
			
			ARRAY LONGINT:C221($al_someArray; 5)
			$al_someArray{1}:=1
			$al_someArray{2}:=2
			$al_someArray{3}:=3
			$al_someArray{4}:=4
			$al_someArray{5}:=0
			UnitTest_AssertEqualText("1,2,3,4,0"; Array_ConvertToTextDelimited(->$al_someArray))
			
			
		: ($action="Array_ConvertFromTextDelimited")
			ARRAY TEXT:C222($at_someArray; 3)
			Array_ConvertFromTextDelimited(->$at_someArray; " 1 ,2,3,4,"; ",")
			UnitTest_AssertArraySize(5; ->$at_someArray)
			UnitTest_AssertEqualText(" 1 "; $at_someArray{1})
			If (Size of array:C274($at_someArray)=5)
				UnitTest_AssertEqualText(""; $at_someArray{5})
			End if 
			
			Array_ConvertFromTextDelimited(->$at_someArray; "1,2,3,,4"; ",")
			UnitTest_AssertArraySize(5; ->$at_someArray)
			UnitTest_AssertEqualText("1"; $at_someArray{1})
			If (Size of array:C274($at_someArray)=5)
				UnitTest_AssertEqualText("4"; $at_someArray{5})
			End if 
			
			Array_ConvertFromTextDelimited(->$at_someArray; ""; ",")
			UnitTest_AssertArraySize(0; ->$at_someArray)
			
			Array_ConvertFromTextDelimited(->$at_someArray; "1"; ",")
			UnitTest_AssertArraySize(1; ->$at_someArray)
			
			Array_ConvertFromTextDelimited(->$at_someArray; "1\t2\t3"; "\t")
			UnitTest_AssertArraySize(3; ->$at_someArray)
			
			Array_ConvertFromTextDelimited(->$at_someArray; "1::22::333"; "::")
			UnitTest_AssertArraySize(3; ->$at_someArray)
			UnitTest_AssertEqualText("1"; $at_someArray{1})
			UnitTest_AssertEqualText("22"; $at_someArray{2})
			UnitTest_AssertEqualText("333"; $at_someArray{3})
			
			Array_ConvertFromTextDelimited(->$at_someArray; "1"+Char:C90(Line feed:K15:40)+"2"+Char:C90(Line feed:K15:40)+"3"; Char:C90(Line feed:K15:40))
			UnitTest_AssertArraySize(3; ->$at_someArray)
			
			Array_ConvertFromTextDelimited(->$at_someArray; "1"+Char:C90(Escape:K15:39)+"2"+Char:C90(Escape:K15:39)+"3"; Char:C90(Escape:K15:39))
			UnitTest_AssertArraySize(3; ->$at_someArray)
			
			
		: ($action="Array_AddPtrElement")
			ARRAY TEXT:C222($at_keyArray; 0)
			ARRAY TEXT:C222($at_valueArray; 0)
			Array_AddTextElement(->$at_keyArray; "k1")
			Array_AddTextElement(->$at_keyArray; "k2")
			Array_AddTextElement(->$at_keyArray; "k22")
			Array_AddTextElement(->$at_valueArray; "v1")
			Array_AddTextElement(->$at_valueArray; "v2")
			Array_AddTextElement(->$at_valueArray; "v22")
			
			ARRAY POINTER:C280($ap_someArray; 0)
			Array_AddPtrElement(->$ap_someArray; ->$at_keyArray)
			Array_AddPtrElement(->$ap_someArray; ->$at_valueArray)
			UnitTest_AssertArraySize(2; ->$ap_someArray)
			UnitTest_AssertEqualPointer(->$at_keyArray; $ap_someArray{1})
			UnitTest_AssertEqualPointer(->$at_valueArray; $ap_someArray{2})
			
			
		: ($action="Array_KVPair_GetValueByKey")  //   Mod: DB (07/18/2014)
			ARRAY TEXT:C222($at_keyArray; 0)
			ARRAY TEXT:C222($at_valueArray; 0)
			Array_AddTextElement(->$at_keyArray; "k1")
			Array_AddTextElement(->$at_keyArray; "k2")
			Array_AddTextElement(->$at_keyArray; "k22")
			Array_AddTextElement(->$at_valueArray; "v1")
			Array_AddTextElement(->$at_valueArray; "v2")
			Array_AddTextElement(->$at_valueArray; "v22")
			
			UnitTest_AssertEqualText(""; Array_KVPair_GetValueByKey("k3"; ->$at_keyArray; ->$at_valueArray); "t1")
			UnitTest_AssertEqualText("v1"; Array_KVPair_GetValueByKey("k1"; ->$at_keyArray; ->$at_valueArray); "t2")
			UnitTest_AssertEqualText("v2"; Array_KVPair_GetValueByKey("k2"; ->$at_keyArray; ->$at_valueArray); "t3")
			
			
		: ($action="Array_RemoveElementIfExists")
			ARRAY TEXT:C222($at_keyArray; 0)
			Array_AddTextElement(->$at_keyArray; "k1")
			Array_AddTextElement(->$at_keyArray; "k2")
			Array_AddTextElement(->$at_keyArray; "k22")
			Array_AddTextElement(->$at_keyArray; "k1")
			
			Array_RemoveElementIfExists(->$at_keyArray; "tt")
			UnitTest_AssertArraySize(4; ->$at_keyArray)
			Array_RemoveElementIfExists(->$at_keyArray; "k2")
			UnitTest_AssertArraySize(3; ->$at_keyArray)
			Array_RemoveElementIfExists(->$at_keyArray; "k1")
			UnitTest_AssertArraySize(1; ->$at_keyArray)
			Array_RemoveElementIfExists(->$at_keyArray; "@")
			UnitTest_AssertArraySize(0; ->$at_keyArray)
			
			
		: ($action="Array_InsertValueAtPos")
			ARRAY TEXT:C222($textArray; 0)
			C_TEXT:C284($textValue)
			
			$textValue:="1"
			Array_InsertValueAtPos(10; ->$textArray; ->$textValue)
			UnitTest_AssertArraySize(1; ->$textArray)
			
			$textValue:="3"
			Array_InsertValueAtPos(10; ->$textArray; ->$textValue)
			UnitTest_AssertArraySize(2; ->$textArray)
			
			$textValue:="2"
			Array_InsertValueAtPos(2; ->$textArray; ->$textValue)
			UnitTest_AssertArraySize(3; ->$textArray)
			UnitTest_AssertEqualText("1,2,3"; Array_ConvertToTextDelimited(->$textArray; ","))
			
			$textValue:="a"
			Array_InsertValueAtPos(0; ->$textArray; ->$textValue)
			$textValue:="b"
			Array_InsertValueAtPos(1; ->$textArray; ->$textValue)
			UnitTest_AssertEqualText("b,a,1,2,3"; Array_ConvertToTextDelimited(->$textArray; ","))
			
		Else 
			UnitTest_Assert(False:C215; "unexpected action of \""+$action+"\".")
			
	End case 
End if 