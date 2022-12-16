You need a csv file called serverlist.csv with computer names in it
You need to save the script below as tempfile.ps1
Both files need to go into a directory called C:\scripts



# Script to clean up Citrix profiles
# Path to files for removal
$folder1 = @("C$\Users\*\AppData\Local\Temp\*")
$folder2 = @("C$\Users\*\AppData\Local\Microsoft\Terminal Server Client\Cache\*")
$folder3 = @("C$\Users\*\AppData\Local\Microsoft\Windows\Temporary Internet Files\Content.IE5\*")
$folder4 = @("C$\Users\*\AppData\Local\Mozilla\Firefox\Profiles\*")
$folder5 = @("C$\Users\*\AppData\Local\Spotify\*")
# Servers to remove files from
$computerlist = Get-Content C:\scripts\serverlist.csv
# Commands to remove files from each folder per server
foreach ($computer in $computerlist) {
Remove-Item "\\$computer\$folder1" -force -recurse
}
foreach ($computer in $computerlist) {
Remove-Item "\\$computer\$folder2" -force -recurse
}
foreach ($computer in $computerlist) {
Remove-Item "\\$computer\$folder3" -force -recurse
}
foreach ($computer in $computerlist) {
Remove-Item "\\$computer\$folder4" -force -recurse
}
foreach ($computer in $computerlist) {
Remove-Item "\\$computer\$folder5" -force -recurse
