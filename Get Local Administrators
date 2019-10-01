invoke-command {
 $members = net localgroup administrators |
 where {$_ -AND $_ -notmatch "command completed successfully"} |
 select -skip 4
 New-Object PSObject -Property @{
 Computername = $env:COMPUTERNAME
 Group = "Administrators"
 Members=$members
 }
 } -computer DC1,DC2,DC3,appserv,bausql,sqlrep -HideComputerName |
 Select * -ExcludeProperty RunspaceID | Export-CSV C:\Temp\local_admins.csv -NoTypeInformation
