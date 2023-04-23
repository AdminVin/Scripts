$apiUserID = "xxxxxxxxx"
$apiPassword = "xxxxxxxxx"
$SecurePassword = ConvertTo-SecureString -String $apiPassword -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential $apiUserID, $SecurePassword
$WebRequestURI = "https://domains.google.com/nic/update"
$params = @{}
$params.Add("hostname","domain.com")
$Response = Invoke-WebRequest -uri $WebRequestURI -Method Post -Body $params -Credential $Credential
$ResponseCode = $Response.StatusCode
$Result = $Response.Content
$Date = Get-Date -Format g
# To Enable Logging, Uncomment the line below
# Add-Content "D:\record.txt" "$Date : $ResponseCode : $Result"