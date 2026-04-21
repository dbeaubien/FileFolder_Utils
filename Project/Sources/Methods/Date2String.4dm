//%attributes = {"invisible":true,"preemptive":"capable"}
// Method: Date2String ( date {; formatStr} ) : formated date as string
//
//   Supported formats: mm, m1, month, mon, dd, d1, day, dayShort, yyyy, yy
//   Defaults to "mm/dd/yyyy".
//   If a date of !00/00/00! is passed then a blank string is returned.
#DECLARE($date_to_convert : Date; $date_format : Text)->$date_as_string : Text
// ===============================================================
// ---- PARAMETERS AND RESULTS ----
//   $1 [in]: date to format
//   $2 [optional in]: format to convert date to
//   $0 [out]: formated date as string
// ---- DESCRIPTION ----
//   This method converts the date into a string as dictated by the
//   optional format string. If the format string is not specified then
//   it defaults to "mm/dd/yyyy".
//
//   If a date of !00/00/00! is passed then a blank string is returned.
//
//   The following is the text that is converted by the format string
//   "mm" is converted to a two digit month
//   "dd" is converted to a two digit day
//   "yyyy" is converted to a four digit year
//   "yy" is converted to a two digit year
//   "month" is converted to the full month name
//   "mon" is converted to an abbreviated month name
//   "day" is converted to the full day name
// ---- CHANGE HISTORY ----
//   1999/02/28   DB   Created
//   2000/03/21   DB   Modified to include the new header formating
// ===============================================================
//#Start method
ASSERT:C1129((Count parameters:C259=1) || (Count parameters:C259=2))
If ($date_format="")
	$date_format:="mm/dd/yyyy"
End if 

var $Day; $Month; $Year; $WeekDay : Integer
If ($date_to_convert=!00-00-00!)  // return blank string if date !00/00/00!
	$date_as_string:=""
	return 
Else 
	$date_as_string:=$date_format  // start with the format string
End if 

$Day:=Day of:C23($date_to_convert)
$Month:=Month of:C24($date_to_convert)
$Year:=Year of:C25($date_to_convert)
$WeekDay:=Day number:C114($date_to_convert)

var $DayStr; $DayStr2; $MonthStr; $MonthStr2 : Text
$DayStr:=String:C10($Day)
$DayStr2:=String:C10($Day; "00")
$MonthStr:=String:C10($Month; "00")
$MonthStr2:=String:C10($Month)

// Put the year in the string
$date_as_string:=Replace string:C233($date_as_string; "yyyy"; String:C10($Year))
$date_as_string:=Replace string:C233($date_as_string; "yy"; String:C10(Mod:C98($Year; 100); "00"))

// Put the Month in the string
$date_as_string:=Replace string:C233($date_as_string; "mm"; $MonthStr)
$date_as_string:=Replace string:C233($date_as_string; "m1"; $MonthStr2)
Case of 
	: ($Month=1)
		$date_as_string:=Replace string:C233($date_as_string; "Month"; "January")
		$date_as_string:=Replace string:C233($date_as_string; "Mon"; "Jan")
	: ($Month=2)
		$date_as_string:=Replace string:C233($date_as_string; "Month"; "February")
		$date_as_string:=Replace string:C233($date_as_string; "Mon"; "Feb")
	: ($Month=3)
		$date_as_string:=Replace string:C233($date_as_string; "Month"; "March")
		$date_as_string:=Replace string:C233($date_as_string; "Mon"; "Mar")
	: ($Month=4)
		$date_as_string:=Replace string:C233($date_as_string; "Month"; "April")
		$date_as_string:=Replace string:C233($date_as_string; "Mon"; "Apr")
	: ($Month=5)
		$date_as_string:=Replace string:C233($date_as_string; "Month"; "May")
		$date_as_string:=Replace string:C233($date_as_string; "Mon"; "May")
	: ($Month=6)
		$date_as_string:=Replace string:C233($date_as_string; "Month"; "June")
		$date_as_string:=Replace string:C233($date_as_string; "Mon"; "Jun")
	: ($Month=7)
		$date_as_string:=Replace string:C233($date_as_string; "Month"; "July")
		$date_as_string:=Replace string:C233($date_as_string; "Mon"; "Jul")
	: ($Month=8)
		$date_as_string:=Replace string:C233($date_as_string; "Month"; "August")
		$date_as_string:=Replace string:C233($date_as_string; "Mon"; "Aug")
	: ($Month=9)
		$date_as_string:=Replace string:C233($date_as_string; "Month"; "September")
		$date_as_string:=Replace string:C233($date_as_string; "Mon"; "Sep")
	: ($Month=10)
		$date_as_string:=Replace string:C233($date_as_string; "Month"; "October")
		$date_as_string:=Replace string:C233($date_as_string; "Mon"; "Oct")
	: ($Month=11)
		$date_as_string:=Replace string:C233($date_as_string; "Month"; "November")
		$date_as_string:=Replace string:C233($date_as_string; "Mon"; "Nov")
	: ($Month=12)
		$date_as_string:=Replace string:C233($date_as_string; "Month"; "December")
		$date_as_string:=Replace string:C233($date_as_string; "Mon"; "Dec")
End case 

Case of 
	: ($WeekDay=1)
		$date_as_string:=Replace string:C233($date_as_string; "dayShort"; "Sun")
		$date_as_string:=Replace string:C233($date_as_string; "day"; "Sunday")
	: ($WeekDay=2)
		$date_as_string:=Replace string:C233($date_as_string; "dayShort"; "Mon")
		$date_as_string:=Replace string:C233($date_as_string; "day"; "Monday")
	: ($WeekDay=3)
		$date_as_string:=Replace string:C233($date_as_string; "dayShort"; "Tue")
		$date_as_string:=Replace string:C233($date_as_string; "day"; "Tuesday")
	: ($WeekDay=4)
		$date_as_string:=Replace string:C233($date_as_string; "dayShort"; "Wed")
		$date_as_string:=Replace string:C233($date_as_string; "day"; "Wednesday")
	: ($WeekDay=5)
		$date_as_string:=Replace string:C233($date_as_string; "dayShort"; "Thu")
		$date_as_string:=Replace string:C233($date_as_string; "day"; "Thursday")
	: ($WeekDay=6)
		$date_as_string:=Replace string:C233($date_as_string; "dayShort"; "Fri")
		$date_as_string:=Replace string:C233($date_as_string; "day"; "Friday")
	: ($WeekDay=7)
		$date_as_string:=Replace string:C233($date_as_string; "dayShort"; "Sat")
		$date_as_string:=Replace string:C233($date_as_string; "day"; "Saturday")
End case 

// Put the day in the string
$date_as_string:=Replace string:C233($date_as_string; "d1"; $DayStr)
$date_as_string:=Replace string:C233($date_as_string; "dd"; $DayStr2)