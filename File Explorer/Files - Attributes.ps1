# Hidden
Set-ItemProperty -Path "C:\Users\$env:Username\File.txt" -Name "Attributes" -Value ([System.IO.FileAttributes]::Hidden)