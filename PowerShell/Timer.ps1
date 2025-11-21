# Start Timer
$Timer = [System.Diagnostics.Stopwatch]::StartNew()

# End Timer
$Timer.Stop()

# Display Timer
    # Full
    $Timer.Elapsed

    # Partial (Table)
    $Timer.Elapsed | Select-Object Hours, Minutes, Seconds | Format-Table

    <# Output
    Hours Minutes Seconds
    ----- ------- -------
        0       1      44
    #>

    # Partial (Inline)
    Write-Host ("Elapsed Time - {0:00}:{1:00}:{2:00}" -f $Timer.Elapsed.Hours, $Timer.Elapsed.Minutes, $Timer.Elapsed.Seconds)

    <# Output
    Elapsed Time - 00:01:40
    #>