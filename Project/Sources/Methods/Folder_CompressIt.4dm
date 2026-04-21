//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
// Folder_CompressIt (src Folder; dst Zip {;doDeleteSrc} )
// 
// DESCRIPTION
//   Compresses the specified src folder to the specified
//   dst zip file. The optional parm, if true, will delete
//   the src folder.
//
#DECLARE($src_folder_platformPath : Text; $dest_zip_file_platformPath : Text; $do_delete_src_folder : Boolean)
// ----------------------------------------------------
ASSERT:C1129(Count parameters:C259>=2)
ASSERT:C1129(Count parameters:C259<=3)

File_Delete($dest_zip_file_platformPath)

var $in; $out; $err : Blob
var $command_line; $vt_err : Text
If (Is macOS:C1572)
	var $src_folder_posixPath; $dest_zip_file_posixPath : Text
	$src_folder_posixPath:=Convert path system to POSIX:C1106($src_folder_platformPath)
	$dest_zip_file_posixPath:=Convert path system to POSIX:C1106($dest_zip_file_platformPath)
	
	$command_line:="zip -jr \""+$dest_zip_file_posixPath+"\" \""+$src_folder_posixPath+"\""
	
	LAUNCH EXTERNAL PROCESS:C811($command_line; $in; $out; $err)
	$vt_err:=Convert to text:C1012($err; "utf-8")
	$vt_err:=Substring:C12($vt_err; 1; Length:C16($vt_err)-1)  //strip terminator 
	
Else   // Support windows using zip.exe that is our resources folder
	
	If ($src_folder_platformPath=("@"+Folder separator:K24:12))  // Ensure file name does not end with a folder separator
		$src_folder_platformPath:=Substring:C12($src_folder_platformPath; 1; Length:C16($src_folder_platformPath)-1)
	End if 
	
	var $vt_rootWINFolder : Text
	var $vt_tmpFileName : Text
	$vt_tmpFileName:=String:C10(Abs:C99(Milliseconds:C459))  // Use a temp file, then move it after
	$vt_rootWINFolder:=Get 4D folder:C485(Current resources folder:K5:16)+"win"+Folder separator:K24:12
	$command_line:=$vt_rootWINFolder+"zip.exe -j -r "+$vt_tmpFileName+" \""+$src_folder_platformPath+"\""
	
	SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_CURRENT_DIRECTORY"; $vt_rootWINFolder)
	LAUNCH EXTERNAL PROCESS:C811($command_line; $in; $out; $err)
	
	$vt_err:=Convert to text:C1012($err; "utf-8")
	$vt_err:=Substring:C12($vt_err; 1; Length:C16($vt_err)-1)  //strip terminator 
	
	If (File_DoesExist($vt_rootWINFolder+$vt_tmpFileName+".zip"))
		MOVE DOCUMENT:C540($vt_rootWINFolder+$vt_tmpFileName+".zip"; $dest_zip_file_platformPath)
	Else 
		If ($vt_err#"")
			$vt_err:=$vt_err+", "
		Else 
			$vt_err:=$vt_err+"ZIP FILE WAS NOT CREATED IN TEMP DIRECTORY"
		End if 
	End if 
End if 

// Added by: Dani Beaubien (9/26/13)
If ($vt_err="") && ($do_delete_src_folder)
	Folder_Delete($src_folder_platformPath)
End if 
