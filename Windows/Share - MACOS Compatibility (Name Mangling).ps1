<# 
MACOS File Share Compatibility Fix

"Name mangling" is a feature of the Server Message Block (SMB) protocol used by both Windows and macOS for file sharing. It replaces certain characters in filenames with underscores to ensure compatibility with older versions of SMB used by some clients. However, it can sometimes cause issues with file names that are shared between different operating systems.
#>

New-ItemProperty -LiteralPath 'HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters' -Name 'DisableStrictNameChecking' -Value 1 -PropertyType DWord -Force

# Reboot for changes to take effect