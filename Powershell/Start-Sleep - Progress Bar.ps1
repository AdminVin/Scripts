#region Time Left (Seconds)
# Set 
[int]$Time = 10
$Lenght = $Time / 100
For ($Time; $Time -gt 0; $Time--) {
$min = [int](([string]($Time/60)).split('.')[0])
$text = " " + $min + " minutes " + ($Time % 60) + " seconds left"
Write-Progress -Activity "Watiting for..." -Status $Text -PercentComplete ($Time / $Lenght)
Start-Sleep 1
}
#endregion

$i = 30

do {
    Write-Host $i
    Sleep 1
    $i--
} while ($i -gt 0)

$Seconds = 10
$EndTime = [datetime]::UtcNow.AddSeconds($Seconds)

while (($TimeRemaining = ($EndTime - [datetime]::UtcNow)) -gt 0) {
  Write-Progress -Activity 'Watiting for...' -Status Godot -SecondsRemaining $TimeRemaining.TotalSeconds
  Start-Sleep 0
}


Get-ADUser vincent.briffa