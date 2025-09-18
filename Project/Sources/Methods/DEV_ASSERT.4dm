//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// Method: DEV_ASSERT (boolean condition; error string) : boolean condition

// This method is used for debugging purposes. It is used to test assumptions.
//  if $1 is false, then there is an error and the error string is presented

C_BOOLEAN:C305($1)
C_BOOLEAN:C305($0)  // returns $1
C_TEXT:C284($2; $msg)

If ($1=False:C215)
	If (Application type:C494#4D Server:K5:6)
		$msg:="ASSERT ERROR:"+(Char:C90(Carriage return:K15:38)*2)+$2+(Char:C90(Carriage return:K15:38)*2)+"Please notify InfoHandler's Technical Support of this error."
		If (Not:C34(Is compiled mode:C492(*)))
			ALERT:C41($msg)
		End if 
	End if 
End if 

$0:=$1
