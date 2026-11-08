#Requires -Version 5.1
<#
.SYNOPSIS
    Audits Active Directory users and account security status.
.DESCRIPTION
    Generates reports on locked accounts, disabled accounts, and password age.
.AUTHOR
    Anand D - IT Support Lab
#>

Import-Module ActiveDirectory -ErrorAction Stop

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "   ACTIVE DIRECTORY LAB - USER AUDIT       " -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "--- 1. ALL DOMAIN USERS ---" -ForegroundColor Yellow
Get-ADUser -Filter * -Properties Department, Title, Enabled, LockedOut, PasswordLastSet |
    Select-Object SamAccountName, Name, Department, Title, Enabled, LockedOut, PasswordLastSet |
    Format-Table -AutoSize

Write-Host "--- 2. CURRENTLY LOCKED ACCOUNTS ---" -ForegroundColor Red
$locked = Search-ADAccount -LockedOut
if ($locked) {
    $locked | Select-Object Name, SamAccountName, LastLogonDate | Format-Table -AutoSize
} else {
    Write-Host "Zero locked accounts detected in domain." -ForegroundColor Green
}

Write-Host "`n--- 3. DISABLED ACCOUNTS ---" -ForegroundColor Yellow
$disabled = Get-ADUser -Filter {Enabled -eq $false}
if ($disabled) {
    $disabled | Select-Object SamAccountName, Name | Format-Table -AutoSize
} else {
    Write-Host "Zero disabled accounts detected." -ForegroundColor Green
}

Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "   ACTIVE DIRECTORY USER AUDIT COMPLETE     " -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
