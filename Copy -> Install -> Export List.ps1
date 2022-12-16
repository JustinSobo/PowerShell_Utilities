#START

#This copies the installation package to the host machine 'C' drive.
Copy-Item -Path C:\EXAMPLE.msi -Destination \\PC-EXAMPLE\c$

#This installs the program. Specify the host and package file path.
Invoke-Command -ComputerName PC-EXAMPLE -ScriptBlock { 
    Start-Process \\PC-EXAMPLE\c$\EXAMPLE.msi -ArgumentList '/silent' -Wait
}
#This gets a list of all installed programs, formats list, exports list to host 'C' drive as .txt for viewing.
Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName | Format-Table –AutoSize > \\PC-EXAMPLE\c$\EXAMPLE.txt

#END
