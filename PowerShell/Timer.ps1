# Start Timer
$Timer = [System.Diagnostics.Stopwatch]::StartNew()

# End Timer
$Timer.Stop()

# Display Timer
$Timer.Elapsed

# Display Timer (Hour, Minutes, Seconds)
$Timer.Elapsed | Select-Object Hours, Minutes, Seconds | Format-Table

# Display Timer (HMS - Varible)
$TimerFinal = $Timer.Elapsed | Select-Object Hours, Minutes, Seconds | Format-Table
$TimerFinal