net stop spooler
del %systemroot%\system32\spool\printers\*.shd
del %systemroot%\system32\spool\printers\*.spl
net start spooler