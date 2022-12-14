##########################################
### WORK IN PROGRESS (Not Working ATM) ###
##########################################

# Convert Microsoft Word .DOC files to .DOCX
#
# If you need to save the .DOC file to .PDF modify line 15 to this
# $document.SaveAs([ref] $docx_filename, [ref]17)
#
# Set Path of Existing Documents
$path = "C:\Test EXCEL Files" 
$excel_app = New-Object -ComObject excel.application

Add-Type -AssemblyName Microsoft.Office.Interop.Excel
$Format = [Microsoft.Office.Interop.Excel.XlFileFormat]::xlOpenXMLWorkbook

Get-ChildItem -Path $path -Filter *.xls | ForEach-Object {
    $document = $excel_app.Documents.Open($_.FullName)
    $xlxs_filename = "$($_.DirectoryName)\$($_.BaseName).xlxs"
    $document.SaveAs([ref] $xlxs_filename, [ref]$Format)
    $document.Close()
}
$excel_app.Quit()

# Remove .XLS Files after conversion
#Remove-Item $path\*.XLS