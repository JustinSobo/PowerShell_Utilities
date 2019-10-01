Import-Module ActiveDirectory 

$SourceGroup = 'SupervisorsDG'
$DestGroup = 'NEW HIRE REQUESTS'

$users = Get-ADGroupMember -Identity $SourceGroup | select SamAccountName
Add-ADGroupMember -Identity $DestGroup -Members $users
