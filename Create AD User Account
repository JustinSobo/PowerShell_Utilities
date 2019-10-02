<#
.SYNOPSIS
Creates a user account in active directory with information entered in by the user.
 
.DESCRIPTION
This will create a user in Active Directory automatically with Powershell.
 
.NOTES
Name: AD-CreateUserNoMailbox.ps1
Version: 1.0
Author: The Sysadmin Channel
Date of last revision: 12/18/2016
#>
 
 
#Checking if the shell is running as administrator.
#Requires -RunAsAdministrator
#Requires -Module ActiveDirectory
$title = "Create a User Account in Active Directory"
 
$host.ui.RawUI.WindowTitle = $title
 
Import-Module ActiveDirectory -EA Stop
 
sleep 5
cls
 
 
Write-Host
Write-Host
#Getting variable for the First Name
$firstname = Read-Host "Enter in the First Name"
Write-Host
#Getting variable for the Last Name
$lastname = Read-Host "Enter in the Last Name"
Write-Host
#Setting Full Name (Display Name) to the users first and last name
$fullname = "$firstname $lastname"
#Write-Host
#Setting username to first initial of first name along with the last name.
$i = 1
$logonname = $firstname.substring(0,$i) + $lastname
#Setting the employee ID.  Remove the '#' if you want to use the variable
#$empID = Read-Host "Enter in the Employee ID"
#Setting the Path for the OU.
$OU = "DC=MGADM"
#Setting the variable for the domain.
$domain = $env:userdnsdomain
#Setting the variable for the description.
$Description = Read-Host "Enter in the User Description"
 
 
cls
#Displaying Account information.
Write-Host "======================================="
Write-Host
Write-Host "Firstname:      $firstname"
Write-Host "Lastname:       $lastname"
Write-Host "Display name:   $fullname"
Write-Host "Logon name:     $logonname"
Write-Host "OU:             $OU"
Write-Host "Domain:         $domain"
 
#Checking to see if user account already exists.  If it does it
#will append the next letter of the first name to the username.
DO
{
If ($(Get-ADUser -Filter {SamAccountName -eq $logonname})) {
        Write-Host "WARNING: Logon name" $logonname.toUpper() "already exists!!" -ForegroundColor:Green
        $i++
        $logonname = $firstname.substring(0,$i) + $lastname
        Write-Host
        Write-Host
        Write-Host "Changing Logon name to" $logonname.toUpper() -ForegroundColor:Green
        Write-Host
        $taken = $true
        sleep 10
    } else {
    $taken = $false
    }
} Until ($taken -eq $false)
$logonname = $logonname.toLower()
 
cls
#Displaying account information that is going to be used.
Write-Host "======================================="
Write-Host
Write-Host "Firstname:      $firstname"
Write-Host "Lastname:       $lastname"
Write-Host "Display name:   $fullname"
Write-Host "Logon name:     $logonname"
Write-Host "OU:             $OU"
Write-Host "Domain:         $domain"
 
 
 
#Setting minimum password length to 12 characters and adding password complexity.
$PasswordLength = 8
 
Do
{
Write-Host
    $isGood = 0
    $Password = Read-Host "Enter in the Password" -AsSecureString
    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($Password)
    $Complexity = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
 
    if ($Complexity.Length -ge $PasswordLength) {
                Write-Host
            } else {
                Write-Host "Password needs $PasswordLength or more Characters" -ForegroundColor:Green
        }
 
    if ($Complexity -match "[^a-zA-Z0-9]") {
                $isGood++
            } else {
                Write-Host "Password does not contain Special Characters." -ForegroundColor:Green
        }
 
    if ($Complexity -match "[0-9]") {
                $isGood++
            } else {
                Write-Host "Password does not contain Numbers." -ForegroundColor:Green
        }
 
    if ($Complexity -cmatch "[a-z]") {
                $isGood++
            } else {
                Write-Host "Password does not contain Lowercase letters." -ForegroundColor:Green
        }
 
    if ($Complexity -cmatch "[A-Z]") {
                $isGood++
            } else {
                Write-Host "Password does not contain Uppercase letters." -ForegroundColor:Green
        }
 
} Until ($password.Length -ge $PasswordLength -and $isGood -ge 3)
 
 
Write-Host
Read-Host "Press Enter to Continue Creating the Account"
Write-Host "Creating Active Directory user account now" -ForegroundColor:Green
 
#Creating user account with the information you inputted.
New-ADUser -Name $fullname -GivenName $firstname -Surname $lastname -DisplayName $fullname -SamAccountName $logonname -UserPrincipalName $logonname@$Domain -AccountPassword $password -Enabled $true -Path $OU -Description $Description -Confirm:$false
 
sleep 2
 
 
Write-Host
 
$ADProperties = Get-ADUser $logonname -Properties *
 
Sleep 3
 
cls
 
Write-Host "========================================================"
Write-Host "The account was created with the following properties:"
Write-Host
Write-Host "Firstname:      $firstname"
Write-Host "Lastname:       $lastname"
Write-Host "Display name:   $fullname"
Write-Host "Logon name:     $logonname"
Write-Host "OU:             $OU"
Write-Host "Domain:         $domain"
Write-Host
Write-Host
