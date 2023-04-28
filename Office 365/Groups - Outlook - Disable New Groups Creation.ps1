# Disable "New Groups" Creation from Outlook
Set-OwaMailboxPolicy -GroupCreationEnabled $false -Identity OwaMailboxPolicy-Default