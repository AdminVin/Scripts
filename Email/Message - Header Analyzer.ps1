# PowerShell Version Check
if ($PSVersionTable.PSVersion.Major -lt 7) {
    Write-Host "Script requires PowerShell 7 or later. Please upgrade and try again." -ForegroundColor Red
    exit
}

# Internal Domain
$InternalDomain = "ebnet.org"

# GUI 
Add-Type -AssemblyName System.Windows.Forms
$greenCheck = [char]::ConvertFromUtf32(0x2705)
$redCross = [char]::ConvertFromUtf32(0x274C)

$form = New-Object System.Windows.Forms.Form
$form.Text = "Email Header Analyzer"
$form.Size = New-Object System.Drawing.Size(600, 500)
$form.StartPosition = "CenterScreen"

$lblInternalDomain = New-Object System.Windows.Forms.Label
$lblInternalDomain.Text = "Internal Domain:"
$lblInternalDomain.Location = New-Object System.Drawing.Point(10, 10)
$lblInternalDomain.AutoSize = $true
$form.Controls.Add($lblInternalDomain)

$txtInternalDomain = New-Object System.Windows.Forms.TextBox
$txtInternalDomain.Size = New-Object System.Drawing.Size(150, 20)
$txtInternalDomain.Location = New-Object System.Drawing.Point(120, 10)
$txtInternalDomain.Text = $InternalDomain
$form.Controls.Add($txtInternalDomain)

$lblMessageDetails = New-Object System.Windows.Forms.Label
$lblMessageDetails.Text = "Message Details:"
$lblMessageDetails.Location = New-Object System.Drawing.Point(10, 40)
$lblMessageDetails.AutoSize = $true
$form.Controls.Add($lblMessageDetails)

$txtHeaders = New-Object System.Windows.Forms.TextBox
$txtHeaders.Multiline = $true
$txtHeaders.ScrollBars = "Vertical"
$txtHeaders.Size = New-Object System.Drawing.Size(560, 150)
$txtHeaders.Location = New-Object System.Drawing.Point(10, 60)
$form.Controls.Add($txtHeaders)

$labels = @("Sender IP", "SPF", "DKIM", "DMARC", "O365 Classification", "Message Source")
$textboxes = @{}
$emojiLabels = @{}

$yPos = 230
foreach ($label in $labels) {
    $lbl = New-Object System.Windows.Forms.Label
    $lbl.Text = "${label}:"
    $lbl.Location = New-Object System.Drawing.Point(10, $yPos)
    $lbl.AutoSize = $true
    $form.Controls.Add($lbl)

    $txt = New-Object System.Windows.Forms.TextBox
    $txt.Size = New-Object System.Drawing.Size(150, 20)
    $txt.Location = New-Object System.Drawing.Point(120, $yPos)
    $txt.ReadOnly = $true
    $form.Controls.Add($txt)
    $textboxes[$label] = $txt

    if ($label -in @("SPF", "DKIM", "DMARC")) {
        $emojiLbl = New-Object System.Windows.Forms.Label
        $emojiLbl.Location = New-Object System.Drawing.Point(280, $yPos)
        $emojiLbl.AutoSize = $true
        $emojiLbl.Font = New-Object System.Drawing.Font("Segoe UI Emoji", 10)
        $form.Controls.Add($emojiLbl)
        $emojiLabels[$label] = $emojiLbl
    }

    $yPos += 30
}

$lblSpacing = New-Object System.Windows.Forms.Label
$lblSpacing.Text = ""
$lblSpacing.Location = New-Object System.Drawing.Point(10, 400)
$lblSpacing.AutoSize = $true
$form.Controls.Add($lblSpacing)

$form.Add_Shown({ $txtHeaders.Focus() })

function Get-ExternalSenderIP {
    param ($headers)

    $matches = [regex]::Matches($headers, "Received: from \[?([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+)\]?.*")
    $ipList = $matches.Groups[1].Value | Where-Object { $_ -ne "127.0.0.1" }

    return if ($ipList) { $ipList[0] } else { "Not found" }
}


function Get-Headers {
    $headers = $txtHeaders.Text
    if ([string]::IsNullOrWhiteSpace($headers)) { return }

    $textboxes["Sender IP"].Text = Get-ExternalSenderIP $headers

    $spfStatus = if ($headers -match "spf=(pass|fail|softfail|neutral)") { $matches[1] } else { "Unknown" }
    $dkimStatus = if ($headers -match "dkim=(pass|fail|none)") { $matches[1] } else { "Unknown" }
    $dmarcStatus = if ($spfStatus -eq "pass" -and $dkimStatus -eq "pass") { "Compliant" } else { "Non-Compliant" }

    $textboxes["SPF"].Text = $spfStatus
    $textboxes["DKIM"].Text = $dkimStatus
    $textboxes["DMARC"].Text = $dmarcStatus

    $emojiLabels["SPF"].Text = if ($spfStatus -eq "pass") { " $greenCheck" } else { " $redCross" }
    $emojiLabels["DKIM"].Text = if ($dkimStatus -eq "pass") { " $greenCheck" } else { " $redCross" }
    $emojiLabels["DMARC"].Text = if ($dmarcStatus -eq "Compliant") { " $greenCheck" } else { " $redCross" }

    $classification = "External"
    if ($headers -match "X-MS-Exchange-Organization-AuthAs:\s*(\w+)") {
        switch ($matches[1]) {
            "Internal" { $classification = "Internal" }
            "Partner" { $classification = "Internal (Partner)" }
            "Anonymous" { $classification = "External" }
            "Authenticated" { $classification = "External" }
        }
    }
    $textboxes["O365 Classification"].Text = $classification
    $textboxes["Message Source"].Text = $classification
}

$btnAnalyze = New-Object System.Windows.Forms.Button
$btnAnalyze.Text = "Analyze"
$btnAnalyze.Location = New-Object System.Drawing.Point(10, 420)
$btnAnalyze.Add_Click({ Get-Headers })
$form.Controls.Add($btnAnalyze)

$btnReset = New-Object System.Windows.Forms.Button
$btnReset.Text = "Reset"
$btnReset.Location = New-Object System.Drawing.Point(100, 420)
$btnReset.Add_Click({
    $txtHeaders.Text = ""
    foreach ($key in $textboxes.Keys) { $textboxes[$key].Text = "" }
    foreach ($key in $emojiLabels.Keys) { $emojiLabels[$key].Text = "" }
})
$form.Controls.Add($btnReset)

$txtInternalDomain.Add_TextChanged({
    $script:InternalDomain = $txtInternalDomain.Text
})

$txtHeaders.Add_KeyDown({
    param ($sender, $e)
    if ($e.KeyCode -eq "Enter") {
        Get-Headers
        $e.SuppressKeyPress = $true
    }
})

$txtHeaders.Add_TextChanged({
    if (-not [string]::IsNullOrWhiteSpace($txtHeaders.Text)) {
        Start-Sleep -Milliseconds 1000
        Get-Headers
    }
})

$form.ShowDialog()
