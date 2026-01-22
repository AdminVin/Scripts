## Firewall - Block Connection
# Adobe Servers
if (-not (Get-NetFirewallRule -DisplayName "Adobe Servers" -ErrorAction SilentlyContinue)) {

    New-NetFirewallRule `
        -DisplayName "Adobe Servers" `
        -Direction Inbound `
        -Action Block `
        -Enabled True `
        -RemoteAddress @(
            "3.166.192.3","3.166.192.4","3.166.192.7","3.166.192.9","3.166.192.12","3.166.192.19",
            "3.166.192.21","3.166.192.24","3.166.192.26","3.166.192.28","3.166.192.30",
            "3.166.192.31","3.166.192.35","3.166.192.36","3.166.192.37","3.166.192.39",
            "3.166.192.41","3.166.192.45","3.166.192.47","3.166.192.49","3.166.192.52",
            "3.166.192.54","3.166.192.56","3.166.192.58","3.166.192.59","3.166.192.61",
            "3.166.192.62","3.166.192.64","3.166.192.66","3.166.192.67","3.166.192.69",
            "3.166.192.70","3.166.192.71","3.166.192.74","3.166.192.77","3.166.192.81",
            "3.166.192.83","3.166.192.87","3.166.192.88","3.166.192.89","3.166.192.92",
            "3.166.192.94","3.166.192.96","3.166.192.106","3.166.192.107","3.166.192.113",
            "3.166.192.114","3.166.192.116","3.166.192.117","3.166.192.124","3.166.192.125",
            "3.166.192.129",
            "13.33.252.31","13.33.252.102","13.33.252.103","13.33.252.118",
            "52.85.61.3","52.85.61.8","52.85.61.9","52.85.61.20","52.85.61.27",
            "52.85.61.30","52.85.61.31","52.85.61.32","52.85.61.33","52.85.61.34",
            "52.85.61.35","52.85.61.59","52.85.61.78","52.85.61.90","52.85.61.99",
            "52.85.61.102","52.85.61.104","52.85.61.106","52.85.61.110","52.85.61.113",
            "52.85.61.118","52.85.61.120","52.85.61.129"
        )

    New-NetFirewallRule `
        -DisplayName "Adobe Servers" `
        -Direction Outbound `
        -Action Block `
        -Enabled True `
        -RemoteAddress @(
            "3.166.192.3","3.166.192.4","3.166.192.7","3.166.192.9","3.166.192.12","3.166.192.19",
            "3.166.192.21","3.166.192.24","3.166.192.26","3.166.192.28","3.166.192.30",
            "3.166.192.31","3.166.192.35","3.166.192.36","3.166.192.37","3.166.192.39",
            "3.166.192.41","3.166.192.45","3.166.192.47","3.166.192.49","3.166.192.52",
            "3.166.192.54","3.166.192.56","3.166.192.58","3.166.192.59","3.166.192.61",
            "3.166.192.62","3.166.192.64","3.166.192.66","3.166.192.67","3.166.192.69",
            "3.166.192.70","3.166.192.71","3.166.192.74","3.166.192.77","3.166.192.81",
            "3.166.192.83","3.166.192.87","3.166.192.88","3.166.192.89","3.166.192.92",
            "3.166.192.94","3.166.192.96","3.166.192.106","3.166.192.107","3.166.192.113",
            "3.166.192.114","3.166.192.116","3.166.192.117","3.166.192.124","3.166.192.125",
            "3.166.192.129",
            "13.33.252.31","13.33.252.102","13.33.252.103","13.33.252.118",
            "52.85.61.3","52.85.61.8","52.85.61.9","52.85.61.20","52.85.61.27",
            "52.85.61.30","52.85.61.31","52.85.61.32","52.85.61.33","52.85.61.34",
            "52.85.61.35","52.85.61.59","52.85.61.78","52.85.61.90","52.85.61.99",
            "52.85.61.102","52.85.61.104","52.85.61.106","52.85.61.110","52.85.61.113",
            "52.85.61.118","52.85.61.120","52.85.61.129"
        )

    Write-Host "Adobe Servers - Blocked" -ForegroundColor Green

} else {
    Write-Host "Adobe Servers - Already Blocked!" -ForegroundColor Yellow
}

