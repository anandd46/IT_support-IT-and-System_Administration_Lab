#Requires -Version 5.1
<#
.SYNOPSIS
    Collects and displays comprehensive system information.
.DESCRIPTION
    This script gathers hardware and software information from the local computer
    and displays it in a readable format. Safe and read-only.
.AUTHOR
    Anand D - IT Support Lab
#>

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "   IT SUPPORT LAB - SYSTEM INFORMATION     " -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# System
Write-Host "--- COMPUTER IDENTIFICATION ---" -ForegroundColor Yellow
$comp = Get-CimInstance Win32_ComputerSystem -ErrorAction SilentlyContinue
if ($comp) {
    Write-Host "Computer Name : $($comp.Name)"
    Write-Host "Domain        : $($comp.Domain)"
    Write-Host "Manufacturer  : $($comp.Manufacturer)"
    Write-Host "Model         : $($comp.Model)"
}

# OS
Write-Host "`n--- OPERATING SYSTEM ---" -ForegroundColor Yellow
$os = Get-CimInstance Win32_OperatingSystem -ErrorAction SilentlyContinue
if ($os) {
    Write-Host "OS Name       : $($os.Caption)"
    Write-Host "Version       : $($os.Version) (Build $($os.BuildNumber))"
    Write-Host "Architecture  : $($os.OSArchitecture)"
    Write-Host "Last Boot     : $($os.LastBootUpTime)"
}

# CPU
Write-Host "`n--- PROCESSOR (CPU) ---" -ForegroundColor Yellow
$cpu = Get-CimInstance Win32_Processor -ErrorAction SilentlyContinue
if ($cpu) {
    foreach ($p in $cpu) {
        Write-Host "Name          : $($p.Name.Trim())"
        Write-Host "Cores/Threads : $($p.NumberOfCores) Cores / $($p.NumberOfLogicalProcessors) Threads"
        Write-Host "Clock Speed   : $($p.MaxClockSpeed) MHz"
    }
}

# RAM
Write-Host "`n--- MEMORY (RAM) ---" -ForegroundColor Yellow
$ram = Get-CimInstance Win32_PhysicalMemory -ErrorAction SilentlyContinue
if ($ram) {
    $totalRAM = 0
    foreach ($stick in $ram) {
        $sizeGB = [math]::Round($stick.Capacity / 1GB, 2)
        Write-Host "RAM Module    : $sizeGB GB - Speed: $($stick.Speed) MHz - $($stick.Manufacturer)"
        $totalRAM += $stick.Capacity
    }
    Write-Host "Total Installed: $([math]::Round($totalRAM / 1GB, 2)) GB"
}

# Network
Write-Host "`n--- NETWORK ADAPTERS ---" -ForegroundColor Yellow
$net = Get-CimInstance Win32_NetworkAdapterConfiguration -Filter "IPEnabled=True" -ErrorAction SilentlyContinue
if ($net) {
    foreach ($adapter in $net) {
        Write-Host "Adapter       : $($adapter.Description)"
        Write-Host "IPv4 Address  : $($adapter.IPAddress -join ', ')"
        Write-Host "Subnet Mask   : $($adapter.IPSubnet -join ', ')"
        Write-Host "Gateway       : $($adapter.DefaultIPGateway -join ', ')"
        Write-Host "DNS Servers   : $($adapter.DNSServerSearchOrder -join ', ')"
        Write-Host "MAC Address   : $($adapter.MACAddress)"
        Write-Host ""
    }
}

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "   SYSTEM INFORMATION REPORT COMPLETE       " -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
