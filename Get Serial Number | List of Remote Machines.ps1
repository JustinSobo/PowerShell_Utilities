# Use the below powershell script to find serial number for multiple remote computers. First create the text file computers.txt which includes one computer name in each line. You will get the machine name and serial number in the csv file SerialNumbers.csv.

Get-Content C:\computers.txt  | ForEach-Object{
$ser_number = (Get-WMIObject Win32_Bios -ComputerName $_ ).SerialNumber
if(!$ser_number){
$ser_number ="The server is unavailable"
}
New-Object -TypeName PSObject -Property @{
      ComputerName = $_
      SerialNumber = $ser_number
}} | Select ComputerName,SerialNumber |
Export-Csv C:\SerialNumbers.csv -NoTypeInformation -Encoding UTF8
