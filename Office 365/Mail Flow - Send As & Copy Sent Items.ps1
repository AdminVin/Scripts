# This will create a copy of a sent message, when sending as another user or on behalf in each sent items folder.
#
# Example: 
# [User 1] has send as permissions to [User 2].  
# [User 1] sends a message AS / ON BEHALF OF [User 2] mailbox.
# Both users have the sent message, in the "Sent" folder.

# Send As Permissions
Set-Mailbox "USER2@DOMAIN.com" -MessageCopyForSentAsEnabled $True

# Send on Behalf Permissions
Set-Mailbox "USER2@DOMAIN.com" -MessageCopyForSendOnBehalfEnabled $True

# Verify
Get-Mailbox translations@ebnet.org | Select-Object MessageCopyForSendOnBehalfEnabled, MessageCopyForSentAsEnabled
