# Practical Task: Disk and Storage Management

## 1. Objective
Perform disk initialization, volume partitioning, resizing, file system formatting (NTFS/exFAT), storage optimization, and disk error checking in Windows 11.

## 2. Requirements
- Windows 11 installation with primary system drive and optional secondary test partition or virtual disk
- Administrative privileges
- Tools: Disk Management (`diskmgmt.msc`), DiskPart CLI, Check Disk (`chkdsk`), Disk Cleanup (`cleanmgr`)

## 3. Background
Storage administration is a core responsibility of desktop support engineers. Technicians must understand:
- **Partition Styles:** MBR (Master Boot Record - legacy, max 2TB, 4 primary partitions) vs. GPT (GUID Partition Table - modern UEFI, up to 128 partitions, petabyte capacity).
- **File Systems:** NTFS (enterprise standard with ACL permissions, encryption, journaling) vs. exFAT (cross-platform external drives) vs. FAT32 (legacy, 4GB max file size limit).
- **Maintenance Utilities:** Disk Cleanup and Storage Sense ensure adequate free space (>15% required for optimal NTFS performance and Windows Updates).

## 4. Step-by-Step Procedure
1. **Open Disk Management:** Press Win + X > Disk Management or run `diskmgmt.msc`.
2. **Examine Drive Layout:** Review Disk 0 partitions: EFI System Partition (FAT32), Windows OS (NTFS, BitLocker), and Windows Recovery Partition.
3. **Shrink and Create Volume:** Right-click volume C: > Shrink Volume by 10240 MB (10 GB) > Right-click Unallocated space > New Simple Volume > Format with NTFS named "DataVolume".
4. **Extend Volume:** Delete the test volume and extend C: to reclaim unallocated space.
5. **Run DiskPart Utility:** Open elevated Command Prompt, execute `diskpart`, list disks, volumes, and partitions.
6. **File System Integrity Check:** Execute `chkdsk` in read-only mode to scan for dirty bits and file system corruption.
7. **Storage Cleanup:** Execute `cleanmgr` or configure Windows 11 Storage Sense to purge obsolete update caches.

## 5. Commands Used

### Command 1: DiskPart Basic Inspection
```cmd
diskpart
list disk
list volume
exit
```
- **What it does:** Enters the scriptable disk partition utility, displays all connected physical drives and logical volumes.
- **Why it is used:** Required when GUI Disk Management hangs or when scripting automated deployment configurations.

### Command 2: Check Disk Command
```cmd
chkdsk C: /f /r
```
- **What it does:** Scans drive C: for file system errors (`/f`) and locates bad sectors recovering readable information (`/r`).
- **Why it is used:** Essential diagnostic when experiencing filesystem corruption, raw drive status, or file read/write errors.
- **Expected Output:** Prompts to schedule volume check on next system restart because volume is currently locked by the active OS.

### Command 3: Automated Disk Space Query via PowerShell
```powershell
Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3" | Select-Object DeviceID, VolumeName, @{N='Size (GB)';E={[math]::Round($_.Size/1GB, 2)}}, @{N='FreeSpace (GB)';E={[math]::Round($_.FreeSpace/1GB, 2)}}, @{N='% Free';E={[math]::Round(($_.FreeSpace/$_.Size)*100, 1)}}
```
- **What it does:** Returns all fixed hard drives with total capacity, available gigabytes, and remaining free space percentage.

## 6. Expected Result
The technician safely creates, resizes, and verifies NTFS volumes without data loss, diagnoses disk health via chkdsk, and reclaims wasted storage space.

## 7. Troubleshooting
- **Issue: "Extend Volume" option is greyed out in Disk Management:**
  - *Cause:* Unallocated space is not immediately adjacent to the right side of the partition being extended.
  - *Solution:* Delete or move intermediate recovery/data partitions using DiskPart or third-party partition tools, or extend via CLI.
- **Issue: chkdsk reports errors in an active volume during read-only scan:**
  - *Cause:* Dirty bit set on volume due to improper shutdown or sector wear.
  - *Solution:* Schedule `chkdsk C: /f` and reboot the machine during an authorized maintenance window.

## 8. Screenshots / Evidence
- `screenshots/05-disk-management-layout.png` — *Pending lab execution: Capture Disk Management graphical volume map.*
- `screenshots/05-diskpart-list.png` — *Pending lab execution: Capture DiskPart list disk and list volume output.*
- `screenshots/05-powershell-disk-space.png` — *Pending lab execution: Capture PowerShell drive utilization table.*

## 9. Practical Learning Outcome
Competence in partitioning disks, administering NTFS volumes, troubleshooting storage exhaustion, and executing safe disk health maintenance.

## 10. Completion Status
Documented
