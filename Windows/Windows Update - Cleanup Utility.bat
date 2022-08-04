:: Windows Update Old File Clean Up
net stop wuauserv
ren %systemroot%\SoftwareDistribution SoftwareDistribution.old
net start wuauserv
rd /s/q %systemroot%\SoftwareDistribution.old
:: Clean Up Service Pack Files
dism /online /cleanup-image /spsuperseded /hidesp
:: Clean Up Old Componet Files
DISM.exe /online /Cleanup-Image /StartComponentCleanup
:: Clean Up Old Componet Files (Part 2)
DISM.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase
:: Temp/Other/Misc
Cleanmgr.exe /sageset:11
exit