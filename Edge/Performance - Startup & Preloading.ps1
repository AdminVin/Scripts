# Disable 'Startup Boost'
New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Name "StartupBoostEnabled" -Value 0 -PropertyType DWord -Force

# Disable 'New Tab Page Preloading'
New-ItemProperty -LiteralPath "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Name "NewTabPagePrerenderEnabled" -Value 0 -PropertyType DWord -Force
