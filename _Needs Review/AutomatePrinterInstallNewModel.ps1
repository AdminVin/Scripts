#Confirm Racadm installed
#progress bar variables and functions
$Activity = "Setup Printers"
$Id = 1
$TotalSteps = 8

Function ShowProgressBar {
    Write-Progress -Id $Id -Activity $Activity -Status ("Step $Step of $TotalSteps | $Task") -PercentComplete ($Step / $TotalSteps * 100)
}


$Task = "Importing CSV and setting Variables"
$Step = 1
ShowProgressBar

$PrinterImport = Import-Csv -Path ".\Printers.csv"
#Variables


$Sitename = ([System.DirectoryServices.ActiveDirectory.ActiveDirectorySite]::GetComputerSite().Name)
$ServerName = $env:COMPUTERNAME
$DomainName = (Get-WmiObject Win32_ComputerSystem).Domain
$domain = ((Get-WmiObject Win32_ComputerSystem).Domain).split('.')[0]
$SiteNameLookup = @{}
Get-ADOrganizationalUnit -SearchBase "OU=ParentCompany,DC=$domain,DC=local" -SearchScope OneLevel -Filter * | ForEach-Object { $SiteNameLookup[$_.Name.Replace(' ', '')] = $_.DistinguishedName }
$SitenameWithSpace = ($SiteNameLookup[$Sitename].Split('=')[1]).Split(',')[0]
$CurrentServerIP = (Get-NetIPAddress -InterfaceAlias EthernetTeam -AddressFamily Ipv4).IPAddress
$ClientIPSubnet = $CurrentServerIP.Split('.')[-3]
$SiteSubnet = $CurrentServerIP.Split('.')[-2]
$FullSubnetIP = "10.$ClientIPSubnet.$SiteSubnet.0"
#Grab a list of installed Drivers

$PrinterIndex = 0

$Task = "Test to see if there is a printer GPO for this site"
$Step = 2
ShowProgressBar
#Check if there is a printer GPO setup for this site
try {
    Get-GPO -Name "[C] Printers ($SitenameWithSpace)" -ErrorAction Stop
}
catch {
    Write-Warning "i Cannot find the GPO - [C] Printers ($SitenameWithSpace) Please create the printer gpo first and then run me again"
    Start-Sleep -Seconds 20
    Exit
}




