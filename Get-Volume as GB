# Get drives and convert unit of measurement to GB.

# Defining function.
function ConvertToGB($bytes) {
    $gb = $bytes / 1GB
    [int]$gb
}

# Execution and passing of data to previously defined function.
Get-Volume `
| Select DriveLetter, `
@{n='Free';e={ConvertToGB $_.SizeRemaining}}, `
@{n='Total';e={ConvertToGB $_.Size}}
