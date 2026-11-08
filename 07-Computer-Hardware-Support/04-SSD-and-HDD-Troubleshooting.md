# Practical Task: Storage Device Diagnostics: SSDs, NVMe, and HDDs

## 1. Objective
Diagnose mechanical HDD failures vs SSD wear, analyze Self-Monitoring, Analysis, and Reporting Technology (S.M.A.R.T.) telemetry, benchmark drive throughput, and execute non-destructive file system scans.

## 2. Requirements
- PC with SATA HDD, SATA SSD, or M.2 NVMe SSD
- Tools: CrystalDiskInfo, CrystalDiskMark, Command Prompt, PowerShell

## 3. Background
- **Mechanical HDD:** Spinning magnetic platters with electromagnetic read/write heads. Vulnerable to physical shock, head crashes, and surface bad sectors. Failing signs: clicking noises, extreme latency, CRC errors.
- **SATA / NVMe SSD:** NAND flash memory with wear-leveling controllers. No moving parts. Faster transfer speeds (SATA: ~500 MB/s; PCIe Gen4 NVMe: ~7,000 MB/s). Vulnerable to finite flash write endurance (TBW - Terabytes Written) and sudden controller failure.
- **S.M.A.R.T. Monitoring:** Internal firmware telemetry tracking reallocated sector counts, drive temperature, read error rates, and percentage lifetime used.

## 4. Step-by-Step Procedure
1. **Install & Run CrystalDiskInfo:** Launch CrystalDiskInfo. Inspect drive health:
   - **Good (Blue):** Drive healthy.
   - **Caution (Yellow):** Bad sectors or high wear detected; immediate data backup required!
   - **Bad (Red):** Imminent failure or failed drive.
2. **Evaluate Key S.M.A.R.T. Attributes:**
   - `05 Reallocated Sectors Count` (HDD): Bad sectors retired and remapped to spare area. Count > 0 indicates degrading platter.
   - `0A Spin Retry Count` (HDD): Motor failing to achieve rated RPM.
   - `05 Percentage Used` (NVMe): Wear indicator based on manufacturer TBW rating.
3. **Execute File System Scan:** Run `chkdsk C: /scan` (online non-disruptive check).
4. **Performance Benchmark:** Run CrystalDiskMark to verify read/write speeds match manufacturer specs.

## 5. Commands Used

### Command 1: Query Physical Storage Bus & Health via PowerShell
```powershell
Get-PhysicalDisk | Select-Object DeviceId, FriendlyName, MediaType, BusType, @{N='Size (GB)';E={[math]::Round($_.Size/1GB, 2)}}, HealthStatus, OperationalStatus
```
- **What it does:** Displays disk media type (SSD vs HDD), bus interface (NVMe, SATA, USB), and Windows health assessment.

### Command 2: Non-Destructive Online Chkdsk
```cmd
chkdsk C: /scan
```
- **What it does:** Scans the active NTFS volume for inconsistencies while the system remains fully operational.

## 6. Expected Result
The technician analyzes drive telemetry, identifies failing sectors before data loss occurs, and validates drive read/write performance.

## 7. Troubleshooting
- **Issue: HDD produces rhythmic clicking sound ("Click of Death"):**
  - *Cause:* Read/write heads attempting to find track zero and failing due to head preamp failure or surface damage.
  - *Solution:* Power off drive immediately to prevent platter scraping; explain to user that cleanroom data recovery is required.

## 8. Screenshots / Evidence
- `screenshots/04-crystaldiskinfo-smart.png` — *Pending lab execution: Capture CrystalDiskInfo health report.*
- `screenshots/04-powershell-physicaldisk.png` — *Pending lab execution: Capture Get-PhysicalDisk output.*

## 9. Practical Learning Outcome
Ability to interpret S.M.A.R.T. health data, differentiate mechanical from solid-state failure modes, and prevent catastrophic data loss.

## 10. Completion Status
Documented
