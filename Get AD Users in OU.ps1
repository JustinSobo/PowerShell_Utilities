# Replace the OU path with your own, and run. The output will equal all AD users in the specified group.
# Dependency: Import-Module ActiveDirectory

Get-ADUser -Filter * -SearchBase "OU=Sorting,OU=Departments,OU=Jacksonville HQ,DC=MGADM" | format-table name
