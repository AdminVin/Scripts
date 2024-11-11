<# Notes
The Windows Print Spooler service uses a high dynamic TCP port range including ports 49152 through 65535. When these ports are blocked, you may notice delays around 45 seconds when connecting to a shared print queue on the server or when submitting a print job, or when PaperCut redirects a print job from one Windows print server to another (called Cross-server redirection).

This happens because it takes this amount of time before the client fails to connect, and reverts to the range of ports used by Windows Server 2003 (445 and 139).

To confirm, you can open an elevated command prompt window on your Print Server and run netstat -b -n to show which ports the spooler is using. If spoolsv.exe is using 445 and 139, instead of randomly assigned ports 49152 through 65535, then you have found your problem.

The solution is to make sure that ports 49152–65535 are whitelisted on any firewalls between the clients and print server. You may also need to restart the Windows Print Spooler service for the change to take effect.
#>

netsh advfirewall firewall add rule name="Print Server - 49152-65535 (TCP)" protocol=TCP dir=in localport=49152-65535 action=allow profile=private,domain
netsh advfirewall firewall add rule name="Print Server - 49152-65535 (UDP)" protocol=UDP dir=in localport=49152-65535 action=allow profile=private,domain