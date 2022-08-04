# Source Article: https://docs.microsoft.com/en-us/exchange/policy-and-compliance/ediscovery/create-searches?view=exchserver-2019

# 1. Create a Shared Mailbox for the data to be exported to (Admin Portal > Group > Shared Mailboxes > Add)
# 2. Grant Full Access permissions to whomever needs the data 
# 3. Connect to Office 365 via Powershell (Connect-IPPSession, and Connect-EXOPSession)
# 4. Create a new search and target it to the shared mailbox created
New-MailboxSearch "SearchName" -StartDate "01/01/2013" -EndDate "12/31/2015" -SourceMailboxes "email@DOMAIN.com" -TargetMailbox "New Shared Mailbox Created" -MessagesTypes Email -IncludeUnsearchableItems -SearchQuery "Search Term Goes Here"
# -StartDate/-EndDate / -SourceMailboxes can be omitted if you are searching everything within the Office 365 account
# 5. Start the search
Start-Mailbox "SearchName"
# You can view the status of the search by typing the above command in again