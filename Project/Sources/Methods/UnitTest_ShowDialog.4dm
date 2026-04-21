//%attributes = {"invisible":true,"preemptive":"incapable"}
// (PM) UnitTest_ShowDialog
// ----------------------------------------------------

ARRAY BOOLEAN:C223(UnitTest_ListBoxStats; 0)
ARRAY BOOLEAN:C223(UnitTest_ListBoxTestCases; 0)
ARRAY TEXT:C222(UnitTest_TabControl; 0)

var Cmd1; Cmd2; Cmd3; UnitTest_RunButton; UnitTest_SaveButton : Integer

var $window : Integer
$window:=Open form window:C675("UnitTest_Dialog"; Plain window:K34:13; Horizontally centered:K39:1; Vertically centered:K39:4)
DIALOG:C40("UnitTest_Dialog")
CLOSE WINDOW:C154($window)