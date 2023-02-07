# Source: https://support.microsoft.com/en-us/office/user-experience-changes-for-sharing-a-calendar-in-outlook-5978620a-fe6c-422a-93b2-8f80e488fdec
# This is to be used when a user is trying to share there calendar within the Outlook and getting the error "Some permissions cannot be displayed"

if((Test-Path -LiteralPath "HKCU:\Software\Microsoft\Office\16.0\Outlook\Options\Calendar") -ne $true) {  New-Item "HKCU:\Software\Microsoft\Office\16.0\Outlook\Options\Calendar" -Force -ErrorAction SilentlyContinue }
New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Office\16.0\Outlook\Options\Calendar' -Name 'ShowLegacySharingUX' -Value 1 -PropertyType DWord -Force -ErrorAction SilentlyContinue