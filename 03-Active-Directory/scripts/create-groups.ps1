#Requires -Version 5.1
<#
.SYNOPSIS
    Provisions Global Security Groups and assigns department users.
.DESCRIPTION
    Creates IT-Admins, HR-Users, Finance-Users, Operations-Users, and All-Staff.
.AUTHOR
    Anand D - IT Support Lab
#>

Import-Module ActiveDirectory -ErrorAction Stop

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "   ACTIVE DIRECTORY LAB - CREATE GROUPS    " -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

$groups = @(
    @{ Name="IT-Admins";       OU="OU=IT,DC=lab,DC=local";         Desc="IT Department Administrators"; Members=@("user01") },
    @{ Name="HR-Users";        OU="OU=HR,DC=lab,DC=local";         Desc="HR Department Personnel";      Members=@("user02") },
    @{ Name="Finance-Users";   OU="OU=Finance,DC=lab,DC=local";    Desc="Finance Department Personnel"; Members=@("user03") },
    @{ Name="Operations-Users";OU="OU=Operations,DC=lab,DC=local"; Desc="Operations Personnel";         Members=@("user04") },
    @{ Name="All-Staff";       OU="DC=lab,DC=local";               Desc="All Company Employees";        Members=@("user01","user02","user03","user04") }
)

foreach ($g in $groups) {
    if (-not (Get-ADGroup -Filter {Name -eq $g.Name} -ErrorAction SilentlyContinue)) {
        New-ADGroup -Name $g.Name -GroupScope Global -GroupCategory Security -Path $g.OU -Description $g.Desc
        Write-Host "SUCCESS: Created security group $($g.Name)" -ForegroundColor Green
    } else {
        Write-Host "SKIP: Group $($g.Name) already exists." -ForegroundColor Yellow
    }
    
    foreach ($m in $g.Members) {
        try {
            Add-ADGroupMember -Identity $g.Name -Members $m -ErrorAction Stop
            Write-Host "  -> Added member $m to $($g.Name)" -ForegroundColor Gray
        } catch {
            Write-Host "  -> Notice: $m already in $($g.Name) or user missing." -ForegroundColor Yellow
        }
    }
}

Write-Host "`nGroup creation script completed." -ForegroundColor Cyan
