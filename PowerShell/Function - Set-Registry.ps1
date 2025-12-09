function Set-Registry {
    param (
        [string]$Path,
        [string]$Name,
        [Parameter(ValueFromPipeline = $true)]
        [Object]$Value,
        [ValidateSet('String','ExpandString','Binary','DWord','MultiString','QWord')]
        [string]$Type,
        [ValidateSet('Path','Value')]
        [string]$Remove
    )
    # Removal Check
    if ($Remove -eq 'Path') {
        if (Test-Path $Path) {
            Remove-Item -Path $Path -Recurse -Force -ErrorAction SilentlyContinue
        }
        return
    }
    if ($Remove -eq 'Value') {
        if (Test-Path $Path) {
            if (Get-ItemProperty -Path $Path -Name $Name -ErrorAction SilentlyContinue) {
                Remove-ItemProperty -Path $Path -Name $Name -Force -ErrorAction SilentlyContinue
            }
        }
        return
    }
    # Path Check
    if (-not (Test-Path $Path)) {
        $null = New-Item -Path $Path -Force
    }
    # Item Check
    if (-not (Get-ItemProperty -Path $Path -Name $Name -ErrorAction SilentlyContinue)) {
        $null = New-ItemProperty -Path $Path -Name $Name -Value $Value -PropertyType $Type -Force
    } else {
        $null = Set-ItemProperty -Path $Path -Name $Name -Value $Value -Force
    }
}