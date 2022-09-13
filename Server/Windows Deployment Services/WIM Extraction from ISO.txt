# Source: https://www.itechguides.com/windows-deployment-services-2019/

# Download Windows 10 .ISO and extract contents

# Run CMD as Administrator, and navigate to extracted folder "Sources"
# cd Win10_Extracted/sources

# View all Versions of Windows and identify the "Source Index" to utilize in the command below
dism /Get-WimInfo /WimFile:install.esd

# Extract .WIM file
dism /export-image /SourceImageFile:install.esd /SourceIndex:4 /DestinationImageFile:install.wim /Compress:max /CheckIntegrity