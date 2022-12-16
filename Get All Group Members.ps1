List users 

Import-Module ActiveDirectory 
$Groups = Get-ADGroup -Filter * -SearchBase  "DC=domainname,DC=local" 
$ou = "DC=hardenassociates,DC=com" 
Get-ADGroup -Filter * -SearchBase $OU | select -ExpandProperty name | % {
$group= "$_"
$result += Get-ADGroupMember -identity "$_" | select @{n="Group";e={$group}},Name }
$result | export-csv 'groups.csv' -notypeinformation 


List users excluding disabled

Import-Module ActiveDirectory 
$OU = "DC=hardenassociates,DC=com"
$Groups = Get-ADGroup -Filter * -SearchBase $OU
foreach($Group in $Groups){
    $Members = $Group | Get-ADGroupMember
    foreach($Member in $Members){
        if($Member.objectClass -like "user"){
            $Enabled = $(Get-ADuser -Identity $Member.SamAccountName -Properties Enabled -ErrorAction Ignore).Enabled
            if($Enabled){
                $Group | select @{n="Group Name";e={$_.Name}}, @{n="Group Type";e={$_.GroupCategory}}, @{n="User DisplayName";e={$Member.name}}, @{n="User Name";e={$Member.SamAccountName}} | export-csv C:\Temp\Groups.csv -Append -notypeinformatio
            }
        }
    }
}
