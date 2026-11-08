#Requires -Version 5.1
<#
.SYNOPSIS
    Generates report of running processes sorted by CPU and memory usage.
.DESCRIPTION
    Read-only performance inspection script. Identifies top resource consumers.
.AUTHOR
    Anand D - IT Support Lab
#>

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "   IT SUPPORT LAB - PROCESS REPORT         " -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "--- TOP 10 PROCESSES BY CPU USAGE ---" -ForegroundColor Yellow
Get-Process | Sort-Object CPU -Descending | Select-Object -First 10 Id, ProcessName, @{N='CPU (Seconds)';E={[math]::Round($_.CPU, 2)}}, @{N='Memory (MB)';E={[math]::Round($_.WorkingSet64 / 1MB, 2)}} | Format-Table -AutoSize

Write-Host "--- TOP 10 PROCESSES BY MEMORY USAGE ---" -ForegroundColor Yellow
Get-Process | Sort-Object WorkingSet64 -Descending | Select-Object -First 10 Id, ProcessName, @{N='Memory (MB)';E={[math]::Round($_.WorkingSet64 / 1MB, 2)}}, @{N='CPU (Seconds)';E={[math]::Round($_.CPU, 2)}} | Format-Table -AutoSize

$all = Get-Process
$totalMem = [math]::Round(($all | Measure-Object WorkingSet64 -Sum).Sum / 1MB, 2)
Write-Host "Total Active Processes : $($all.Count)" -ForegroundColor Cyan
Write-Host "Total Process Memory   : $totalMem MB" -ForegroundColor Cyan
Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "   PROCESS REPORT COMPLETE                 " -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