# Creative Cloud
if (-not (Get-NetFirewallRule -DisplayName "Adobe - Creative Cloud" -ErrorAction SilentlyContinue)) {
    netsh advfirewall firewall add rule name="Adobe - Creative Cloud" dir=in action=block program="C:\Program Files\Adobe\Adobe Creative Cloud Experience\CCXProcess.exe" enable=yes
    netsh advfirewall firewall add rule name="Adobe - Creative Cloud" dir=out action=block program="C:\Program Files\Adobe\Adobe Creative Cloud Experience\CCXProcess.exe" enable=yes
    netsh advfirewall firewall add rule name="Adobe - Creative Cloud" dir=in action=block program="C:\Program Files (x86)\Common Files\Adobe\Adobe Desktop Common\IPCBox\AdobeIPCBroker.exe" enable=yes
    netsh advfirewall firewall add rule name="Adobe - Creative Cloud" dir=out action=block program="C:\Program Files (x86)\Common Files\Adobe\Adobe Desktop Common\IPCBox\AdobeIPCBroker.exe" enable=yes
    Write-Host "Adobe Creative Cloud - Blocked" -ForegroundColor Green
} else { Write-Host "Adobe Creative Cloud - Already Blocked!" -ForegroundColor Yellow }

# Acrobat
if (-not (Get-NetFirewallRule -DisplayName "Adobe - Acrobat 2025" -ErrorAction SilentlyContinue)) {
    netsh advfirewall firewall add rule name="Adobe - Acrobat 2025" dir=in action=block program="C:\Program Files\Adobe\Acrobat DC\Acrobat\Acrobat.exe" enable=yes
    netsh advfirewall firewall add rule name="Adobe - Acrobat 2025" dir=out action=block program="C:\Program Files\Adobe\Acrobat DC\Acrobat\Acrobat.exe" enable=yes
    netsh advfirewall firewall add rule name="Adobe - Acrobat 2025 - CEF" dir=in action=block program="C:\Program Files\Adobe\Acrobat DC\Acrobat\AcroCEF\AcroCEF.exe" enable=yes
    netsh advfirewall firewall add rule name="Adobe - Acrobat 2025 - CEF" dir=out action=block program="C:\Program Files\Adobe\Acrobat DC\Acrobat\AcroCEF\AcroCEF.exe" enable=yes
    Write-Host "Adobe Acrobat 2025 - Blocked" -ForegroundColor Green
} else { Write-Host "Adobe Acrobat 2025 - Already Blocked!" -ForegroundColor Yellow }

# After Effects
if (-not (Get-NetFirewallRule -DisplayName "Adobe - After Effects 2025" -ErrorAction SilentlyContinue)) {
    netsh advfirewall firewall add rule name="Adobe - After Effects 2025" dir=in action=block program="C:\Program Files\Adobe\Adobe After Effects 2025\Support Files\AfterFX.exe" enable=yes
    netsh advfirewall firewall add rule name="Adobe - After Effects 2025" dir=out action=block program="C:\Program Files\Adobe\Adobe After Effects 2025\Support Files\AfterFX.exe" enable=yes
    Write-Host "Adobe After Effects 2025 - Blocked" -ForegroundColor Green
} else { Write-Host "Adobe After Effects 2025 - Already Blocked!" -ForegroundColor Yellow }

# After Effects - Media Encoder
if (-not (Get-NetFirewallRule -DisplayName "Adobe - After Effects - Media Encoder 2025" -ErrorAction SilentlyContinue)) {
    netsh advfirewall firewall add rule name="Adobe - After Effects - Media Encoder 2025" dir=in action=block program="C:\Program Files\Adobe\Adobe Media Encoder 2025\Adobe Media Encoder.exe" enable=yes
    netsh advfirewall firewall add rule name="Adobe - After Effects - Media Encoder 2025" dir=out action=block program="C:\Program Files\Adobe\Adobe Media Encoder 2025\Adobe Media Encoder.exe" enable=yes
    Write-Host "Adobe Media Encoder 2025 - Blocked" -ForegroundColor Green
} else { Write-Host "Adobe Media Encoder 2025 - Already Blocked!" -ForegroundColor Yellow }

# Animate
if (-not (Get-NetFirewallRule -DisplayName "Adobe - Animate 2024" -ErrorAction SilentlyContinue)) {
    netsh advfirewall firewall add rule name="Adobe - Animate 2024" dir=in action=block program="C:\Program Files\Adobe\Adobe Animate 2024\Animate.exe" enable=yes
    netsh advfirewall firewall add rule name="Adobe - Animate 2024" dir=out action=block program="C:\Program Files\Adobe\Adobe Animate 2024\Animate.exe" enable=yes
    Write-Host "Adobe Animate 2024 - Blocked" -ForegroundColor Green
} else { Write-Host "Adobe Animate 2024 - Already Blocked!" -ForegroundColor Yellow }

