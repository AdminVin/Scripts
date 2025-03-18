Add-Type -AssemblyName System.Windows.Forms

# Create the form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Email Header Analyzer"
$form.Size = New-Object System.Drawing.Size(600, 400)
$form.StartPosition = "CenterScreen"

# Textbox for message headers
$txtHeaders = New-Object System.Windows.Forms.TextBox
$txtHeaders.Multiline = $true
$txtHeaders.ScrollBars = "Vertical"
$txtHeaders.Size = New-Object System.Drawing.Size(560, 150)
$txtHeaders.Location = New-Object System.Drawing.Point(10, 10)
$form.Controls.Add($txtHeaders)

# Labels
$lblIP = New-Object System.Windows.Forms.Label
$lblIP.Text = "Sender IP:"
$lblIP.Location = New-Object System.Drawing.Point(10, 170)
$lblIP.AutoSize = $true
$form.Controls.Add($lblIP)

$txtIP = New-Object System.Windows.Forms.TextBox
$txtIP.Size = New-Object System.Drawing.Size(150, 20)
$txtIP.Location = New-Object System.Drawing.Point(100, 170)
$txtIP.ReadOnly = $true
$form.Controls.Add($txtIP)

$lblSPF = New-Object System.Windows.Forms.Label
$lblSPF.Text = "SPF:"
$lblSPF.Location = New-Object System.Drawing.Point(10, 200)
$lblSPF.AutoSize = $true
$form.Controls.Add($lblSPF)

$txtSPF = New-Object System.Windows.Forms.TextBox
$txtSPF.Size = New-Object System.Drawing.Size(150, 20)
$txtSPF.Location = New-Object System.Drawing.Point(100, 200)
$txtSPF.ReadOnly = $true
$form.Controls.Add($txtSPF)

$lblDKIM = New-Object System.Windows.Forms.Label
$lblDKIM.Text = "DKIM:"
$lblDKIM.Location = New-Object System.Drawing.Point(10, 230)
$lblDKIM.AutoSize = $true
$form.Controls.Add($lblDKIM)

$txtDKIM = New-Object System.Windows.Forms.TextBox
$txtDKIM.Size = New-Object System.Drawing.Size(150, 20)
$txtDKIM.Location = New-Object System.Drawing.Point(100, 230)
$txtDKIM.ReadOnly = $true
$form.Controls.Add($txtDKIM)

$lblDMARC = New-Object System.Windows.Forms.Label
$lblDMARC.Text = "DMARC:"
$lblDMARC.Location = New-Object System.Drawing.Point(10, 260)
$lblDMARC.AutoSize = $true
$form.Controls.Add($lblDMARC)

$txtDMARC = New-Object System.Windows.Forms.TextBox
$txtDMARC.Size = New-Object System.Drawing.Size(150, 20)
$txtDMARC.Location = New-Object System.Drawing.Point(100, 260)
$txtDMARC.ReadOnly = $true
$form.Controls.Add($txtDMARC)

# Analyze button
$btnAnalyze = New-Object System.Windows.Forms.Button
$btnAnalyze.Text = "Analyze"
$btnAnalyze.Location = New-Object System.Drawing.Point(10, 300)
$btnAnalyze.Add_Click({
    $headers = $txtHeaders.Text
    $txtIP.Text = if ($headers -match "Received: from .*?\[(\d+\.\d+\.\d+\.\d+)\]") { $matches[1] } else { "Not found" }
    $txtSPF.Text = if ($headers -match "spf=(pass|fail|softfail|neutral)") { $matches[1] } else { "Unknown" }
    $txtDKIM.Text = if ($headers -match "dkim=(pass|fail|none)") { $matches[1] } else { "Unknown" }
    $txtDMARC.Text = if ($txtSPF.Text -eq "pass" -and $txtDKIM.Text -eq "pass") { "Compliant" } else { "Non-Compliant" }
})
$form.Controls.Add($btnAnalyze)

# Reset button
$btnReset = New-Object System.Windows.Forms.Button
$btnReset.Text = "Reset"
$btnReset.Location = New-Object System.Drawing.Point(100, 300)
$btnReset.Add_Click({
    $txtHeaders.Text = ""
    $txtIP.Text = ""
    $txtSPF.Text = ""
    $txtDKIM.Text = ""
    $txtDMARC.Text = ""
})
$form.Controls.Add($btnReset)

# Show the form
$form.ShowDialog()
