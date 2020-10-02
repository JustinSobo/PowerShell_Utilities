Get-ADUser -Identity FromUSER -Properties memberof | Select-Object -ExpandProperty memberof |  Add-ADGroupMember -Members ToUSER
