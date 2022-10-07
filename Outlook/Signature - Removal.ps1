# This is best applied when set to a GPO for a user logon script.

$users = Get-ChildItem c:\Users | ?{ $_.PSIsContainer }
foreach ($user in $users){
    $userpath = "C:\Users\$user\AppData\Roaming\Microsoft\"
    Try{
        Rename-Item "C:\Users\$user\AppData\Roaming\Microsoft\Signatures" "C:\Users\$user\AppData\Roaming\Microsoft\Signatures.old" -ErrorAction SilentlyContinue  
    } 
    catch {
        "$errs" | Out-File c:\OutlookSignatureErrors.txt -append
    }
}