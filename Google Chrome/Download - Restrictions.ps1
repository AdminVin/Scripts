# Setting download restrictions to block files flagged as Dangerous, Dangerous_Host, and Account_Compromise
# Source: https://support.google.com/chrome/a/answer/7579271?hl=en

<# Value Settings
0 — Default. No special restrictions.

1 — Blocks the following files: files flagged by Safe Browsing as DANGEROUS_ACCOUNT_COMPROMISE or DANGEROUS download URLs flagged by Safe Browsing files that have a danger_level of DANGEROUS and ALLOW_ON_USER_GESTURE.
Note: We only recommend setting this policy for organization units, browsers, or users that do not regularly incorrectly identify an entity, such as a file or a process, as malicious.

2 — Blocks the following files:
Files flagged by Safe Browsing as DANGEROUS, UNCOMMON, POTENTIALLY_UNWANTED, DANGEROUS_HOST, DANGEROUS_ACCOUNT_COMPROMISE download URLs flagged by Safe Browsing files that have a danger_level of DANGEROUS and ALLOW_ON_USER_GESTURE
Note: We only recommend setting this policy for organization units, browsers, or users that do not regularly incorrectly identify an entity, such as a file or a process, as malicious

3 — Blocks all downloads. Not recommended, except for special use cases.

4—Recommended. Blocks files flagged as DANGEROUS, DANGEROUS_HOST, ACCOUNT_COMPROMISE, or if the URL is flagged by Safe Browsing
#>

$DownloadValue = "0"

if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Policies\Google\Chrome") -ne $true) {  New-Item "HKLM:\SOFTWARE\Policies\Google\Chrome" -force -ea SilentlyContinue };
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Policies\Google\Chrome' -Name 'DownloadRestrictions' -Value $DownloadValue -PropertyType DWord -Force -ea SilentlyContinue;