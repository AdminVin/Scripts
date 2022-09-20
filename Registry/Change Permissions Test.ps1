<#
New-PSDrive -PSProvider registry -Root HKEY_CLASSES_ROOT -Name HKCR
$acl = Get-Acl "HKCR:\AppID\{86F80216-5DD6-4F43-953B-35EF40A35AEE}"
$person = [System.Security.Principal.NTAccount]"BuiltIn\Users"          
$access = [System.Security.AccessControl.RegistryRights]"FullControl"
$inheritance = [System.Security.AccessControl.InheritanceFlags]"ContainerInherit,ObjectInherit"
$propagation = [System.Security.AccessControl.PropagationFlags]"None"
$type = [System.Security.AccessControl.AccessControlType]"Deny"
$rule = New-Object System.Security.AccessControl.RegistryAccessRule($person,$access,$inheritance,$propagation,$type)
$acl.AddAccessRule($rule)
$acl |Set-Acl
#>
New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT
$RegistryKey = "HKCR:\AppID\{86F80216-5DD6-4F43-953B-35EF40A35AEE}"
$acl = get-acl $RegistryKey