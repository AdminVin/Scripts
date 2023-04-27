# This will create a copy of a sent message when sending as another user or on behalf in their sent items, as well as the other mailbox.
#
# Example: 
# [User 1] has send as permissions to [User 2].  
# [User 1] sends a message with the subject "Testing Sending" from [User 2] mailbox.
# Both users have the message "Testing Sending" message in their "Sent" folder.

# Send As Permissions
Set-Mailbox user@DOMAIN.com -MessageCopyForSentAsEnabled $True

# Send on Behalf Permissions
Set-Mailbox user@DOMAIN.com -MessageCopyForSendOnBehalfEnabled $True