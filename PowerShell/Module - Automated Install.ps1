Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Install-Module -Name "Carbon" -AllowClobber
Set-PSRepository -Name PSGallery -InstallationPolicy UnTrusted