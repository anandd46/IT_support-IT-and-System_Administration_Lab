# Practical Task: Windows 11 Startup and Boot Troubleshooting

## 1. Objective
Diagnose and resolve Windows 11 boot failures, configure Safe Mode, rebuild the Boot Configuration Data (BCD), use System File Checker (SFC) and DISM, and analyze BSOD stop codes.

## 2. Requirements
- Windows 11 PC or Virtual Machine
- Windows 11 Installation USB or Recovery Environment (WinRE)
- Administrative access

## 3. Background
Boot failure occurs when the system cannot progress through the boot sequence:
1. **UEFI POST:** Hardware initialization and firmware execution.
2. **Windows Boot Manager (`bootmgr` / `bootmgfw.efi`):** Reads the BCD store on the EFI System Partition.
3. **Windows OS Loader (`winload.efi`):** Initializes kernel (`ntoskrnl.exe`), HAL, and boot-critical drivers.
4. **Session Manager (`smss.exe`):** Launches user-mode subsystems and Winlogon.

When boot files or critical system drivers are corrupted, Windows fails to start, enters automatic repair loops, or halts with a Blue Screen of Death (BSOD).

## 4. Step-by-Step Procedure
1. **Access Windows Recovery Environment (WinRE):** Hold Shift while clicking Restart from Start Menu, or interrupt booting 2 consecutive times.
2. **Safe Mode Navigation:** From WinRE, choose Troubleshoot > Advanced Options > Startup Settings > Select option 4 (Safe Mode) or 5 (Safe Mode with Networking).
3. **System File Integrity Scan:** Open elevated command prompt and run `sfc /scannow`.
4. **Deployment Image Servicing and Management (DISM):** Run `dism /online /cleanup-image /restorehealth` to repair the Windows Component Store from Windows Update or ISO.
5. **Boot Configuration Data (BCD) Verification:** Open elevated prompt and query `bcdedit /enum`.
6. **Rebuilding BCD (Simulated Recovery):** In WinRE Command Prompt, execute boot repair commands (`bootrec /fixmbr`, `bootrec /fixboot`, `bootrec /rebuildbcd`).
7. **Clean Boot Configuration:** Use `msconfig` to disable third-party startup services to isolate software conflicts.

## 5. Commands Used

### Command 1: System File Checker
```cmd
sfc /scannow
```
- **What it does:** Scans all protected system files and replaces corrupted files with a cached copy from `%WinDir%\System32\dllcache`.
- **Why it is used:** First-line defense against corrupted DLLs, OS instability, and explorer crashes.
- **Expected Output:**
```text
Beginning system scan. This process will take some time.
Beginning verification phase of system scan.
Verification 100% complete.
Windows Resource Protection did not find any integrity violations.
```

### Command 2: DISM Component Store Repair
```cmd
dism /online /cleanup-image /restorehealth
```
- **What it does:** Validates and repairs the Windows Component Store (`WinSxS`) against healthy files downloaded from Microsoft Update servers.
- **Why it is used:** Required when `sfc /scannow` reports that files were corrupted but could not be repaired.

### Command 3: BCD Configuration Inspection
```cmd
bcdedit /enum
```
- **What it does:** Lists bootloader settings, timeout values, safe boot flags, and EFI executable paths.
- **Why it is used:** Identifies misconfigured boot parameters or invalid drive identifiers preventing boot.

## 6. Expected Result
The technician repairs corrupted system files, successfully accesses Safe Mode for driver rollback, validates BCD configuration, and isolates software conflicts preventing normal startup.

## 7. Troubleshooting
- **Issue: `bootrec /fixboot` returns "Access is denied":**
  - *Cause:* Modern UEFI GPT systems require assigning a drive letter to the EFI system partition and using `bcdboot` instead of legacy MBR `bootrec`.
  - *Solution:* Use `diskpart`, select EFI partition (FAT32), assign letter S:, then run: `bcdboot C:\Windows /s S: /f UEFI`.
- **Issue: Continuous Automatic Repair Loop:**
  - *Cause:* Recent faulty driver update or registry hive corruption (`SYSTEM` or `SOFTWARE`).
  - *Solution:* Boot to WinRE, open Command Prompt, check `C:\Windows\System32\Logfiles\Srt\SrtTrail.txt` for exact failure cause, and uninstall latest quality update via DISM.

## 8. Screenshots / Evidence
- `screenshots/06-winre-advanced-options.png` — *Pending lab execution: Capture Windows Recovery Environment screen.*
- `screenshots/06-sfc-scannow-result.png` — *Pending lab execution: Capture completed sfc verification.*
- `screenshots/06-bcdedit-output.png` — *Pending lab execution: Capture bcdedit configuration listing.*

## 9. Practical Learning Outcome
Ability to rescue non-booting Windows workstations, perform offline and online system integrity repairs, navigate recovery environments, and rebuild UEFI boot parameters.

## 10. Completion Status
Documented
