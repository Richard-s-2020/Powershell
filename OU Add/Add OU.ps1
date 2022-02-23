cd C:\Users\Administrator\Desktop\Ou
Import-Module ActiveDirectory

$Adou = Import-Csv -Path .\ou.csv -Delimiter ";"

foreach($OU in $Adou)
{
$Name = $OU.Name
$path = $OU.Path


$ProtectedFromAccidentalDeletion = 0
Write-Host $Path


if ([ADSI]::Exists("LDAP://ou=$Name,$path")) {
Write-Host "OU Exists in AD"
}
else {
    
New-ADOrganizationalUnit -Name $Name -Path $path -ProtectedFromAccidentalDeletion $ProtectedFromAccidentalDeletion 
Write-Host "ou will be added to AD"
}
}
Get-ADOrganizationalUnit -Properties CanonicalName -Filter * | Sort-Object canonicalName | Format-Table CanonicalName, DistinguishedName
 