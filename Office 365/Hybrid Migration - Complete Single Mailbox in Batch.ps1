$User = "user@DOMAIN.com"
Get-MoveRequest -Identity $User | Set-MoveRequest -SuspendWhenReadyToComplete:$false -preventCompletion:$false -CompleteAfter 5
Get-MoveRequest -Identity $User | Resume-MoveRequest
Get-MoveRequest -Identity $User