# Source: https://derflounder.wordpress.com/2016/02/29/using-pmset-on-os-x-to-schedule-restarting-your-mac/

# Set schedule for weekly reboot on SUNDAY at 5 AM
pmset repeat restart U 05:00:00

# Set schedule for weekly reboot DAILY at 5 AM
pmset repeat restart MTWRFSU 05:00:00

# Examples
#The various types documented in pmset’s man page are as follows:

# sleep – puts the Mac to sleep
# wake – wakes the Mac from sleep
# poweron – starts up the Mac if the Mac is powered off
# shutdown – shuts down the Mac
# wakeorpoweron – depending on if the Mac is off or asleep, the Mac will wake or start up as needed

#The weekday options are as follows:

# M = Monday
# T = Tuesday
# W = Wednesday
# R = Thursday
# F = Friday
# S = Saturday
# U = Sunday

# View existing schedule
pmset -g shed

# Cancel all reboot schedule
sudo pmset repeat cancel