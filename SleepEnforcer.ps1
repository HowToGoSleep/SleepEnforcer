# ====================================================================
# CONFIGURATION VARIABLES
# ====================================================================
$SleepStartTimeStr    = "21:30"   # Sleep start time (24-hour format "HH:mm")
$SleepEndTimeStr      = "05:00"   # Sleep end time (24-hour format "HH:mm")
$GracePeriodMinutes   = 10        # Minutes to wait after waking up before enforcing sleep again
$CheckIntervalSeconds = 60        # Seconds to wait between time checks outside the sleep window
# ====================================================================

# Convert the string variables into usable TimeSpan objects
$StartTime = [TimeSpan]$SleepStartTimeStr
$EndTime   = [TimeSpan]$SleepEndTimeStr

while ($true) {
    $now = Get-Date
    $CurrentTime = $now.TimeOfDay

    # Check if the sleep window spans across midnight
    if ($StartTime -gt $EndTime) {
        # e.g., 21:30 to 05:00 (Current time is AFTER 21:30 OR BEFORE 05:00)
        $isSleepTime = ($CurrentTime -ge $StartTime) -or ($CurrentTime -lt $EndTime)
    } else {
        # e.g., 01:00 to 05:00 (Current time is AFTER 01:00 AND BEFORE 05:00)
        $isSleepTime = ($CurrentTime -ge $StartTime) -and ($CurrentTime -lt $EndTime)
    }

    if ($isSleepTime) {
        # Put the computer to sleep
        Add-Type -AssemblyName System.Windows.Forms
        [System.Windows.Forms.Application]::SetSuspendState([System.Windows.Forms.PowerState]::Suspend, $false, $false)
        
        # Wait for the grace period before enforcing sleep again
        Start-Sleep -Seconds ($GracePeriodMinutes * 60)
    } else {
        # Outside of the sleep window, wait before checking the time again
        Start-Sleep -Seconds $CheckIntervalSeconds
    }
}
