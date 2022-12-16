Get-ChildItem -Path "C:\PATHTOFILES" -recurse | Where-Object {$_.CreationTime -lt ((Get-Date).AddWeeks(-5))} | Remove-Item -recurse -force
