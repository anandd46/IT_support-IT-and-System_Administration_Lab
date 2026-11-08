#Requires -Version 5.1
<#
.SYNOPSIS
    Automates sample Active Directory user provisioning for IT Support Lab.
.DESCRIPTION
    Creates standardized departmental user accounts across IT, HR, Finance,
    and Operations OUs in lab.local.
.AUTHOR
    Anand D - IT Support Lab
#>

Import-Module ActiveDirectory -ErrorAction Stop

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "   ACTIVE DIRECTORY LAB - CREATE USERS     " -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

$domain = "lab.local"
$defaultPassword = ConvertTo-SecureString "LabUser@2024!" -AsPlainText -Force

$users = @(
    @{ GivenName="User"; Surname="01"; SamAccount="user01"; OU="OU=IT,DC=lab,DC=local"; Department="IT"; Title="IT Support Technician" },
    @{ GivenName="User"; Surname="02"; SamAccount="user02"; OU="OU=HR,DC=lab,DC=local"; Department="HR"; Title="HR Specialist" },
    @{ GivenName="User"; Surname="03"; SamAccount="user03"; OU="OU=Finance,DC=lab,DC=local"; Department="Finance"; Title="Finance Analyst" },
    @{ GivenName="User"; Surname="04"; SamAccount="user04"; OU="OU=Operations,DC=lab,DC=local"; Department="Operations"; Title="Operations Coordinator" }
)

foreach ($u in $users) {
    $upn = "$($u.SamAccount)@$domain"
    $displayName = "$($u.GivenName) $($u.Surname)"
    
    if (Get-ADUser -Filter {SamAccountName -eq $u.SamAccount} -ErrorAction SilentlyContinue) {
        Write-Host "SKIP: User $($u.SamAccount) already exists." -ForegroundColor Yellow
        continue
    }
    
    try {
        New-ADUser `
            -Name $displayName `
            -GivenName $u.GivenName `
            -Surname $u.Surname `
            -SamAccountName $u.SamAccount `
            -UserPrincipalName $upn `
            -Path $u.OU `
            -Department $u.Department `
            -Title $u.Title `
            -AccountPassword $defaultPassword `
            -Enabled $true `
            -ChangePasswordAtLogon $true `
            -ErrorAction Stop
            
        Write-Host "SUCCESS: Created user $displayName ($upn) in $($u.Department) OU" -ForegroundColor Green
    } catch {
        Write-Host "ERROR: Failed creating $($u.SamAccount) - $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "`nUser creation script completed." -ForegroundColor Cyan
