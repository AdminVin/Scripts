# Set Edge Enterprise Site List (Internet Explorer Mode)
if((Test-Path -LiteralPath "HKCU:\Software\Policies\Microsoft\Edge") -ne $true) {New-Item "HKCU:\Software\Policies\Microsoft\Edge" -Force}
New-ItemProperty -LiteralPath "HKCU:\Software\Policies\Microsoft\Edge" -Name "InternetExplorerIntegrationLevel" -Value 1 -PropertyType DWord -Force
New-ItemProperty -LiteralPath "HKCU:\Software\Policies\Microsoft\Edge" -Name "InternetExplorerIntegrationSiteList" -Value "\SERVER.DOMAIN.LOCAL\SHARE\MicrosoftEdge-SiteCompatibilityList.XML" -PropertyType String -Force

# Pop Ups - Allow
if((Test-Path -LiteralPath "HKCU:\Software\Policies\Microsoft\Edge\PopupsAllowedForUrls") -ne $true) {New-Item "HKCU:\Software\Policies\Microsoft\Edge\PopupsAllowedForUrls" -Force}
New-ItemProperty -LiteralPath "HKCU:\Software\Policies\Microsoft\Edge\PopupsAllowedForUrls" -Name "1" -Value "*.gmail.com" -PropertyType String -Force 
New-ItemProperty -LiteralPath "HKCU:\Software\Policies\Microsoft\Edge\PopupsAllowedForUrls" -Name "2" -Value "*.youtube.com" -PropertyType String -Force 