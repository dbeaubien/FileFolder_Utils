//%attributes = {"invisible":true,"preemptive":"capable"}
// CallChain_FormatPretty (callChainCollection) : prettyCallChain
//
#DECLARE($callChainCollection : Collection)->$prettyCallChain : Text
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259=1)

var $prettyLines : Collection
$prettyLines:=[]

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