$SomePath="\\app\opsware"

Get-ChildItem -Path $SomePath -Recurse -Directory | ForEach-Object -Process {
  if ($false -eq $_.GetFileSystemInfos())
    {
      $_.FullName
    }
}
