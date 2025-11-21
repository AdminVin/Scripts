function Start-SleepProgress {
    param([int]$Num)
    1..$Num | ForEach-Object {
        Write-Progress -Activity "Sleeping for $Num seconds" -Status "Remaining:$($Num-$_)" -PercentComplete ($_/$Num*100)
        Start-Sleep 1}
    Write-Progress -Activity "Sleeping for $Num seconds" -Completed
}
<# 
Usage for a sleep of one minute:
StartSleepProgress -Num 60
#>