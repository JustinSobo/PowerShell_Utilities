# Use the below powershell script to to find serial number for multiple remote computers from csv file. First create the csv file computers.csv which includes the column ComputerName in the csv file. You will get the ComputerName and SerialNumber list in the csv file SerialNumbers.csv.

Import-Csv C:\computers.csv | ForEach-Object{
$ser_number = (Get-WMIObject Win32_Bios -ComputerName $_.ComputerName).SerialNumber
if(!$ser_number){
$ser_number ="The server is unavailable"
}
New-Object -TypeName PSObject -Property @{
      ComputerName = $_.ComputerName
      SerialNumber = $ser_number
}} | Select ComputerName,SerialNumber |
Export-Csv C:\SerialNumbers.csv -NoTypeInformation -Encoding UTF8
