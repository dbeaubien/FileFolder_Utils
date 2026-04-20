//%attributes = {"invisible":true,"preemptive":"incapable"}
// (PM) CSV__UnitTests 
// $1 = Action
// CALLED BY: UnitTest_Setup_ORCore
#DECLARE($action : Text)
If (Count parameters:C259=0)
	UnitTest_RunAll
	return 
End if 

var $n1; $n2 : Integer
var $r1; $r2 : Real
var $s1; $s2; $s3; $comma1; $cr1; $q1; $q2; $eol1; $eol2 : Text
var $d1; $d2 : Date
var $t1; $t2 : Time
var $b1; $b2 : Boolean
var $o1 : Object

Case of 
	: ($action="Setup") || ($action="TearDown")
	: ($action="RunTests")
		UnitTest_RunTest("CSV_LineFromFieldCollection")
		UnitTest_RunTest("CSV_LineFromCollection")
		UnitTest_RunTest("CSV_LineIsComplete")
		
		
	: ($action="CSV_LineFromFieldCollection")
		$n1:=1
		$n2:=2
		$r1:=2
		$r2:=2.5
		$s1:="1"
		$s2:="2"
		$s3:="003"
		$eol1:=Char:C90(Carriage return:K15:38)
		$eol2:=Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
		$comma1:="Beaubien, Dani"
		$cr1:="Beaubien \rDani"
		$q1:="Hi \"there\" y'all"
		$d1:=!2020-01-02!
		$d2:=!2020-05-22!
		$t1:=?15:30:45?
		$t2:=?02:01:00?
		$b1:=True:C214
		$b2:=False:C215
		$o1:={v1: 1; v2: "2"}
		
		UnitTest_AssertEqualText(""+$eol1; \
			CSV_LineFromFieldCollection(New collection:C1472; $eol1); "empty csv line")
		UnitTest_AssertEqualText("\"003\",1"+$eol2; \
			CSV_LineFromFieldCollection(New collection:C1472(->$s3; ->$n1); $eol2); "text number, long")
		UnitTest_AssertEqualText("1"+$eol2; \
			CSV_LineFromFieldCollection(New collection:C1472(->$n1); $eol2); "single long")
		UnitTest_AssertEqualText("1,2"+$eol1; \
			CSV_LineFromFieldCollection(New collection:C1472(->$n1; ->$n2); $eol1); "two long")
		
		UnitTest_AssertEqualText("2,2.5"+$eol1; \
			CSV_LineFromFieldCollection(New collection:C1472(->$r1; ->$r2); $eol1))  //;"real, real")
		
		UnitTest_AssertEqualText("1,\"2\""+$eol1; \
			CSV_LineFromFieldCollection(New collection:C1472(->$n1; ->$s2); $eol1); "long, string")
		UnitTest_AssertEqualText("\"1\",2020-01-02"+$eol1; \
			CSV_LineFromFieldCollection(New collection:C1472(->$s1; ->$d1); $eol1); "string, date")
		UnitTest_AssertEqualText("2020-05-22,\"1\",2020-01-02"+$eol1; \
			CSV_LineFromFieldCollection(New collection:C1472(->$d2; ->$s1; ->$d1); $eol1); "date, string, date")
		
		UnitTest_AssertEqualText("\"1\",15:30:45"+$eol1; \
			CSV_LineFromFieldCollection(New collection:C1472(->$s1; ->$t1); $eol1); "string, time1")
		UnitTest_AssertEqualText("\"1\",02:01:00"+$eol1; \
			CSV_LineFromFieldCollection(New collection:C1472(->$s1; ->$t2); $eol1); "string, time2")
		
		UnitTest_AssertEqualText("true,false"+$eol1; \
			CSV_LineFromFieldCollection(New collection:C1472(->$b1; ->$b2); $eol1); "boolean boolean")
		
		UnitTest_AssertEqualText("true,\"{\"\"v1\"\":1,\"\"v2\"\":\"\"2\"\"}\""+$eol1; \
			CSV_LineFromFieldCollection(New collection:C1472(->$b1; ->$o1); $eol1); "boolean object")
		
		UnitTest_AssertEqualText("\"Beaubien, Dani\""+$eol1; \
			CSV_LineFromFieldCollection(New collection:C1472(->$comma1); $eol1); "embedded comma")
		UnitTest_AssertEqualText("1,\"Beaubien, Dani\",2020-01-02"+$eol1; \
			CSV_LineFromFieldCollection(New collection:C1472(->$n1; ->$comma1; ->$d1); $eol1); "long, embedded comma, date")
		UnitTest_AssertEqualText("\"Hi \"\"there\"\" y'all\""+$eol1; \
			CSV_LineFromFieldCollection(New collection:C1472(->$q1); $eol1); "embedded quotes")
		
		UnitTest_AssertEqualText("1,\"Beaubien "+Char:C90(Carriage return:K15:38)+"Dani\",2020-01-02"+$eol1; \
			CSV_LineFromFieldCollection(New collection:C1472(->$n1; ->$cr1; ->$d1); $eol1); "long, embedded cr, date")
		UnitTest_AssertEqualText("1,\"Beaubien "+Char:C90(Carriage return:K15:38)+"Dani\",2020-01-02"+$eol2; \
			CSV_LineFromFieldCollection(New collection:C1472(->$n1; ->$cr1; ->$d1); $eol2); "long, embedded cr2, date")
		
		
	: ($action="CSV_LineFromCollection")
		$n1:=1
		$n2:=2
		$r1:=2
		$r2:=2.5
		$s1:="1"
		$s2:="2"
		$s3:="003"
		$eol1:=Char:C90(Carriage return:K15:38)
		$eol2:=Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
		$comma1:="Beaubien, Dani"
		$cr1:="Beaubien \rDani"
		$q1:="Hi \"there\" y'all"
		$q2:="Hi “there” y'all"
		$d1:=!2020-01-02!
		$d2:=!2020-05-22!
		$t1:=?15:30:45?
		$t2:=?02:01:00?
		$b1:=True:C214
		$b2:=False:C215
		$o1:={v1: 1; v2: "2"}
		
		UnitTest_AssertEqualText(""+$eol1; \
			CSV_LineFromCollection(New collection:C1472; $eol1); "empty csv line")
		UnitTest_AssertEqualText("\"003\",1"+$eol2; \
			CSV_LineFromCollection(New collection:C1472($s3; $n1); $eol2); "text number, long")
		UnitTest_AssertEqualText("1"+$eol2; \
			CSV_LineFromCollection(New collection:C1472($n1); $eol2); "single long")
		UnitTest_AssertEqualText("1,2"+$eol1; \
			CSV_LineFromCollection(New collection:C1472($n1; $n2); $eol1); "two long")
		UnitTest_AssertEqualText("2,2.5"+$eol1; \
			CSV_LineFromCollection(New collection:C1472($r1; $r2); $eol1); "real, real")
		UnitTest_AssertEqualText("1,\"2\""+$eol1; \
			CSV_LineFromCollection(New collection:C1472($n1; $s2); $eol1); "long, string")
		UnitTest_AssertEqualText("\"1\",2020-01-02"+$eol1; \
			CSV_LineFromCollection(New collection:C1472($s1; $d1); $eol1); "string, date")
		UnitTest_AssertEqualText("2020-05-22,\"1\",2020-01-02"+$eol1; \
			CSV_LineFromCollection(New collection:C1472($d2; $s1; $d1); $eol1); "date, string, date")
		
		UnitTest_AssertEqualText("\"1\",55845"+$eol1; \
			CSV_LineFromCollection(New collection:C1472($s1; $t1); $eol1); "string, timeNum1")
		UnitTest_AssertEqualText("\"1\",7260"+$eol1; \
			CSV_LineFromCollection(New collection:C1472($s1; $t2); $eol1); "string, timeNum2")
		
		UnitTest_AssertEqualText("true,false"+$eol1; \
			CSV_LineFromCollection(New collection:C1472($b1; $b2); $eol1); "boolean boolean")
		
		UnitTest_AssertEqualText("true,\"{\"\"v1\"\":1,\"\"v2\"\":\"\"2\"\"}\""+$eol1; \
			CSV_LineFromCollection(New collection:C1472($b1; $o1); $eol1); "boolean object")
		
		UnitTest_AssertEqualText("\"Beaubien, Dani\""+$eol1; \
			CSV_LineFromCollection(New collection:C1472($comma1); $eol1); "embedded comma")
		UnitTest_AssertEqualText("1,\"Beaubien, Dani\",2020-01-02"+$eol1; \
			CSV_LineFromCollection(New collection:C1472($n1; $comma1; $d1); $eol1); "long, embedded comma, date")
		UnitTest_AssertEqualText("\"Hi \"\"there\"\" y'all\""+$eol1; \
			CSV_LineFromCollection(New collection:C1472($q1); $eol1); "embedded quotes")
		UnitTest_AssertEqualText("\"Hi “there” y'all\""+$eol1; \
			CSV_LineFromCollection(New collection:C1472($q2); $eol1); "embedded quotes2")
		
		UnitTest_AssertEqualText("1,\"Beaubien "+Char:C90(Carriage return:K15:38)+"Dani\",2020-01-02"+$eol1; \
			CSV_LineFromCollection(New collection:C1472($n1; $cr1; $d1); $eol1); "long, embedded cr, date")
		UnitTest_AssertEqualText("1,\"Beaubien "+Char:C90(Carriage return:K15:38)+"Dani\",2020-01-02"+$eol2; \
			CSV_LineFromCollection(New collection:C1472($n1; $cr1; $d1); $eol2); "long, embedded cr2, date")
		
		
	: ($action="CSV_LineIsComplete")
		UnitTest_AssertTrue(CSV_LineIsComplete(""; ","))
		UnitTest_AssertTrue(CSV_LineIsComplete("a,b"; ","))
		UnitTest_AssertFalse(CSV_LineIsComplete("a,\""; ","))
		UnitTest_AssertTrue(CSV_LineIsComplete("a,\"\rb\""; ","))
		UnitTest_AssertTrue(CSV_LineIsComplete("a,\"b\""; ","))
		UnitTest_AssertFalse(CSV_LineIsComplete("a,b,c,d@e,f,\"aaa. \r\rbbb\rccc\rddd \"\"eeee\"\" and \"\"ffff\"\", fgg "; ","))  // missing ending quote
		UnitTest_AssertTrue(CSV_LineIsComplete("a,b,c,d@e,f,\"aaa. \r\rbbb\rccc\rddd \"\"eeee\"\" and \"\"ffff\"\"\", fgg "; ","))
		UnitTest_AssertTrue(CSV_LineIsComplete("a,b,\"\"\"test\",n"; ","))
		UnitTest_AssertFalse(CSV_LineIsComplete("a,b,\"\"\"test,n"; ","))
		UnitTest_AssertFalse(CSV_LineIsComplete("\"\"\""; ","))
		UnitTest_AssertTrue(CSV_LineIsComplete("\"\"\"\""; ","))
		UnitTest_AssertTrue(CSV_LineIsComplete("1020414591,Finley,Khoweyne,NyÃ„Ã´cole,2018-01-22,2"; ","))
		
	Else 
		UnitTest_AssertTrue(False:C215; "missing test defintion for '"+$action+"'.")
End case 