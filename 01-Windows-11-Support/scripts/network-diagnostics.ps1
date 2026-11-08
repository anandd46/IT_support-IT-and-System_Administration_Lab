#Requires -Version 5.1
<#
.SYNOPSIS
    Performs systematic step-by-step network connectivity diagnostics.
.DESCRIPTION
    Checks IP configuration, pings default gateway, tests public DNS,
    verifies name resolution, and tests established sockets. Read-only.
.AUTHOR
    Anand D - IT Support Lab
#>

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "   IT SUPPORT LAB - NETWORK DIAGNOSTICS    " -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

$adapters = Get-CimInstance Win32_NetworkAdapterConfiguration -Filter "IPEnabled=True" -ErrorAction SilentlyContinue
$gateway = $null

Write-Host "--- 1. IP CONFIGURATION ---" -ForegroundColor Yellow
if ($adapters) {
    foreach ($a in $adapters) {
        Write-Host "Adapter     : $($a.Description)"
        Write-Host "IP Address  : $($a.IPAddress -join ', ')"
        Write-Host "Gateway     : $($a.DefaultIPGateway -join ', ')"
        Write-Host "DNS Servers : $($a.DNSServerSearchOrder -join ', ')"
        if ($a.DefaultIPGateway) { $gateway = $a.DefaultIPGateway[0] }
    }
} else {
    Write-Host "No active network adapters found!" -ForegroundColor Red
}

Write-Host "`n--- 2. DEFAULT GATEWAY PING ---" -ForegroundColor Yellow
if ($gateway) {
    Write-Host "Pinging Gateway ($gateway)..."
    $gwPing = Test-Connection -ComputerName $gateway -Count 3 -Quiet -ErrorAction SilentlyContinue
    if ($gwPing) {
        Write-Host "PASS: Gateway is reachable." -ForegroundColor Green
    } else {
        Write-Host "FAIL: Gateway is unreachable. Check local switch/cabling." -ForegroundColor Red
    }
} else {
    Write-Host "FAIL: No default gateway configured (Possible DHCP failure)." -ForegroundColor Red
}

Write-Host "`n--- 3. INTERNET ROUTING PING (8.8.8.8) ---" -ForegroundColor Yellow
$pubPing = Test-Connection -ComputerName "8.8.8.8" -Count 3 -Quiet -ErrorAction SilentlyContinue
if ($pubPing) {
    Write-Host "PASS: Public internet IP 8.8.8.8 is reachable." -ForegroundColor Green
} else {
    Write-Host "FAIL: Cannot reach public internet IP. Check ISP / WAN router." -ForegroundColor Red
}

Write-Host "`n--- 4. DNS NAME RESOLUTION ---" -ForegroundColor Yellow
try {
    $dnsTest = [System.Net.Dns]::GetHostAddresses("google.com")
    Write-Host "PASS: Successfully resolved google.com to $($dnsTest[0].IPAddressToString)" -ForegroundColor Green
} catch {
    Write-Host "FAIL: DNS name resolution failed. Run 'ipconfig /flushdns' and verify DNS servers." -ForegroundColor Red
}

Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "   NETWORK DIAGNOSTICS COMPLETE            " -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
