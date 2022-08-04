if exist "C:\Software\Application\site.cfg" goto end

msiexec /i \\FS\Software\Application\Setup.msi /qn /norestart

copy "\\FS\Software\Application\site.cfg" "C:\Software\Application"

:end