# Audition
if (-not (Get-NetFirewallRule -DisplayName "Adobe - Audition 2025" -ErrorAction SilentlyContinue)) {
    netsh advfirewall firewall add rule name="Adobe - Audition 2025" dir=in action=block program="C:\Program Files\Adobe\Adobe Audition 2025\Adobe Audition.exe" enable=yes
    netsh advfirewall firewall add rule name="Adobe - Audition 2025" dir=out action=block program="C:\Program Files\Adobe\Adobe Audition 2025\Adobe Audition.exe" enable=yes
    Write-Host "Adobe Audition 2025 - Blocked" -ForegroundColor Green
} else { Write-Host "Adobe Audition 2025 - Already Blocked!" -ForegroundColor Yellow }

# Bridge
if (-not (Get-NetFirewallRule -DisplayName "Adobe - Bridge 2025" -ErrorAction SilentlyContinue)) {
    netsh advfirewall firewall add rule name="Adobe - Bridge 2025" dir=in action=block program="C:\Program Files\Adobe\Adobe Bridge 2025\Adobe Bridge.exe" enable=yes
    netsh advfirewall firewall add rule name="Adobe - Bridge 2025" dir=out action=block program="C:\Program Files\Adobe\Adobe Bridge 2025\Adobe Bridge.exe" enable=yes
    Write-Host "Adobe Bridge 2025 - Blocked" -ForegroundColor Green
} else { Write-Host "Adobe Bridge 2025 - Already Blocked!" -ForegroundColor Yellow }

# Character Animator
if (-not (Get-NetFirewallRule -DisplayName "Adobe - Character Animator 2025" -ErrorAction SilentlyContinue)) {
    netsh advfirewall firewall add rule name="Adobe - Character Animator 2025" dir=in action=block program="C:\Program Files\Adobe\Adobe Character Animator 2025\Support Files\Character Animator.exe" enable=yes
    netsh advfirewall firewall add rule name="Adobe - Character Animator 2025" dir=out action=block program="C:\Program Files\Adobe\Adobe Character Animator 2025\Support Files\Character Animator.exe" enable=yes
    Write-Host "Adobe Character Animator 2025 - Blocked" -ForegroundColor Green
} else { Write-Host "Adobe Character Animator 2025 - Already Blocked!" -ForegroundColor Yellow }

# Dreamweaver
if (-not (Get-NetFirewallRule -DisplayName "Adobe - Dreamweaver 2021" -ErrorAction SilentlyContinue)) {
    netsh advfirewall firewall add rule name="Adobe - Dreamweaver 2021" dir=in action=block program="C:\Program Files\Adobe\Adobe Dreamweaver 2021\Dreamweaver.exe" enable=yes
    netsh advfirewall firewall add rule name="Adobe - Dreamweaver 2021" dir=out action=block program="C:\Program Files\Adobe\Adobe Dreamweaver 2021\Dreamweaver.exe" enable=yes
    netsh advfirewall firewall add rule name="Adobe - Dreamweaver 2021 - Helper" dir=in action=block program="C:\Program Files\Adobe\Adobe Dreamweaver 2021\DreamweaverHelper.exe" enable=yes
    netsh advfirewall firewall add rule name="Adobe - Dreamweaver 2021 - Helper" dir=out action=block program="C:\Program Files\Adobe\Adobe Dreamweaver 2021\DreamweaverHelper.exe" enable=yes
    netsh advfirewall firewall add rule name="Adobe - Dreamweaver 2021 - Image Helper" dir=in action=block program="C:\Program Files\Adobe\Adobe Dreamweaver 2021\DreamweaverImageHelper.exe" enable=yes
    netsh advfirewall firewall add rule name="Adobe - Dreamweaver 2021 - Image Helper" dir=out action=block program="C:\Program Files\Adobe\Adobe Dreamweaver 2021\DreamweaverImageHelper.exe" enable=yes
    Write-Host "Adobe Dreamweaver 2021 - Blocked" -ForegroundColor Green
} else { Write-Host "Adobe Dreamweaver 2021 - Already Blocked!" -ForegroundColor Yellow }

# Illustrator
if (-not (Get-NetFirewallRule -DisplayName "Adobe - Illustrator 2025" -ErrorAction SilentlyContinue)) {
    netsh advfirewall firewall add rule name="Adobe - Illustrator 2025" dir=in action=block program="C:\Program Files\Adobe\Adobe Illustrator 2025\Support Files\Contents\Windows\Illustrator.exe" enable=yes
    netsh advfirewall firewall add rule name="Adobe - Illustrator 2025" dir=out action=block program="C:\Program Files\Adobe\Adobe Illustrator 2025\Support Files\Contents\Windows\Illustrator.exe" enable=yes
    Write-Host "Adobe Illustrator 2025 - Blocked" -ForegroundColor Green
} else { Write-Host "Adobe Illustrator 2025 - Already Blocked!" -ForegroundColor Yellow }

