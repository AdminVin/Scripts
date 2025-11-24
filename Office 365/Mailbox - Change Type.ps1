# Regular (license needed and able to be logged onto)
Set-Mailbox -Identity ActiveUser@DOMAIN.com -Type Regular

# Shared (license needed and able to be logged onto)
Set-Mailbox -Identity DepartmentName@DOMAIN.com -Type Shared

# Room Mailbox (no license needed and no login capabilities)
Set-Mailbox -Identity ConferenceRoom@DOMAIN.com -Type Room

# Equipment Mailbox (no license needed and no login capabilities)
Set-Mailbox -Identity Equipment@DOMAIN.com -Type Room


