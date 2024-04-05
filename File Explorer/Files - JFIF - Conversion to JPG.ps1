## This will add a right click context menu option, when right clicking a *.JFIF file to convert to *.JPG

# Variables
$key = "HKLM:\SOFTWARE\Classes\SystemFileAssociations\.jfif\shell\ConvertToJPG"
$value = "Convert to JPG"
$command = "powershell.exe Rename-Item -Path '%1' -NewName ('%1.jpg')"

# Directories/Sub Directories
New-Item -Path $key -Force | Out-Null
Set-ItemProperty -Path $key -Name "(Default)" -Value $value

# Icon
New-ItemProperty -LiteralPath $key -Name 'Icon' -Value 'shell32.dll,-16805' -PropertyType String -Force | Out-Null

# Command
$commandKey = Join-Path $key "command"
New-Item -Path $commandKey -Force | Out-Null
Set-ItemProperty -Path $commandKey -Name "(Default)" -Value $command