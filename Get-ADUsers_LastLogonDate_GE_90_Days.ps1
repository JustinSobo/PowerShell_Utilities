# This code is sterile, and contains no company data.
# Setting up initial variables.
$currentDate = Get-Date
$pastDate = $currentDate.AddDays(-90)
$attributes = @('Name', 'DisplayName', 'UserPrincipalName', 'LastLogonDate')
$exportPath = '~\desktop\ADUsers_LastLogonDate_GE_90_Days.csv'

# Retrieving ADUser for which have not been signed into for 90 or more days, and exporting the list to a CSV document.
# EXAMPLE SEARCHBASE: <OU=NULL,DC=NULL,DC=NULL>
Get-ADUser -Filter * -Properties * -SearchBase "<...>" `
| Where-Object {$_.LastLogonDate -le $pastDate} `
| Select-Object $attributes `
| Export-Csv -Path $exportPath
