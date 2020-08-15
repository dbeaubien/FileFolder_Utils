# FileFolder_Utils
### A modern component that provides basic file and folder utility methods.

## Features
- Provides basic functionality for working with files and folders
- Provides a set of methods to load files through a file buffer that adds
 additional abilities for retrieving the file contents from disk.

## Requirements
- 4D v18 is required.

## Installation and Use
Copy the `FileFolder_Utils.4dbase` into the Components folder of your application. It is suggested that you compile the component before installing it into your own projects.



## Examples
Example #1 - tbd
```
code here
```
 
Example #2 - tbd
```
code here
```



## File / Folder Shared Methods
The methods provide a some basic functionality for working with files and folders.

### File\_DoesExist (pathToFile:c\_text) returns doesExist:c\_boolean
Returns true if the file exists. Any missing parent folders will be created if missing.

### File\_IsCSV (pathToFile:c\_text) returns isCSV:c\_boolean
Returns true if the file is a CSV. Recognizes a 1st line of of the csv file is a "sep=" line.

**TESTS performed:**
- Is file extension ".csv" or ".txt"
- Look at first line, expect line of comma separated values.
- At least 2 non-empty values in the header line.


### File\_IsJPG (pathToFile:c\_text) returns isJPG:c\_boolean
Returns true if the image file is a JPG. The file extension is ignored, it looks at the image directly.


### File\_IsPNG (pathToFile:c\_text) returns isPNG:c\_boolean
Returns true if the image file is a PNG. The file extension is ignored, it looks at the image directly.


### File\_IsTabDelimited (pathToFile:c\_text) returns isTabDelimited:c\_boolean
Returns true if the file is tab-delimited.

**TESTS performed:**
- Is file extension ".tsv" or ".txt"
- Look at first line, expect line of tab-delimited values.
- At least 2 non-empty values in the header line.

### Folder\_DoesExist (pathToFolder:c\_text) returns doesExist:c\_boolean
Returns true if the file exists.

### Folder\_ParentName (folderPath:c\_text) returns parentFolderPath:c\_text
Returns the parent folder of the folderPath passed in.

### Folder\_VerifyExistance (pathToFolder:c\_text)
Creates a folder if it does not exist. If necessary, it will recursively create the parent folders as well.



## FileBuffer Shared Methods

### FileBuffer\_Init (docRef:c\_time {; bufferSize:c\_longint})
Initializes the necessary vars and pre-fills the buffer from
the already opened file.

### FileBuffer\_TellMeTheEOL () returns theEol:C\_text
Scans the filebuffer to figure out what the EOL is.

### FileBuffer\_EOF () returns isEOF:C\_boolean
Returns true if we are at the end of file.

### FileBuffer\_GetFilePostion () returns currentPositionInFile:c\_longint
Returns a logical position in the file.

### FileBuffer\_FetchData_BySize (numBytesToFetch:c\_longint) returns fileContent:c\_text
This method returns the specified number of bytes. If it cannot then that means that the file is empty.
  
### FileBuffer\_FetchData_ByString (matchOnText:c\_text{; matchOnText2:c\_text}) returns fileContent:c\_text
Returns text from the buffer up to AND INCLUDING the matchOnText or matchOnText2 values.

**NOTE**: This differs from RECEIVE PACKET.

### FileBuffer\_FetchData_PeekAhead (numCharactersToReturn:c\_longint) returns fileContent:c\_text
Returns fileContent up to the number of characters specified without
advancing the current position in the file.


### FileBuffer\_FetchCSVLine (eol:C\_text , valuesArrPtr:C\_pointer)
Populates the array with the parsed values from the line.
Recognizes a 1st line of "sep=" line.


### FileBuffer\_FetchTabDelimitedLne (eol:C\_text , valuesArrPtr:C\_pointer)
Fills the array with the next line of tab delimited values
from the open file.
