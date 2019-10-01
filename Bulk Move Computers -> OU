$ComputerName = Get-Content "c:\computernames.txt"  
$TargetOU = Get-ADOrganizationalUnit -ldapfilter "(name=OUnamegoeshere)"
foreach ($Computer in $ComputerName) {  
          Get-ADComputer $Computer | Move-ADObject -TargetPath $TargetOU }
