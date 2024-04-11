###########################################################
## Create Transport Rules in Exchange
<#
Navigate to Office 365 > Exchange > Mail Flow > Rules > Add a Rule > Create a new rule

Name: Block - Profanity (1)
Apply this rule if
    - The subject or body = subject or body matches these text patterns
        - Enter in a test keyword > Save
Do the following
    - Block the message = reject the message and include an explanation
        - specify rejection reason "This email was blocked due to profanity."

Repeat for rules "Block - Profanity (2)" and "Block - Profanity (3)"
#>

###########################################################
## Update Transport Rules with keywords from CSV
$TransportRuleName = "Block - Profanity (1)"                                        # UPDATE RULE NAME
$CSVPath = "C:\Mail Flow - Transport - Profanity - Bad Words1.csv"                  # UPDATE CSV PATH
#
$Keywords = Get-Content -Path $CSVPath
$ExistingRule = Get-TransportRule -Identity $TransportRuleName
Set-TransportRule -Identity $ExistingRule -SubjectOrBodyContainsWords $Keywords