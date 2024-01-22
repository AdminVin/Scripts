## This is for creating a scheduled task, and setting the action to a BAT file to run a PowerShell script.
# This file must be saved as a .BAT

# Without Logging
@echo off
Powershell.exe -ExecutionPolicy Bypass -File "\\SERVER\DIRECTORY\POWERSHELL_SCRIPT.PS1"

# With Logging
@echo off
Powershell.exe -ExecutionPolicy Bypass -File "\\SERVER\DIRECTORY\POWERSHELL_SCRIPT.PS1" >> "\\SERVER\DIRECTORY\POWERSHELL_SCRIPT - LOG.txt" 2>&1