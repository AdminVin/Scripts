# Convert Microsoft Word .DOC files to .DOCX
#
# If you need to save the .DOC file to .PDF modify line 15 to this
# $document.SaveAs([ref] $docx_filename, [ref]17)
#
# Set Path of Existing Documents
$path = "C:\Users\VINCENT\Downloads\Test DOC Files" 
$word_app = New-Object -ComObject Word.Application

$Format = [Microsoft.Office.Interop.Word.WdSaveFormat]::wdFormatXMLDocument

Get-ChildItem -Path $path -Filter *.doc | ForEach-Object {
    $document = $word_app.Documents.Open($_.FullName)
    $docx_filename = "$($_.DirectoryName)\$($_.BaseName).docx"
    $document.SaveAs([ref] $docx_filename, [ref]$Format)
    $document.Close()
}
$word_app.Quit()

# Remove .DOC Files after conversion
Remove-Item $path\*.DOC