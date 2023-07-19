//%attributes = {"invisible":true}
C_LONGINT:C283(FileBuffer_GetFilePostion; $0)
C_TEXT:C284(STR_GetLeftOfChar; $0)
C_TEXT:C284(STR_GetLeftOfChar; $1)
C_TEXT:C284(STR_GetLeftOfChar; $2)
C_BOOLEAN:C305(File_IsPNG; $0)
C_TEXT:C284(File_IsPNG; $1)
C_BOOLEAN:C305(STR_IsOneOf; $0)
C_TEXT:C284(STR_IsOneOf; ${2})
C_TEXT:C284(STR_IsOneOf; $1)
C_TEXT:C284(FileBuffer_FetchData_ByString; $0)
C_TEXT:C284(FileBuffer_FetchData_ByString; $1)
C_TEXT:C284(FileBuffer_FetchData_ByString; $2)
C_TEXT:C284(Folder_VerifyExistance; $1)
C_TEXT:C284(Folder_ParentName; $0)
C_TEXT:C284(Folder_ParentName; $1)
C_BOOLEAN:C305(File_IsJPG; $0)
C_TEXT:C284(File_IsJPG; $1)
C_BOOLEAN:C305(File_DoesExist; $0)
C_TEXT:C284(File_DoesExist; $1)
C_TEXT:C284(FileBuffer_FetchTabDelimitedLne; $1)
C_POINTER:C301(FileBuffer_FetchTabDelimitedLne; $2)
C_TEXT:C284(FileBuffer_FetchData_PeekAhead; $0)
C_LONGINT:C283(FileBuffer_FetchData_PeekAhead; $1)
C_LONGINT:C283(UTF8_GetByteCountFrom1stChar; $0)
C_LONGINT:C283(UTF8_GetByteCountFrom1stChar; $1)
C_BOOLEAN:C305(File_IsCSV; $0)
C_TEXT:C284(File_IsCSV; $1)
C_TEXT:C284(FileBuffer_TellMeTheEOL; $0)
C_BOOLEAN:C305(FileBuffer_EOF; $0)
C_TEXT:C284(STR_TellMeTheEOL; $0)
C_TEXT:C284(STR_TellMeTheEOL; $1)
C_TIME:C306(FileBuffer_Init; $1)
C_LONGINT:C283(FileBuffer_Init; $2)
C_TEXT:C284(FileBuffer_FetchData_BySize; $0)
C_LONGINT:C283(FileBuffer_FetchData_BySize; $1)
C_TEXT:C284(FileBuffer_FetchCSVLine; $1)
C_POINTER:C301(FileBuffer_FetchCSVLine; $2)

//Folder_DoesExist
C_BOOLEAN:C305(Folder_DoesExist; $0)
C_TEXT:C284(Folder_DoesExist; $1)

//File_IsTabDelimited
C_BOOLEAN:C305(File_IsTabDelimited; $0)
C_TEXT:C284(File_IsTabDelimited; $1)

//File_IsDelimited
C_BOOLEAN:C305(File_IsDelimited; $0)
C_TEXT:C284(File_IsDelimited; $1)
C_TEXT:C284(File_IsDelimited; $2)

//FileBuffer_FetchDelimitedLne
C_TEXT:C284(FileBuffer_FetchDelimitedLne; $1)
C_POINTER:C301(FileBuffer_FetchDelimitedLne; $2)
C_TEXT:C284(FileBuffer_FetchDelimitedLne; $3)

//Array_Empty
C_POINTER:C301(Array_Empty; $1)

//Array_ConvertFromTextDelimited
C_POINTER:C301(Array_ConvertFromTextDelimited; $1)
C_TEXT:C284(Array_ConvertFromTextDelimited; $2)
C_TEXT:C284(Array_ConvertFromTextDelimited; $3)

//PTR_IsArray
C_BOOLEAN:C305(PTR_IsArray; $0)
C_POINTER:C301(PTR_IsArray; $1)

//STR_ParseLineToCsvValues
C_COLLECTION:C1488(STR_ParseLineToCsvValues; $0)
C_TEXT:C284(STR_ParseLineToCsvValues; $1)
C_TEXT:C284(STR_ParseLineToCsvValues; $2)

//CSV_LineIsComplete
C_BOOLEAN:C305(CSV_LineIsComplete; $0)
C_TEXT:C284(CSV_LineIsComplete; $1)
C_TEXT:C284(CSV_LineIsComplete; $2)