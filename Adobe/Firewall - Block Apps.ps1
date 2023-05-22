## Block Adobe Apps from connecting to the Internet

# Creative Cloud
netsh advfirewall firewall add rule name="Adobe - Creative Cloud" dir=in action=block program="C:\Program Files\Adobe\Adobe Creative Cloud Experience\CCXProcess.exe" enable=yes
netsh advfirewall firewall add rule name="Adobe - Creative Cloud" dir=out action=block program="C:\Program Files\Adobe\Adobe Creative Cloud Experience\CCXProcess.exe" enable=yes

# IPC Broker
netsh advfirewall firewall add rule name="Adobe - Creative Cloud" dir=in action=block program="C:\Program Files (x86)\Common Files\Adobe\Adobe Desktop Common\IPCBox\AdobeIPCBroker.exe" enable=yes
netsh advfirewall firewall add rule name="Adobe - Creative Cloud" dir=out action=block program="C:\Program Files (x86)\Common Files\Adobe\Adobe Desktop Common\IPCBox\AdobeIPCBroker.exe" enable=yes

# After Effects
netsh advfirewall firewall add rule name="Adobe - After Effects 2023" dir=in action=block program="C:\Program Files\Adobe\Adobe After Effects 2023\Support Files\AfterFX.exe" enable=yes
netsh advfirewall firewall add rule name="Adobe - After Effects 2023" dir=out action=block program="C:\Program Files\Adobe\Adobe After Effects 2023\Support Files\AfterFX.exe" enable=yes

# After Effects - Media Encoder
netsh advfirewall firewall add rule name="Adobe - After Effects - Media Encoder 2023" dir=in action=block program="C:\Program Files\Adobe\Adobe Media Encoder 2023\Adobe Media Encoder.exe" enable=yes
netsh advfirewall firewall add rule name="Adobe - After Effects - Media Encoder 2023" dir=out action=block program="C:\Program Files\Adobe\Adobe Media Encoder 2023\Adobe Media Encoder.exe" enable=yes

# Dreamweaver
netsh advfirewall firewall add rule name="Adobe - Dreamweaver 2021" dir=in action=block program="C:\Program Files\Adobe\Adobe Dreamweaver 2021\Dreamweaver.exe" enable=yes
netsh advfirewall firewall add rule name="Adobe - Dreamweaver 2021" dir=out action=block program="C:\Program Files\Adobe\Adobe Dreamweaver 2021\Dreamweaver.exe" enable=yes

# Illustrator
netsh advfirewall firewall add rule name="Adobe - Illustrator 2023" dir=in action=block program="C:\Program Files\Adobe\Adobe Illustrator 2023\Support Files\Contents\Windows\Illustrator.exe" enable=yes
netsh advfirewall firewall add rule name="Adobe - Illustrator 2023" dir=out action=block program="C:\Program Files\Adobe\Adobe Illustrator 2023\Support Files\Contents\Windows\Illustrator.exe" enable=yes

# Lightroom
netsh advfirewall firewall add rule name="Adobe - Lightroom Classic" dir=in action=block program="C:\Program Files\Adobe\Adobe Lightroom Classic\Lightroom.exe" enable=yes
netsh advfirewall firewall add rule name="Adobe - Lightroom Classic" dir=out action=block program="C:\Program Files\Adobe\Adobe Lightroom Classic\Lightroom.exe" enable=yes

# Photoshop
netsh advfirewall firewall add rule name="Adobe - Photoshop 2023" dir=in action=block program="C:\Program Files\Adobe\Adobe Photoshop 2023\Photoshop.exe" enable=yes
netsh advfirewall firewall add rule name="Adobe - Photoshop 2023" dir=out action=block program="C:\Program Files\Adobe\Adobe Photoshop 2023\Photoshop.exe" enable=yes

# Premiere
netsh advfirewall firewall add rule name="Adobe - Premiere 2023" dir=in action=block program="C:\Program Files\Adobe\Adobe Premiere Pro 2023\Adobe Premiere Pro.exe" enable=yes
netsh advfirewall firewall add rule name="Adobe - Premiere 2023" dir=out action=block program="C:\Program Files\Adobe\Adobe Premiere Pro 2023\Adobe Premiere Pro.exe" enable=yes
