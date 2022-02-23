cd C:\Users\Administrator\Desktop\persoon

#import
Import-Module ActiveDirectory

#import csv/locatie
$users = Import-Csv -Path .\Persoon.csv -Delimiter ";"

foreach ($user in $users) {

#import user gegevens en geeft die een naam
$Voorname = $user.Voornaam
$Achternaam = $user.Achternaam
$Adres = $user.Adres
$PostCode = $user.Postcode
$Stad = $user.Stad
$Telefoon = $user.Telefoonnummer
$WachtWoord = $user.Wachtwoord
$Department = $user.Afdeling
$change_PassWoord = $user.'Wachtwoord veranderen na eerste keer inloggen'
$userName = "$Voorname" + "$Achternaam"
$SamAccountN = "$Voorname_$Achternaam"
$path = " "


#path begin
$DomainName = ",OU=Pfafdelingen,DC=poliforma,DC=local"
$Array0 = "OU=Directie" + $DomainName
$Array1 = "OU=Staf" + $DomainName
$Array2 = "OU=Verkoop" + $DomainName
$Array3 = "OU=Administratie" + $DomainName
$Array4 = "OU=Productie" + $DomainName
$Array5 = "OU=Automatisering" + $DomainName
$Array6 = "OU=Fabricage,OU=Productie" + $DomainName
$Array7 = "OU=Inkoop" + $DomainName
$Array8 = "OU=Techniek" + $DomainName


$ouArray = @(`
$Array0,`
$Array1,`
$Array2,`
$Array3,`
$Array4,`
$Array5,`
$Array6` 
$Array7` 
$Array8` 
)

#ranken verdelen 
Switch ($Department) {

Directie
{
$path = $ouArray[0]
}

Staf
{
$path = $ouArray[1]
}

Verkoop
{
$path = $ouArray[2]
}

Administratie
{
$path = $ouArray[3]
}

Productie
{
$path = $ouArray[4]
}

Automatisering
{
$path = $ouArray[5]
}

Fabricage
{
$path = $ouArray[6]
}

Inkoop
{
$path = $ouArray[7]
}

Techniek
{
$path = $ouArray[8]
}

}
$userName


#account toevogen 
if (Get-ADUser -F {SamAccountName -eq $SamAccountN}) {
Write-host "A User account $voorname $Achternaam has already exist in AD" -ForegroundColor Red
Write-host "----------------------------------------------------------------------" 
}

else {
New-ADUser -SamAccountName $SamAccountN -Name "$userName" -DisplayName "$Voorname $Achternaam" -GivenName $Voorname -Surname $Achternaam -City $Stad -PostalCode $PostCode -StreetAddress $Adres -EmailAddress "$Voorname.$Achternaam@poliforma.com" -MobilePhone $Telefoon -AccountPassword(ConverTto-SecureString $WachtWoord -AsPlainText -force) -ChangePasswordAtLogon $true -Path $path -Description $Department
Write-Host "$voorname $Achternaam has be add in $parth" -ForegroundColor Green  
Write-host "----------------------------------------------------------------------"
}
}