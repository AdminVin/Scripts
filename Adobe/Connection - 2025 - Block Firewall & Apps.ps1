## Firewall - Block Connection

# Creative Cloud
if (-not (Get-NetFirewallRule -DisplayName "Adobe - Creative Cloud" -ErrorAction SilentlyContinue)) {
    netsh advfirewall firewall add rule name="Adobe - Creative Cloud" dir=in action=block program="C:\Program Files\Adobe\Adobe Creative Cloud Experience\CCXProcess.exe" enable=yes
    netsh advfirewall firewall add rule name="Adobe - Creative Cloud" dir=out action=block program="C:\Program Files\Adobe\Adobe Creative Cloud Experience\CCXProcess.exe" enable=yes
    netsh advfirewall firewall add rule name="Adobe - Creative Cloud" dir=in action=block program="C:\Program Files (x86)\Common Files\Adobe\Adobe Desktop Common\IPCBox\AdobeIPCBroker.exe" enable=yes
    netsh advfirewall firewall add rule name="Adobe - Creative Cloud" dir=out action=block program="C:\Program Files (x86)\Common Files\Adobe\Adobe Desktop Common\IPCBox\AdobeIPCBroker.exe" enable=yes
    Write-Host "Adobe Creative Cloud - Blocked" -ForegroundColor Green
}

# Acrobat
if (-not (Get-NetFirewallRule -DisplayName "Adobe - Acrobat 2025" -ErrorAction SilentlyContinue)) {
    netsh advfirewall firewall add rule name="Adobe - Acrobat 2025" dir=in action=block program="C:\Program Files\Adobe\Acrobat DC\Acrobat\Acrobat.exe" enable=yes
    netsh advfirewall firewall add rule name="Adobe - Acrobat 2025" dir=out action=block program="C:\Program Files\Adobe\Acrobat DC\Acrobat\Acrobat.exe" enable=yes
    netsh advfirewall firewall add rule name="Adobe - Acrobat 2025 - CEF" dir=in action=block program="C:\Program Files\Adobe\Acrobat DC\Acrobat\AcroCEF\AcroCEF.exe" enable=yes
    netsh advfirewall firewall add rule name="Adobe - Acrobat 2025 - CEF" dir=out action=block program="C:\Program Files\Adobe\Acrobat DC\Acrobat\AcroCEF\AcroCEF.exe" enable=yes
    Write-Host "Adobe Acrobat 2025 - Blocked" -ForegroundColor Green
}

# After Effects
if (-not (Get-NetFirewallRule -DisplayName "Adobe - After Effects 2025" -ErrorAction SilentlyContinue)) {
    netsh advfirewall firewall add rule name="Adobe - After Effects 2025" dir=in action=block program="C:\Program Files\Adobe\Adobe After Effects 2025\Support Files\AfterFX.exe" enable=yes
    netsh advfirewall firewall add rule name="Adobe - After Effects 2025" dir=out action=block program="C:\Program Files\Adobe\Adobe After Effects 2025\Support Files\AfterFX.exe" enable=yes
    Write-Host "Adobe After Effects 2025 - Blocked" -ForegroundColor Green
}

# After Effects - Media Encoder
if (-not (Get-NetFirewallRule -DisplayName "Adobe - After Effects - Media Encoder 2025" -ErrorAction SilentlyContinue)) {
    netsh advfirewall firewall add rule name="Adobe - After Effects - Media Encoder 2025" dir=in action=block program="C:\Program Files\Adobe\Adobe Media Encoder 2025\Adobe Media Encoder.exe" enable=yes
    netsh advfirewall firewall add rule name="Adobe - After Effects - Media Encoder 2025" dir=out action=block program="C:\Program Files\Adobe\Adobe Media Encoder 2025\Adobe Media Encoder.exe" enable=yes
    Write-Host "Adobe Media Encoder 2025 - Blocked" -ForegroundColor Green
}

# Animate
if (-not (Get-NetFirewallRule -DisplayName "Adobe - Animate 2024" -ErrorAction SilentlyContinue)) {
    netsh advfirewall firewall add rule name="Adobe - Animate 2024" dir=in action=block program="C:\Program Files\Adobe\Adobe Animate 2024\Animate.exe" enable=yes
    netsh advfirewall firewall add rule name="Adobe - Animate 2024" dir=out action=block program="C:\Program Files\Adobe\Adobe Animate 2024\Animate.exe" enable=yes
    Write-Host "Adobe Animate 2024 - Blocked" -ForegroundColor Green
}

