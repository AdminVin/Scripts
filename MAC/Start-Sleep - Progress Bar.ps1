#region Progress Bar - Time Left (Seconds)
# Set line 3 $Time for the amount needed in seconds.
[int]$Time = 300
$Lenght = $Time / 100
For ($Time; $Time -gt 0; $Time--) {
$min = [int](([string]($Time/60)).split('.')[0])
$text = " " + $min + " minutes " + ($Time % 60) + " seconds left"
Write-Progress -Activity "Watiting for..." -Status $Text -PercentComplete ($Time / $Lenght)
Start-Sleep 1
}
#endregion
