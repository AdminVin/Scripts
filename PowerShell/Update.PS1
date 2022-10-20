# Install Latest Version
# No GUI
Invoke-Expression "& { $(irm https://aka.ms/install-powershell.ps1) }"
# GUI
Invoke-Expression "& { $(irm https://aka.ms/install-powershell.ps1) } -UseMSI"

# Show current version installed
$showpstable