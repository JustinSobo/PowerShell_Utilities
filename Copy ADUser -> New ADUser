# Test the ADUser wishing to be copied from.
Get-ADUser USERNAME -Properties *

# Assigning ADUser wishing to be copied from to a variable.
$user = Get-ADUser USERNAME -Properties *

# Creating the new ADUser.
New-ADUser -Name 'FULL NAME' -Instance $user