# Audition
if (-not (Get-NetFirewallRule -DisplayName "Adobe - Audition 2025" -ErrorAction SilentlyContinue)) {
    netsh advfirewall firewall add rule name="Adobe - Audition 2025" dir=in action=block program="C:\Program Files\Adobe\Adobe Audition 2025\Adobe Audition.exe" enable=yes
    netsh advfirewall firewall add rule name="Adobe - Audition 2025" dir=out action=block program="C:\Program Files\Adobe\Adobe Audition 2025\Adobe Audition.exe" enable=yes
    Write-Host "Adobe Audition 2025 - Blocked" -ForegroundColor Green
}

# Bridge
if (-not (Get-NetFirewallRule -DisplayName "Adobe - Bridge 2025" -ErrorAction SilentlyContinue)) {
    netsh advfirewall firewall add rule name="Adobe - Bridge 2025" dir=in action=block program="C:\Program Files\Adobe\Adobe Bridge 2025\Adobe Bridge.exe" enable=yes
    netsh advfirewall firewall add rule name="Adobe - Bridge 2025" dir=out action=block program="C:\Program Files\Adobe\Adobe Bridge 2025\Adobe Bridge.exe" enable=yes
    Write-Host "Adobe Bridge 2025 - Blocked" -ForegroundColor Green
}

# Character Animator
if (-not (Get-NetFirewallRule -DisplayName "Adobe - Character Animator 2025" -ErrorAction SilentlyContinue)) {
    netsh advfirewall firewall add rule name="Adobe - Character Animator 2025" dir=in action=block program="C:\Program Files\Adobe\Adobe Character Animator 2025\Support Files\Character Animator.exe" enable=yes
    netsh advfirewall firewall add rule name="Adobe - Character Animator 2025" dir=out action=block program="C:\Program Files\Adobe\Adobe Character Animator 2025\Support Files\Character Animator.exe" enable=yes
    Write-Host "Adobe Character Animator 2025 - Blocked" -ForegroundColor Green
}

# Dreamweaver
if (-not (Get-NetFirewallRule -DisplayName "Adobe - Dreamweaver 2021" -ErrorAction SilentlyContinue)) {
    netsh advfirewall firewall add rule name="Adobe - Dreamweaver 2021" dir=in action=block program="C:\Program Files\Adobe\Adobe Dreamweaver 2021\Dreamweaver.exe" enable=yes
    netsh advfirewall firewall add rule name="Adobe - Dreamweaver 2021" dir=out action=block program="C:\Program Files\Adobe\Adobe Dreamweaver 2021\Dreamweaver.exe" enable=yes
    netsh advfirewall firewall add rule name="Adobe - Dreamweaver 2021 - Helper" dir=in action=block program="C:\Program Files\Adobe\Adobe Dreamweaver 2021\DreamweaverHelper.exe" enable=yes
    netsh advfirewall firewall add rule name="Adobe - Dreamweaver 2021 - Helper" dir=out action=block program="C:\Program Files\Adobe\Adobe Dreamweaver 2021\DreamweaverHelper.exe" enable=yes
    netsh advfirewall firewall add rule name="Adobe - Dreamweaver 2021 - Image Helper" dir=in action=block program="C:\Program Files\Adobe\Adobe Dreamweaver 2021\DreamweaverImageHelper.exe" enable=yes
    netsh advfirewall firewall add rule name="Adobe - Dreamweaver 2021 - Image Helper" dir=out action=block program="C:\Program Files\Adobe\Adobe Dreamweaver 2021\DreamweaverImageHelper.exe" enable=yes
    Write-Host "Adobe Dreamweaver 2021 - Blocked" -ForegroundColor Green
}

