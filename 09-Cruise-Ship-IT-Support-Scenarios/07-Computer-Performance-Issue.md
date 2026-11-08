# Scenario 07: Workstation Performance Degradation in Medical Center

## 1. Scenario Description
The ship's Senior Doctor reports that the primary consultation computer in the Medical Center has become unusable over the last 48 hours. Opening electronic medical records takes several minutes, and the system frequently freezes during consultations.

## 2. Possible Causes
1. Background application or update service consuming 100% CPU.
2. Memory leak in medical records client software.
3. Mechanical hard drive developing bad sectors.
4. Malware or unauthorized crypto-mining script running in user profile.
5. Heavy dust accumulation causing CPU thermal throttling down to 800 MHz.

## 3. Initial Diagnosis
- Open Task Manager (`Ctrl + Shift + Esc`).
- **CPU:** 15% (Normal).
- **RAM:** 14.8 GB of 16 GB used (92% - High).
- **Disk:** **100% Active Time continuously**, with average response time exceeding **1,200 ms** (severe I/O bottleneck).
- Resource Monitor inspection shows `msedge.exe` running 45 background tabs and an orphaned medical database backup process reading drive C:.

## 4. Troubleshooting Procedure
1. **Terminate Runaway Tasks:**
   - Terminate orphaned backup process and close unused browser tabs.
   - Disk active time drops to 8%.
2. **Check Drive Health (S.M.A.R.T.):**
   - Run CrystalDiskInfo.
   - Drive is a 5-year-old mechanical HDD showing "Caution" with 48 Reallocated Sectors!
   - Root Cause: Physical drive failure causing Windows to repeatedly retry reading bad sectors.
3. **Emergency Data Backup & SSD Upgrade:**
   - Immediately backup medical profile data (`C:\Users\Doctor\Documents`) to secure encrypted share.
   - Replace mechanical HDD with pre-imaged 500GB SATA SSD from IT spares inventory.
   - Mount SSD, restore user profile, and test boot time.
4. **Verification:** System boots in 12 seconds; medical records open instantly; disk active time sits at 1%.

## 5. Commands Used
```powershell
Get-PhysicalDisk | Select-Object DeviceId, FriendlyName, MediaType, HealthStatus
taskkill /IM orphaned_task.exe /F
robocopy "C:\Users\Doctor\Documents" "\\SERVER01\Backups\Doctor" /E /Z /R:1 /W:1
```

## 6. Resolution
Identified degrading mechanical HDD with high S.M.A.R.T. bad sectors; backed up clinical data; swapped drive for solid-state drive (SSD); restored user profile; eliminated latency.

## 7. When to Escalate
- Any migration involving sensitive medical data requires strict adherence to privacy compliance protocols.

## 8. Preventive Measures
Proactively replace remaining mechanical HDDs across all critical departments with enterprise SSDs during scheduled maintenance.

## 9. Sample Completed Incident Report
- **Incident ID:** INC-2024-0330
- **Priority:** P2 (High)
- **Time to Resolve:** 45 Minutes
- **Technician:** Anand D (IT Systems Assistant)

## 10. Completion Status
Documented