# InCopy
if (-not (Get-NetFirewallRule -DisplayName "Adobe - InCopy 2025" -ErrorAction SilentlyContinue)) {
    netsh advfirewall firewall add rule name="Adobe - InCopy 2025" dir=in action=block program="C:\Program Files\Adobe\Adobe InCopy 2025\InCopy.exe" enable=yes
    netsh advfirewall firewall add rule name="Adobe - InCopy 2025" dir=out action=block program="C:\Program Files\Adobe\Adobe InCopy 2025\InCopy.exe" enable=yes
    Write-Host "Adobe InCopy 2025 - Blocked" -ForegroundColor Green
} else { Write-Host "Adobe InCopy 2025 - Already Blocked!" -ForegroundColor Yellow }

# InDesign
if (-not (Get-NetFirewallRule -DisplayName "Adobe - InDesign 2025" -ErrorAction SilentlyContinue)) {
    netsh advfirewall firewall add rule name="Adobe - InDesign 2025" dir=in action=block program="C:\Program Files\Adobe\Adobe InDesign 2025\InDesign.exe" enable=yes
    netsh advfirewall firewall add rule name="Adobe - InDesign 2025" dir=out action=block program="C:\Program Files\Adobe\Adobe InDesign 2025\InDesign.exe" enable=yes
    Write-Host "Adobe InDesign 2025 - Blocked" -ForegroundColor Green
} else { Write-Host "Adobe InDesign 2025 - Already Blocked!" -ForegroundColor Yellow }

# Lightroom
if (-not (Get-NetFirewallRule -DisplayName "Adobe - Lightroom Classic" -ErrorAction SilentlyContinue)) {
    netsh advfirewall firewall add rule name="Adobe - Lightroom Classic" dir=in action=block program="C:\Program Files\Adobe\Adobe Lightroom Classic\Lightroom.exe" enable=yes
    netsh advfirewall firewall add rule name="Adobe - Lightroom Classic" dir=out action=block program="C:\Program Files\Adobe\Adobe Lightroom Classic\Lightroom.exe" enable=yes
    Write-Host "Adobe Lightroom Classic - Blocked" -ForegroundColor Green
} else { Write-Host "Adobe Lightroom Classic - Already Blocked!" -ForegroundColor Yellow }

# Photoshop
if (-not (Get-NetFirewallRule -DisplayName "Adobe - Photoshop 2025" -ErrorAction SilentlyContinue)) {
    netsh advfirewall firewall add rule name="Adobe - Photoshop 2025" dir=in action=block program="C:\Program Files\Adobe\Adobe Photoshop 2025\Photoshop.exe" enable=yes
    netsh advfirewall firewall add rule name="Adobe - Photoshop 2025" dir=out action=block program="C:\Program Files\Adobe\Adobe Photoshop 2025\Photoshop.exe" enable=yes
    Write-Host "Adobe Photoshop 2025 - Blocked" -ForegroundColor Green
} else { Write-Host "Adobe Photoshop 2025 - Already Blocked!" -ForegroundColor Yellow }

# Premiere
if (-not (Get-NetFirewallRule -DisplayName "Adobe - Premiere 2025" -ErrorAction SilentlyContinue)) {
    netsh advfirewall firewall add rule name="Adobe - Premiere 2025" dir=in action=block program="C:\Program Files\Adobe\Adobe Premiere Pro 2025\Adobe Premiere Pro.exe" enable=yes
    netsh advfirewall firewall add rule name="Adobe - Premiere 2025" dir=out action=block program="C:\Program Files\Adobe\Adobe Premiere Pro 2025\Adobe Premiere Pro.exe" enable=yes
    Write-Host "Adobe Premiere Pro 2025 - Blocked" -ForegroundColor Green
} else { Write-Host "Adobe Premiere Pro 2025 - Already Blocked!" -ForegroundColor Yellow }

## Creative Cloud - Disable
# Disable Auto Start
Remove-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run" -Name "Adobe CCXProcess" -Force -ErrorAction SilentlyContinue | Out-Null
# Stop Process & Rename
Stop-Process -Name "CCXProcess" -ErrorAction SilentlyContinue | Out-Null
Rename-Item -Path "C:\Program Files\Adobe\Adobe Creative Cloud Experience\CCXProcess.exe" -NewName "C:\Program Files\Adobe\Adobe Creative Cloud Experience\CCXProcess.exe.old" -ErrorAction SilentlyContinue | Out-Null
Write-Host "Creative Cloud - Auto Launch Disabled" -ForegroundColor Green