# Practical Task: Windows 11 System Information and Hardware Diagnostics

## 1. Objective
Demonstrate how to accurately collect, analyze, and document complete hardware specifications, operating system details, and system health status in Windows 11 using GUI tools, command-line utilities, and PowerShell.

## 2. Requirements
- Operating System: Windows 11 Pro / Enterprise (physical host or VirtualBox VM)
- User Privileges: Standard User (some WMI queries benefit from Administrator)
- Tools: msinfo32, winver, dxdiag, Command Prompt, PowerShell 5.1+

## 3. Background
In enterprise desktop support and maritime IT systems administration, determining precise hardware specifications and OS build levels is the foundational first step before applying firmware updates, installing departmental software, resolving hardware incompatibilities, or opening vendor warranty tickets.

Key metrics to evaluate:
- Processor architecture (x64) and clock speed
- Installed physical RAM vs usable RAM
- Motherboard model and UEFI BIOS revision/date
- Windows 11 edition (Home, Pro, Enterprise), version (e.g., 23H2), and OS build number
- Storage controllers and physical drive interfaces

## 4. Step-by-Step Procedure
1. **Quick Version Check:** Press Win + R, type `winver`, and press Enter. Verify the edition, version, and OS build.
2. **Comprehensive System Information (GUI):** Press Win + R, type `msinfo32`, and press Enter. Inspect System Summary, Hardware Resources, Components, and Software Environment.
3. **DirectX Diagnostic Tool:** Press Win + R, type `dxdiag`, and press Enter. Inspect the System and Display tabs to verify display adapter memory, driver version, and DirectX features.
4. **Command Prompt Diagnostic:** Open Command Prompt (`cmd.exe`) and execute `systeminfo`. Inspect Domain, Hotfix list, Network Cards, and Hyper-V requirements.
5. **PowerShell WMI / CIM Queries:** Open PowerShell and query `Win32_OperatingSystem`, `Win32_Processor`, `Win32_PhysicalMemory`, and `Win32_Bios`.
6. **Export Specifications Report:** Save system information to a text file for documentation in IT ticketing records.

## 5. Commands Used

### Command 1: winver
```cmd
winver
```
- **What it does:** Displays the Windows version dialog showing edition, version number, and exact compilation build.
- **Why it is used:** Fast verification during helpdesk calls to determine if a computer has required feature updates or security patches.
- **Expected Output:** GUI dialog stating e.g. "Windows 11 Pro, Version 23H2 (OS Build 22631.3007)".

### Command 2: systeminfo
```cmd
systeminfo
```
- **What it does:** Queries local or remote computer configuration and outputs host name, OS name/version, BIOS version, physical memory, network cards, and installed hotfixes.
- **Why it is used:** Essential command-line utility for desktop support when troubleshooting patch levels or network adapter configurations without opening multiple GUI menus.
- **Expected Output:**
```text
Host Name:                 CLIENT01
OS Name:                   Microsoft Windows 11 Pro
OS Version:                10.0.22631 N/A Build 22631
System Manufacturer:       Dell Inc.
System Model:              OptiPlex 7090
System Type:               x64-based PC
Processor(s):              1 Processor(s) Installed.
                           [01]: Intel64 Family 6 Model 167 Stepping 1 GenuineIntel ~2500 Mhz
BIOS Version:              Dell Inc. 1.15.0, 15/08/2023
Total Physical Memory:     16,142 MB
Available Physical Memory: 10,850 MB
Domain:                    lab.local
```

### Command 3: PowerShell Get-ComputerInfo
```powershell
Get-ComputerInfo | Select-Object CsName, OsName, OsVersion, WindowsVersion, OsHardwareAbstractionLayer, CsProcessors, CsTotalPhysicalMemory
```
- **What it does:** Retrieves deep computer and OS metadata as structured PowerShell objects.
- **Why it is used:** Allows filtering, object manipulation, and exporting into CSV/JSON reports for asset management inventory.

### Command 4: WMIC / CIM Hardware Inspection
```powershell
Get-CimInstance Win32_Processor | Select-Object Name, NumberOfCores, NumberOfLogicalProcessors, MaxClockSpeed
Get-CimInstance Win32_PhysicalMemory | Select-Object Manufacturer, Capacity, Speed, PartNumber
```
- **What it does:** Queries CPU cores, clock speed, and individual RAM module serials, capacities, and speeds.
- **Why it is used:** Confirms RAM dual-channel configuration and identifies exact replacement part numbers without physical disassembly.

## 6. Expected Result
A complete hardware and software inventory is generated and documented. The technician knows the computer's exact OS edition, CPU architecture, RAM capacity, BIOS version, and patch state.

## 7. Troubleshooting
- **Issue: `msinfo32` fails to open or displays "Can't Collect Information":**
  - *Cause:* WMI (Windows Management Instrumentation) service corrupted or stopped.
  - *Solution:* Verify WMI service status (`net start winmgmt`), or repair WMI repository via `winmgmt /salvagerepository`.
- **Issue: Total Physical Memory displayed is significantly less than installed RAM:**
  - *Cause:* Faulty RAM stick, misconfigured DIMM slots, or reserved by integrated graphics.
  - *Solution:* Check BIOS hardware detection; reseat RAM sticks into paired slots (e.g., A2/B2).

## 8. Screenshots / Evidence
- `screenshots/02-winver-dialog.png` — *Pending lab execution: Capture winver dialog.*
- `screenshots/02-msinfo32-summary.png` — *Pending lab execution: Capture msinfo32 System Summary.*
- `screenshots/02-powershell-hardware-info.png` — *Pending lab execution: Capture PowerShell CIM memory output.*

## 9. Practical Learning Outcome
Demonstrated mastery in retrieving comprehensive system specifications through GUI and CLI, preparing accurate configuration logs, and verifying hardware health in enterprise and field environments.

## 10. Completion Status
Documented
