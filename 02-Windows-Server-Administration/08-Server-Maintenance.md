# Practical Task: Windows Server Maintenance, Updates, and Disaster Recovery

## 1. Objective
Establish standard server maintenance routines, manage Windows Server cumulative updates, review event log integrity, clean server storage, and plan disaster recovery snapshots.

## 2. Requirements
- Windows Server 2022 (`SERVER01`)
- Administrative credentials
- VirtualBox management console (for snapshot management)

## 3. Background
Unlike client workstations, enterprise servers cannot be updated or restarted during operational hours without disrupting business or vessel operations. Server maintenance requires:
- Strictly scheduled maintenance windows.
- Controlled pre-update snapshots / backups.
- Validation of critical domain, file, and DNS services post-maintenance.

## 4. Step-by-Step Procedure
1. **Pre-Maintenance Health Check:** Inspect active services, confirm AD replication, and verify zero critical Event Log errors.
2. **Virtual Machine Snapshot:** Power down server or create a live VirtualBox snapshot named "Pre-Patching-Baseline".
3. **Apply Server Updates:** In Settings > Windows Update, install approved Cumulative Security Updates.
4. **Controlled Reboot:** Execute planned restart with documentation: `shutdown /r /d p:2:4 /c "Scheduled Monthly Maintenance"`.
5. **Post-Maintenance Verification:** Verify Active Directory (`dcdiag`), DNS (`nslookup`), and SMB Shares (`Get-SmbShare`).
6. **Storage Maintenance:** Execute Disk Cleanup on system drive to purge obsolete patch binaries.

## 5. Commands Used

### Command 1: Controlled Server Restart with Event Reason
```cmd
shutdown /r /t 60 /d p:2:4 /c "Authorized monthly security update reboot"
```
- **What it does:** Initiates a 60-second countdown reboot, logging Planned Application Maintenance (`p:2:4`) to the Windows Event Log.

### Command 2: Post-Boot Critical Services Check
```powershell
$services = "NTDS", "DNS", "LanmanServer", "LanmanWorkstation", "Netlogon", "W32Time"
Get-Service -Name $services | Select-Object Name, DisplayName, Status, StartType
```
- **What it does:** Validates that all core Active Directory and networking infrastructure services are running.

## 6. Expected Result
The server is successfully updated, restarted cleanly within a maintenance window, and verified fully operational with zero degraded services.

## 7. Troubleshooting
- **Issue: Server fails to start key services after cumulative update:**
  - *Cause:* Corrupted update package or dependency failure.
  - *Solution:* Revert to the VirtualBox pre-patching snapshot created prior to maintenance; report bug to Microsoft.

## 8. Screenshots / Evidence
- `screenshots/08-post-maintenance-services.png` — *Pending lab execution: Capture PowerShell services status.*
- `screenshots/08-virtualbox-snapshot.png` — *Pending lab execution: Capture VirtualBox snapshot manager.*

## 9. Practical Learning Outcome
Mastery in enterprise change control, executing non-disruptive server maintenance windows, and implementing disaster recovery fallbacks.

## 10. Completion Status
Documented
