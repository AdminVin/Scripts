#################################################################################################################
#
# Version 1.4 February 2016
# Robert Pearman (WSSMB MVP)
# TitleRequired.com
# Script to Automated Email Reminders when Users Passwords due to Expire.
#
# Requires: Windows PowerShell Module for Active Directory
#
# For assistance and ideas, visit the TechNet Gallery Q&A Page. http://gallery.technet.microsoft.com/Password-Expiry-Email-177c3e27/view/Discussions#content
# Or Checkout my Youtube Channel - https://www.youtube.com/user/robtitlerequired
#
##################################################################################################################
# Please Configure the following variables....
$smtpServer="X.mail.protection.outlook.com"
$expireindays = 1
$from = "admin@COMPANY.com"
$logging = "Enabled" # Set to Disabled to Disable Logging
$logFile = "C:\ProgramData\PasswordExpirationEmail\Logs\Log.csv" # ie. c:\mylog.csv
$testing = "Enabled" # Set to Disabled to Email Users
$testRecipient = "test@gmail.com"
#
###################################################################################################################

# Check Logging Settings
if (($logging) -eq "Enabled")
{
    # Test Log File Path
    $logfilePath = (Test-Path $logFile)
    if (($logFilePath) -ne "True")
    {
        # Create CSV File and Headers
        New-Item $logfile -ItemType File
        Add-Content $logfile "Date,Name,EmailAddress,DaystoExpire,ExpiresOn,Notified"
    }
} # End Logging Check

# System Settings
$textEncoding = [System.Text.Encoding]::UTF8
$date = Get-Date -format ddMMyyyy
# End System Settings

# Get Users From AD who are Enabled, Passwords Expire and are Not Currently Expired
Import-Module ActiveDirectory
$users = get-aduser -filter * -properties Name, PasswordNeverExpires, PasswordExpired, PasswordLastSet, EmailAddress |where {$_.Enabled -eq "True"} | where { $_.PasswordNeverExpires -eq $false } | where { $_.passwordexpired -eq $false }
$DefaultmaxPasswordAge = (Get-ADDefaultDomainPasswordPolicy).MaxPasswordAge

# Process Each User for Password Expiry
foreach ($user in $users)
{
    $Name = $user.Name
    $emailaddress = $user.emailaddress
    $passwordSetDate = $user.PasswordLastSet
    $PasswordPol = (Get-AduserResultantPasswordPolicy $user)
    $sent = "" # Reset Sent Flag
    # Check for Fine Grained Password
    if (($PasswordPol) -ne $null)
    {
        $maxPasswordAge = ($PasswordPol).MaxPasswordAge
    }
    else
    {
        # No FGP set to Domain Default
        $maxPasswordAge = $DefaultmaxPasswordAge
    }


    $expireson = $passwordsetdate + $maxPasswordAge
    $today = (get-date)
    $daystoexpire = (New-TimeSpan -Start $today -End $Expireson).Days

    # Set Greeting based on Number of Days to Expiry.

    # Check Number of Days to Expiry
    $messageDays = $daystoexpire

    if (($messageDays) -gt "1")
    {
        $messageDays = "in " + "$daystoexpire" + " days."
    }
    else
    {
        $messageDays = "today."
    }

    # Email Subject Set Here
    $subject="Your password will expire $messageDays"

    # Email Body Set Here, Note You can use HTML, including Images.
    $body ="
    Hello!<BR>
    <p> Your password will expire in $messageDays<br><br>
    To change your password on your computer: Hold <b>CTRL</b> + <b>ALT</b> and then press <b>Delete</b> and choose <i>Change Password</i>. <br>
    <p>Thank you.<br>
	<br><br>
	This mailbox is not monitored.<br>
	If you need assistance, please send an email to support@tech-keys.com or you can reach us at 732-730-7000.
    </P>"


    # If Testing Is Enabled - Email Administrator
    if (($testing) -eq "Enabled")
    {
        $emailaddress = $testRecipient
    } # End Testing

    # If a user has no email address listed
    if (($emailaddress) -eq $null)
    {
        $emailaddress = $testRecipient
    }# End No Valid Email

    # Send Email Message
    if (($daystoexpire -ge "0") -and ($daystoexpire -lt $expireindays))
    {
        $sent = "Yes"
        # If Logging is Enabled Log Details
        if (($logging) -eq "Enabled")
        {
            Add-Content $logfile "$date,$Name,$emailaddress,$daystoExpire,$expireson,$sent"
        }
        # Send Email Message
        Send-Mailmessage -smtpServer $smtpServer -from $from -to $emailaddress -subject $subject -body $body -bodyasHTML -priority High -Encoding $textEncoding

    } # End Send Message
    else # Log Non Expiring Password
    {
        $sent = "No"
        # If Logging is Enabled Log Details
        if (($logging) -eq "Enabled")
        {
            Add-Content $logfile "$date,$Name,$emailaddress,$daystoExpire,$expireson,$sent"
        }
    }

} # End User Processing



# End