# Illustrator
if (-not (Get-NetFirewallRule -DisplayName "Adobe - Illustrator 2025" -ErrorAction SilentlyContinue)) {
    netsh advfirewall firewall add rule name="Adobe - Illustrator 2025" dir=in action=block program="C:\Program Files\Adobe\Adobe Illustrator 2025\Support Files\Contents\Windows\Illustrator.exe" enable=yes
    netsh advfirewall firewall add rule name="Adobe - Illustrator 2025" dir=out action=block program="C:\Program Files\Adobe\Adobe Illustrator 2025\Support Files\Contents\Windows\Illustrator.exe" enable=yes
    Write-Host "Adobe Illustrator 2025 - Blocked" -ForegroundColor Green
}

# InCopy
if (-not (Get-NetFirewallRule -DisplayName "Adobe - InCopy 2025" -ErrorAction SilentlyContinue)) {
    netsh advfirewall firewall add rule name="Adobe - InCopy 2025" dir=in action=block program="C:\Program Files\Adobe\Adobe InCopy 2025\InCopy.exe" enable=yes
    netsh advfirewall firewall add rule name="Adobe - InCopy 2025" dir=out action=block program="C:\Program Files\Adobe\Adobe InCopy 2025\InCopy.exe" enable=yes
    Write-Host "Adobe InCopy 2025 - Blocked" -ForegroundColor Green
}

# InDesign
if (-not (Get-NetFirewallRule -DisplayName "Adobe - InDesign 2025" -ErrorAction SilentlyContinue)) {
    netsh advfirewall firewall add rule name="Adobe - InDesign 2025" dir=in action=block program="C:\Program Files\Adobe\Adobe InDesign 2025\InDesign.exe" enable=yes
    netsh advfirewall firewall add rule name="Adobe - InDesign 2025" dir=out action=block program="C:\Program Files\Adobe\Adobe InDesign 2025\InDesign.exe" enable=yes
    Write-Host "Adobe InDesign 2025 - Blocked" -ForegroundColor Green
}

# Lightroom
if (-not (Get-NetFirewallRule -DisplayName "Adobe - Lightroom Classic" -ErrorAction SilentlyContinue)) {
    netsh advfirewall firewall add rule name="Adobe - Lightroom Classic" dir=in action=block program="C:\Program Files\Adobe\Adobe Lightroom Classic\Lightroom.exe" enable=yes
    netsh advfirewall firewall add rule name="Adobe - Lightroom Classic" dir=out action=block program="C:\Program Files\Adobe\Adobe Lightroom Classic\Lightroom.exe" enable=yes
    Write-Host "Adobe Lightroom Classic - Blocked" -ForegroundColor Green
}

# Photoshop
if (-not (Get-NetFirewallRule -DisplayName "Adobe - Photoshop 2025" -ErrorAction SilentlyContinue)) {
    netsh advfirewall firewall add rule name="Adobe - Photoshop 2025" dir=in action=block program="C:\Program Files\Adobe\Adobe Photoshop 2025\Photoshop.exe" enable=yes
    netsh advfirewall firewall add rule name="Adobe - Photoshop 2025" dir=out action=block program="C:\Program Files\Adobe\Adobe Photoshop 2025\Photoshop.exe" enable=yes
    Write-Host "Adobe Photoshop 2025 - Blocked" -ForegroundColor Green
}

# Premiere
if (-not (Get-NetFirewallRule -DisplayName "Adobe - Premiere 2025" -ErrorAction SilentlyContinue)) {
    netsh advfirewall firewall add rule name="Adobe - Premiere 2025" dir=in action=block program="C:\Program Files\Adobe\Adobe Premiere Pro 2025\Adobe Premiere Pro.exe" enable=yes
    netsh advfirewall firewall add rule name="Adobe - Premiere 2025" dir=out action=block program="C:\Program Files\Adobe\Adobe Premiere Pro 2025\Adobe Premiere Pro.exe" enable=yes
    Write-Host "Adobe Premiere Pro 2025 - Blocked" -ForegroundColor Green
}

## Creative Cloud - Disable
# Disable Auto Start
Remove-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run" -Name "Adobe CCXProcess" -Force -ErrorAction SilentlyContinue | Out-Null
# Stop Process & Rename
Stop-Process -Name "CCXProcess" -ErrorAction SilentlyContinue | Out-Null
Rename-Item -Path "C:\Program Files\Adobe\Adobe Creative Cloud Experience\CCXProcess.exe" -NewName "C:\Program Files\Adobe\Adobe Creative Cloud Experience\CCXProcess.exe.old" -ErrorAction SilentlyContinue | Out-Null