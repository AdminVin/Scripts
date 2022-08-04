:: Windows Update Cleanup
net stop wuauserv
ren %systemroot%\SoftwareDistribution SoftwareDistribution.old
net start wuauserv
rd /s/q %systemroot%\SoftwareDistribution.old
:: Temp/Other/Misc
Cleanmgr.exe /sageset:11
exit

net stop wuauserv
rmdir c:\windows\softwaredistribution /s /q
net start wuauserv
rmdir c:\windows\installer\$patchcache$\managed /s /q
del c:\windows\temp\* /s /q
del c:\windows\serviceprofiles\localservice\appdata\local\fontcache*.dat
del c:\programdata\adobe\arm\* /s /q
del C:\Windows\LTSVC\packages\MP\Ninite\NiniteDownloads\files\* /s /q
del C:\ProgramData\Microsoft\Windows\WER\ReportQueue\* /s /q
del C:\Users\%USERPROFILE%\AppData\Local\Microsoft\Windows\WER\ReportQueue\* /s /q