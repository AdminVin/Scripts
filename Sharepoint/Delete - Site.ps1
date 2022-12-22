# Site - Unlock
Set-SPOSite https://yoursharepointdomain.com/sites/oldsite/ -LockState Unlock

# Permissions - Take Ownership
Set-SPOSite -Identity https://yoursharepointdomain.com/sites/oldsite/ -Owner myemailaddress@email.com -NoWait

# Site - Remove
Remove-SPOSite -Identity https://yoursharepointdomain.com/sites/oldsite/

