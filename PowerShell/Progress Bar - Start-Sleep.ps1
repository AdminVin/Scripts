# Version 1 
[int]$Time = 10 <# Set in seconds for duration of progress bar.#>;$PBarName="Waiting For..."<# Set display label#>
$Length = $Time / 100;For ($Time; $Time -gt 0; $Time--) {$min = [int](([string]($Time/60)).split('.')[0]);$text = " " + $min + " minutes " + ($Time % 60) + " seconds left";Write-Progress -Activity $PBarName -Status $Text -PercentComplete ($Time / $Length); Start-Sleep 1;Write-Progress -Activity $PBarName -Status "Ready" -Completed}

# Version 2 (Set $num in seconds)
$num = 180;1..$num | ForEach-Object {Write-Progress -Activity "Sleeping for $num seconds" -Status "Seconds remaining: $($num-$_)" -PercentComplete ($_/$num*100);Start-Sleep 1}
Write-Progress -Activity "Sleeping for $num seconds" -Completed