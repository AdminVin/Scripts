# DISM Scan (Run first to ensure all source files are valid)
dism /online /cleanup-image /restorehealth

# SFC Scan (Run second to repair any corrupted files with valid source files)
SFC /SCANNOW
