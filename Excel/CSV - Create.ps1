$columns = "NOT USED", "NOT USED", "LAST NAME", "FIRST NAME", "POSITION", "LOCATION", "START DATE", "END DATE", "TERM REASON", "ACTION CODE", "EMPID", "EMAIL", "PHONE", "NOTES", "GENDER", "COUNTRY"
$data = New-Object System.Collections.ArrayList

# Add a row of data to the array list
$row = "Value1", "Value2", "Value3", "Value4", "Value5", "Value6", "Value7", "Value8", "Value9", "Value10", "Value11", "Value12", "Value13", "Value14", "Value15", "Value16"
$data.Add((New-Object PSObject -Property ([ordered]@{
    "NOT USED" = $row[0]
    "NOT USED1" = $row[1]
    "LAST NAME" = $row[2]
    "FIRST NAME" = $row[3]
    "POSITION" = $row[4]
    "LOCATION" = $row[5]
    "START DATE" = $row[6]
    "END DATE" = $row[7]
    "TERM REASON" = $row[8]
    "ACTION CODE" = $row[9]
    "EMPID" = $row[10]
    "EMAIL" = $row[11]
    "PHONE" = $row[12]
    "NOTES" = $row[13]
    "GENDER" = $row[14]
    "COUNTRY" = $row[15]
}))) | Out-Null

# Export the array list to a CSV file
$data | Export-Csv -Path "C:\path\to\file.csv" -Delimiter "," -NoTypeInformation
