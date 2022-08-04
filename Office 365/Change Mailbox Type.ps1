# Connect to Office 365
# -Type Paramater should be either "Regular" for User Mailbox, "Room" for resource mailbox, "Equipment", or "Shared"

# Regular (with license and login credentials)
Get-Mailbox -Identity ActiveUser@DOMAIN.com | Set-Mailbox -Type Regular

# Room Mailbox
Get-Mailbox -Identity conferenceroom1@DOMAIN.com | Set-Mailbox -Type Room
Get-Mailbox -Identity conferenceroom2@DOMAIN.com | Set-Mailbox -Type Room
Get-Mailbox -Identity conferenceroom3@DOMAIN.com | Set-Mailbox -Type Room
Get-Mailbox -Identity conferenceroom4@DOMAIN.com | Set-Mailbox -Type Room
Get-Mailbox -Identity conferenceroom5@DOMAIN.com | Set-Mailbox -Type Room