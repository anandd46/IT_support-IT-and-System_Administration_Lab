#Requires -Version 5.1
<#
.SYNOPSIS
    Checks disk space and reports physical drive health status.
.DESCRIPTION
    Read-only diagnostic script checking drive capacity, usage percentage, and SMART status.
.AUTHOR
    Anand D - IT Support Lab
#>

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "    IT SUPPORT LAB - DISK HEALTH CHECK     " -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "--- LOGICAL DRIVE CAPACITY ---" -ForegroundColor Yellow
$drives = Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3" -ErrorAction SilentlyContinue
if ($drives) {
    foreach ($d in $drives) {
        $totalGB = [math]::Round($d.Size / 1GB, 2)
        $freeGB  = [math]::Round($d.FreeSpace / 1GB, 2)
        $usedGB  = [math]::Round($totalGB - $freeGB, 2)
        $pct     = if ($totalGB -gt 0) { [math]::Round(($usedGB / $totalGB) * 100, 1) } else { 0 }

        Write-Host "Drive $($d.DeviceID) [$($d.VolumeName)]"
        Write-Host "  Total Space : $totalGB GB"
        Write-Host "  Used Space  : $usedGB GB ($pct%)"
        Write-Host "  Free Space  : $freeGB GB"

        if ($pct -ge 90) {
            Write-Host "  STATUS      : CRITICAL (Less than 10% free space remaining!)" -ForegroundColor Red
        } elseif ($pct -ge 80) {
            Write-Host "  STATUS      : WARNING (Drive over 80% capacity)" -ForegroundColor Yellow
        } else {
            Write-Host "  STATUS      : HEALTHY" -ForegroundColor Green
        }
        Write-Host ""
    }
}

Write-Host "--- PHYSICAL DISK SMART STATUS ---" -ForegroundColor Yellow
$phys = Get-CimInstance Win32_DiskDrive -ErrorAction SilentlyContinue
if ($phys) {
    foreach ($disk in $phys) {
        $sizeGB = [math]::Round($disk.Size / 1GB, 2)
        Write-Host "Disk $($disk.Index) : $($disk.Model)"
        Write-Host "  Size      : $sizeGB GB"
        Write-Host "  Interface : $($disk.InterfaceType)"
        Write-Host "  Status    : $($disk.Status)"
        if ($disk.Status -eq "OK") {
            Write-Host "  Health    : Reported Healthy by Windows" -ForegroundColor Green
        } else {
            Write-Host "  Health    : WARNING / ATTENTION REQUIRED" -ForegroundColor Red
        }
        Write-Host ""
    }
}

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "    DISK HEALTH CHECK COMPLETE              " -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
