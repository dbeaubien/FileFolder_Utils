//%attributes = {"invisible":true,"preemptive":"capable"}
// CallChain_FormatPretty (callChainCollection) : prettyCallChain
//
var $1; $callChainCollection : Collection
var $0; $prettyCallChain : Text
// ----------------------------------------------------
// HISTORY
//   Created by: DB (09/01/2021)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)
$callChainCollection:=$1
$prettyCallChain:=""

var $prettyLines : Collection
$prettyLines:=New collection:C1472

var $call : Object
var $i; $indentLevel : Integer
var $line : Text
For ($i; $callChainCollection.length-1; 0; -1)
	$indentLevel:=($callChainCollection.length-1)-$i
	$call:=$callChainCollection[$i]
	
	$line:=""
	If ($indentLevel>0)
		$line:=("  "*($indentLevel-1))
		$line:=$line+"+ "
	End if 
	$line:=$line+"line "+String:C10($call.line)+" - "
	$line:=$line+"\""+$call.name+"\" ("+$call.database+" "+$call.type+")"
	$prettyLines.push($line)
End for 
$prettyCallChain:=$prettyLines.join("\r")

$0:=$prettyCallChain