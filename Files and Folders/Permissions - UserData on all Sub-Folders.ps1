## Notice: If you are running this on a UserData that has messed up permissions, run the "Take Ownership" script on the root first, then this one.

# Set Local Domain
$domain = "DOMAIN.local"
# Update the $folder varible to the LOCAL path 'D:\UserData\' on the server, not UNC path '\\SERVER\UserData'
# This will allow the permissions changes to apply faster.
$folder = "D:\UserData\"
$users = get-childitem $folder

Foreach ($user in $users) {
    try {
        Get-ADUser $user.Name | Out-Null
    }
    catch {
        Write-Host "Cannot find user $($User.Name) in AD"
        continue
    }
    $acl = Get-Acl $user.FullName
    $acl.SetOwner([System.Security.Principal.NTAccount]"$user")
    $MyAccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("$domain\$user", "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow")
    $acl.SetAccessRule($MyAccessRule)
    set-acl $user.FullName $acl -Verbose

    $subFolders = Get-ChildItem $user.FullName -Directory -Recurse
    Foreach ($subFolder in $subFolders) {
        $acl = Get-Acl $subFolder.FullName
        $acl.SetOwner([System.Security.Principal.NTAccount]"$user")
        $MyAccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("$domain\$user", "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow")
        $acl.SetAccessRule($MyAccessRule)
        set-acl $subFolder.FullName $acl -Verbose
    }
    
    $subFiles = Get-ChildItem $user.FullName -File -Recurse
    Foreach ($subFile in $subFiles) {
        $acl = Get-Acl $subFile.FullName
        $acl.SetOwner([System.Security.Principal.NTAccount]"$user")
        $MyAccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("$domain\$user", "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow")
        $acl.SetAccessRule($MyAccessRule)
        set-acl $subFile.FullName $acl -Verbose
    }
}