foreach ($Printer in $PrinterImport) {   
    $PrinterDriverOveride = $Printer.PrinterDriverOverRide 
    $PrinterMacAddress = $Printer.Mac
    $PrinterMake = $Printer.Make
    $PrinterModel = $Printer.Model
    $PrinterLocation = $Printer.Location
    $PrinterIP = $Printer.NewIP
    $PRName = $Printer.PRNumber
    $DNSRecord = "$PRName.$Sitename.printers"
    $DNSFullRecord = "$PRName.$Sitename.printers.$DomainName"

    #set a variable that merges the fileds together to create the name of the printer
    $NewPrinterName = ($SitenameWithSpace + " - " + $PrName + " - " + $PrinterLocation)
   
    #Check to see if the printer name is in USE
    $TestPrinterName = (Get-Printer | Where-Object Name -eq $NewPrinterName).Name

    $Task = "Testing to see if $NewPrinterName is already in print server"
    $Step = 3
    ShowProgressBar 

    if ($TestPrinterName -eq $NewPrinterName) {
        Write-Warning "Printer $NewPrinterName is already installled skipping printer"
        #go to next in loop  
        Continue
    } 
    #check if there is a DNS records and PORT (if there isnt create one)
    $Task = "Testing to see if there is already a dns record for this printer"
    $Step = 4
    ShowProgressBar 
    try {
        $record = Get-DnsServerResourceRecord -ZoneName $DomainName -RRType "A" -Name $DNSRecord -ComputerName $ServerName -ErrorAction Stop
    }
    catch {
        Add-DnsServerResourceRecordA -ZoneName $DomainName -Name $DNSRecord -IPv4Address $PrinterIP -CreatePtr -ComputerName $ServerName
        $record = Get-DnsServerResourceRecord -ZoneName $DomainName -RRType "A" -Name $DNSRecord -ComputerName $ServerName 
    }

    if ($record.RecordData.IPv4Address.IPAddressToString -ne $PrinterIP) {
        do {
            $confirmation = Read-Host "DNS record $DNSRecord already exists with IP$($Record.RecordData.IPv4Address.IPAddressToString). Do you want to overwrite (y/n)?"
        } while ($confirmation -notmatch '(y|n)');

        if ($confirmation -eq 'n') {
            Write-Host "Ok we will skip making the printer $NewPrinterName on to the next:"
            continue
        }
             
        $UpdatedDNSRecord = Get-DnsServerResourceRecord -Name $DNSRecord -ZoneName $DomainName -RRType "A"
        $OldDNSRecord = Get-DnsServerResourceRecord -Name $DNSRecord -ZoneName $DomainName -RRType "A"
        $UpdatedDNSRecord.recorddata.ipv4address = [System.Net.IPAddress]::parse($PrinterIP)
        Set-DnsServerResourceRecord -NewInputObjec $UpdatedDNSRecord -OldInputObject $OldDNSRecord -ZoneName $DomainName -ComputerName $ServerName 
    }


    $Task = "Testing to see if there is already a Printer Port for this printer"
    $Step = 5
    ShowProgressBar 

    #Check for Printer Port
    $FindPrinterPort = Get-PrinterPort | Where-Object Name -like $DNSFullRecord
    if ($null -eq $FindPrinterPort) {
        Write-Output "Printer Port $DNSFullRecord Doesnt Exsist so we are going to create one"
        Add-PrinterPort -Name ($DNSFullRecord) -PrinterHostAddress ($DNSFullRecord)
        
    }
    
    #Check for Reservation and if not there create it
    $Task = "Checking to see if there is a reservation for this printer already"
    $Step = 6
    ShowProgressBar 
    $FindPrinterReservation = Get-DhcpServerv4Reservation -ScopeId $FullSubnetIP | Where-Object IPAddress -Like $PrinterIP


    if ($null -eq $FindPrinterReservation) {
        Write-Host "Great there is no reservation there yet so we are going to make one"
        Add-DhcpServerv4Reservation -ScopeId $FullSubnetIP -IPAddress $PrinterIP -ClientId $PrinterMacAddress -Name $NewPrinterName -Description "This is Reserved for $NewPrinterName"
    }
    else {
        Write-Host "There is a reservation with that IP already lets check to see if this has the same mac address as the one we would like to put in"
        if ($PrinterMacAddress -ne $FindPrinterReservation.ClientId) {
            do {
                $confirmation = Read-Host "The IP you want to set this printer to is assinged to MAC Address $($FindPrinterReservation.ClientId). Do you want to overwrite (y/n)?"
            } while ($confirmation -notmatch '(y|n)')

            if ($confirmation -eq 'n') {
                Write-Warning "Ok we will skip making the printer $NewPrinterName on to the next:"
                continue
            }
            Set-DhcpServerv4Reservation -IPAddress $PrinterIP -Description "Resvered For $NewPrinterName" -ClientId $PrinterMacAddress -Name $NewPrinterName
        
        }
    }
    
   
    $Task = "Checking to see if Driver overide was used"
    $Step = 7
    ShowProgressBar 

    #Check to see if Driver Overide is selected
    if ($null -eq $PrinterDriverOveride) {
        $InstalledDriverList = (Get-PrinterDriver | Where-Object Manufacturer -ne "Microsoft")
        $Task = "Driver overide was not slected we are going to try and find a driver to use for this printer"
        $Step = 8
        ShowProgressBar 
        #Try and Fine a Driver Based on the Manufacture
        $ManufactureDrivers = ($InstalledDriverList | Where-Object Manufacturer -Like "$PrinterMake")
        $driverSelected = $null

        do {($driverSelected = $ManufactureDrivers | Out-GridView -OutputMode single -title "Please Select a Driver for Printer $NewPrinterName")   
        } while ($null -eq $driverSelected)
       


        #if i cant find Manufacture im going to while and wait till a driver gets installed for it or i can allow an ESC and skip
    }
    else {
        $Task = "Driver overide was selected lets try and see if we can find that driver in the print server"
        $Step = 8
        ShowProgressBar 
        $TestPrintDriver = (Get-PrinterDriver |Where-Object Name -eq $PrinterDriverOveride).Name
         
        if ($null -eq $TestPrintDriver) {
            do {
                $confirm = Read-Host "The Printer Driver $PrinterDriverOveride is not in the Print Server Do you want us to wait for you to install (y/n) (if you choose no we will skip the printer installation)"  
            } while ($confirmation -notmatch '(y|n)')

            if ($confirm -eq "y") {
                do {
                    $ready = Read-Host"Enter 'y' once the new driver is installed and Enter 'skip' if you chnaged your mind and want to skip this printer"
                    $TestPrintDriver = (Get-PrinterDriver |Where-Object Name -eq $PrinterDriverOveride).Name
                } until ($null -ne $TestPrintDriver -or $ready -match "skip")
                if ($Ready -match "skip") {
                    Write-Warning "Skipping Printer $NewPrinterName"
                    continue
                }


                else {
                    Write-Warning "Skipping Printer $NewPrinterName"
                    continue
                }

            }   

            
        }
        else {
            Add-Printer -Name $NewPrinterName -DriverName $PrinterDriverOveride -PortName $DNSFullRecord -Location $PrinterLocation
        }

        

    }

}

#Display an output of the status of each one
#$PrintDrivers = Get-PrinterDriver | Where-Object Name -Like "*Kyocera*"



