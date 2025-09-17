//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// Method: Array_Copy (srcArrayPtr; dstArrayPtr; dstStringSize)

// this method copies the source array into the destination array
// it converts the data as best as it can.


If (DEV_ASSERT((Count parameters:C259=2) | (Count parameters:C259=3); "Array_Copy: expected 2 or 3 parameters"))
	C_POINTER:C301($1; $srcArrayPtr)
	C_POINTER:C301($2; $dstArrayPtr)
	C_LONGINT:C283($3; $dstFieldSize)
	$srcArrayPtr:=$1
	$dstArrayPtr:=$2
	If (Count parameters:C259=3)
		$dstFieldSize:=$3
	Else 
		$dstFieldSize:=0
	End if 
	
	C_LONGINT:C283($i)
	
	C_LONGINT:C283($srcType; $dstType)
	$srcType:=Type:C295($srcArrayPtr->)
	$dstType:=Type:C295($dstArrayPtr->)
	
	If ($srcType=String array:K8:15) & ($dstType=String array:K8:15)  // want to force it to go through conversions
		$srcType:=Text array:K8:16
	End if 
	
	If ($srcType=$dstType)  // this one is easy
		COPY ARRAY:C226($srcArrayPtr->; $dstArrayPtr->)
		
	Else 
		C_BOOLEAN:C305($okayToContinue)
		$okayToContinue:=True:C214  // assume all is okay
		
		// make sure source array is one that we can convert from
		Case of 
			: ($srcType=LongInt array:K8:19)
			: ($srcType=Integer array:K8:18)
			: ($srcType=Real array:K8:17)
			: ($srcType=String array:K8:15)
			: ($srcType=Text array:K8:16)
			: ($srcType=Boolean array:K8:21)
			: ($srcType=Date array:K8:20)
			Else 
				$okayToContinue:=False:C215
				DEV_ASSERT($okayToContinue; "Array_Copy: src array is of a type that cannot be processed.")
		End case 
		
		// make sure destinatoin array is one that we can convert to
		Case of 
			: ($dstType=LongInt array:K8:19)
			: ($dstType=Integer array:K8:18)
			: ($dstType=Real array:K8:17)
			: ($dstType=String array:K8:15)
				DEV_ASSERT($dstFieldSize#0; "Array_Copy: string size of the array must be passed.")
			: ($dstType=Text array:K8:16)
			: ($dstType=Boolean array:K8:21)
			: ($dstType=Date array:K8:20)
			Else 
				$okayToContinue:=False:C215
				DEV_ASSERT($okayToContinue; "Array_Copy: dst array is of a type that cannot be processed.")
		End case 
		
		
		If ($okayToContinue)
			// resize our destination array to be the correct size
			Array_SetSize(Size of array:C274($srcArrayPtr->); $dstArrayPtr)
			
			For ($i; 1; Size of array:C274($srcArrayPtr->))
				
				Case of 
					: ($dstType=Boolean array:K8:21)
						Case of 
							: ($srcType=LongInt array:K8:19) | ($srcType=Integer array:K8:18) | ($srcType=Real array:K8:17)
								$dstArrayPtr->{$i}:=False:C215
								If (($srcArrayPtr->{$i})>0)
									$dstArrayPtr->{$i}:=True:C214
								End if 
								
							: ($srcType=Boolean array:K8:21)
								$dstArrayPtr->{$i}:=$srcArrayPtr->{$i}
								
							: ($srcType=Date array:K8:20)
								$dstArrayPtr->{$i}:=False:C215
								If (($srcArrayPtr->{$i})#!00-00-00!)
									$dstArrayPtr->{$i}:=True:C214
								End if 
								
							: ($srcType=String array:K8:15) | ($srcType=Text array:K8:16)
								$dstArrayPtr->{$i}:=False:C215
								If (($srcArrayPtr->{$i})#"")
									$dstArrayPtr->{$i}:=True:C214
								End if 
						End case 
						
						
					: ($dstType=Text array:K8:16)
						Case of 
							: ($srcType=LongInt array:K8:19) | ($srcType=Integer array:K8:18) | ($srcType=Real array:K8:17)
								$dstArrayPtr->{$i}:=String:C10($srcArrayPtr->{$i})
								
							: ($srcType=Boolean array:K8:21)
								If ($srcArrayPtr->{$i})
									$dstArrayPtr->{$i}:="True"
								Else 
									$dstArrayPtr->{$i}:="False"
								End if 
								
							: ($srcType=Date array:K8:20)
								$dstArrayPtr->{$i}:=Date2String($srcArrayPtr->{$i})
								
							: ($srcType=String array:K8:15) | ($srcType=Text array:K8:16)
								$dstArrayPtr->{$i}:=$srcArrayPtr->{$i}
						End case 
						
						
					: ($dstType=String array:K8:15)
						Case of 
							: ($srcType=LongInt array:K8:19) | ($srcType=Integer array:K8:18) | ($srcType=Real array:K8:17)
								$dstArrayPtr->{$i}:=Substring:C12(String:C10($srcArrayPtr->{$i}); 1; $dstFieldSize)
								
							: ($srcType=Boolean array:K8:21)
								C_TEXT:C284($tmpTxt)
								If ($srcArrayPtr->{$i})
									$tmpTxt:="True"
								Else 
									$tmpTxt:="False"
								End if 
								$dstArrayPtr->{$i}:=Substring:C12($tmpTxt; 1; $dstFieldSize)
								
							: ($srcType=Date array:K8:20)
								$dstArrayPtr->{$i}:=Substring:C12(Date2String($srcArrayPtr->{$i}); 1; $dstFieldSize)
								
							: ($srcType=String array:K8:15) | ($srcType=Text array:K8:16)
								$dstArrayPtr->{$i}:=Substring:C12($srcArrayPtr->{$i}; 1; $dstFieldSize)
						End case 
						
						
					: ($dstType=LongInt array:K8:19) | ($dstType=Integer array:K8:18) | ($dstType=Real array:K8:17)
						Case of 
							: ($srcType=LongInt array:K8:19) | ($srcType=Integer array:K8:18) | ($srcType=Real array:K8:17)
								$dstArrayPtr->{$i}:=$srcArrayPtr->{$i}
								
							: ($srcType=Boolean array:K8:21)
								If ($srcArrayPtr->{$i})
									$dstArrayPtr->{$i}:=1
								Else 
									$dstArrayPtr->{$i}:=0
								End if 
								
							: ($srcType=Date array:K8:20)
								$dstArrayPtr->{$i}:=Num:C11($srcArrayPtr->{$i})
								
							: ($srcType=String array:K8:15) | ($srcType=Text array:K8:16)
								$dstArrayPtr->{$i}:=Num:C11($srcArrayPtr->{$i})
						End case 
						
				End case 
				
			End for 
		End if 
	End if 
	
End if   // ASSERT