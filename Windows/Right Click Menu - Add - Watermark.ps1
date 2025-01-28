# Directory
$scriptDir = "C:\ProgramData\AV\Watermark"
if (-not (Test-Path -Path $scriptDir)) {
    New-Item -Path $scriptDir -ItemType Directory -Force
}

# Script
$scriptContent = @'
# Load the necessary .NET assembly
Add-Type -AssemblyName System.Drawing

# Function to resize and add stretched watermark text with more transparency
function Resize-AndAddWatermark {
    param (
        [string]$imagePath
    )

    # Load image
    $image = [System.Drawing.Image]::FromFile($imagePath)

    # Resize image
    $newWidth = 800
    $newHeight = 600
    $resizedImage = New-Object System.Drawing.Bitmap $image, $newWidth, $newHeight

    # Create graphics object
    $graphics = [System.Drawing.Graphics]::FromImage($resizedImage)
    $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $graphics.Clear([System.Drawing.Color]::White)

    # Draw the image onto the resized image
    $graphics.DrawImage($image, 0, 0, $newWidth, $newHeight)

    # Set watermark text properties with more transparency
    $font = New-Object System.Drawing.Font("Arial", 120, [System.Drawing.FontStyle]::Bold)
    # Alpha value set to 50 for more transparency
    $brush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(50, 255, 255, 255)) # More transparent white

    # Draw main centered watermark text
    $mainText = "PREVIEW"
    $textWidth = $graphics.MeasureString($mainText, $font).Width
    $textHeight = $graphics.MeasureString($mainText, $font).Height
    $centerX = ($newWidth - $textWidth) / 2
    $centerY = ($newHeight - $textHeight) / 2
    $graphics.DrawString($mainText, $font, $brush, $centerX, $centerY)

    # Distorted and tiled watermark text
    $tileWidth = 200
    $tileHeight = 100
    $distortedBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(30, 255, 255, 255)) # Lighter transparency

    for ($y = 0; $y -lt $newHeight; $y += $tileHeight) {
        for ($x = 0; $x -lt $newWidth; $x += $tileWidth) {
            # Apply slight distortion: random rotation and scaling
            $angle = (Get-Random -Minimum -15 -Maximum 15) # Random angle between -15 and 15 degrees
            $scale = (Get-Random -Minimum 0.8 -Maximum 1.2) # Random scale between 0.8 and 1.2

            # Create a transformation matrix for rotation and scaling
            $matrix = New-Object System.Drawing.Drawing2D.Matrix
            $matrix.RotateAt($angle, [System.Drawing.PointF]::new($x + $tileWidth / 2, $y + $tileHeight / 2))
            $matrix.Scale($scale, $scale)

            # Apply the transformation
            $graphics.Transform = $matrix
            $graphics.DrawString($mainText, $font, $distortedBrush, $x, $y)
            $graphics.ResetTransform()
        }
    }

    # Get the directory path from the original image
    $directory = [System.IO.Path]::GetDirectoryName($imagePath)
    # Get the file name without extension
    $fileName = [System.IO.Path]::GetFileNameWithoutExtension($imagePath)
    # Output image path with the correct name
    $outputPath = Join-Path -Path $directory -ChildPath ("$fileName`_resized.jpg")

    # Check if the file exists, if so, modify the name
    $counter = 1
    while (Test-Path $outputPath) {
        $outputPath = Join-Path -Path $directory -ChildPath ("$fileName`_resized($counter).jpg")
        $counter++
    }

    # Save the output image
    $resizedImage.Save($outputPath, [System.Drawing.Imaging.ImageFormat]::Jpeg)

    # Clean up
    $graphics.Dispose()
    $resizedImage.Dispose()
    $image.Dispose()
}

# Example usage with input file path
Resize-AndAddWatermark -imagePath $args[0]
'@

$scriptPath = Join-Path -Path $scriptDir -ChildPath "ResizeAndAddWatermark.ps1"
$scriptContent | Out-File -FilePath $scriptPath -Force

# Registry
$regPathJPG = "HKCU:\Software\Classes\SystemFileAssociations\.jpg\shell\AddWatermark"
$regPathPNG = "HKCU:\Software\Classes\SystemFileAssociations\.png\shell\AddWatermark"

$regKeys = @($regPathJPG, $regPathPNG)

foreach ($key in $regKeys) {
    if (-not (Test-Path $key)) {
        New-Item -Path $key -Force
    }

    Set-ItemProperty -Path $key -Name "(Default)" -Value "Add Watermark"

    $commandKeyPath = "$key\command"
    if (-not (Test-Path $commandKeyPath)) {
        New-Item -Path $commandKeyPath -Force
    }

    Set-ItemProperty -Path $commandKeyPath -Name "(Default)" -Value "powershell.exe -ExecutionPolicy Bypass -File `"$scriptPath`" `"%1`"" 
    Set-ItemProperty -Path $key -Name "Icon" -Value "shell32.dll,43"
}

# Explorer - Restart to apply changes
Stop-Process -Name explorer -Force
Start-Process explorer