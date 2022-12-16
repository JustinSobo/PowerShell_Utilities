#Gives user ability to remote into machine.
Add-LocalGroupMember -Group "Remote Desktop Users" -Member "user"

#Used to verify after added.
Get-LocalGroupMember -Group "Remote Desktop Users"
