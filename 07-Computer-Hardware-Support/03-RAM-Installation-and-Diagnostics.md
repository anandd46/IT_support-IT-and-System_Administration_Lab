# Practical Task: RAM Installation, Dual-Channel Architecture, and Memory Diagnostics

## 1. Objective
Install DDR4/DDR5 memory modules in dual-channel configuration, troubleshoot memory compatibility issues, and test for memory bit corruption using Windows Memory Diagnostic and MemTest86.

## 2. Requirements
- PC motherboard with 2 or 4 DIMM slots
- Matching pair of DDR4/DDR5 RAM sticks
- Tools: Windows Memory Diagnostic (`mdsched.exe`), MemTest86 bootable USB

## 3. Background
Random Access Memory (RAM) provides the CPU with volatile high-speed scratchpad storage.
- **Dual-Channel Architecture:** Installing memory in matched pairs doubles memory bandwidth by accessing two 64-bit channels simultaneously (128-bit total). On a 4-slot motherboard, dual-channel typically requires installing in **Slots 2 and 4 (A2 and B2)**.
- **Memory Corruption Symptoms:** Blue screens (`MEMORY_MANAGEMENT`, `PAGE_FAULT_IN_NONPAGED_AREA`), sudden program crashes without error, random system restarts, or corrupted file downloads.

## 4. Step-by-Step Procedure
1. **Safe RAM Installation:**
   - Ground yourself with ESD strap.
   - Open DIMM slot retention latches.
   - Align the physical notch on the RAM module with the key in the motherboard slot.
   - Push down firmly on both ends until latches snap into locked position automatically.
2. **Verify Dual-Channel & Capacity:** Power on PC, enter BIOS or check Task Manager Performance tab > Memory. Confirm capacity matches and Speed/Form Factor are correct.
3. **Execute Windows Memory Diagnostic:**
   - Press Win + R, type `mdsched.exe`, and select "Restart now and check for problems".
   - The computer reboots into Windows Memory Diagnostic environment and runs standard test passes.
4. **Review Diagnostic Results:** After boot, open Event Viewer > Windows Logs > System > Filter by Source `MemoryDiagnostics-Results`.

## 5. Commands Used

### Command 1: Launch Windows Memory Diagnostic
```cmd
mdsched.exe
```

### Command 2: Query Physical Memory Modules via PowerShell
```powershell
Get-CimInstance Win32_PhysicalMemory | Select-Object DeviceLocator, Manufacturer, PartNumber, @{N='Capacity (GB)';E={[math]::Round($_.Capacity/1GB, 2)}}, Speed, ConfiguredClockSpeed
```
- **What it does:** Identifies exact slot position (e.g., `DIMM 2`), part numbers, capacity, and current operating MHz.

## 6. Expected Result
RAM runs in verified dual-channel configuration, passes memory integrity tests with zero errors, and displays full capacity in Windows.

## 7. Troubleshooting
- **Issue: Windows shows "16 GB installed (7.9 GB usable)":**
  - *Cause:* One stick not fully seated in slot, installed in mismatched single-channel slots, or reserved by BIOS/iGPU.
  - *Solution:* Reseat sticks firmly into slots A2 and B2; check BIOS memory remapping settings.

## 8. Screenshots / Evidence
- `screenshots/03-mdsched-running.png` — *Pending lab execution: Capture memory diagnostic test screen.*
- `screenshots/03-eventvwr-memory-pass.png` — *Pending lab execution: Capture MemoryDiagnostics-Results Event log.*

## 9. Practical Learning Outcome
Mastery in memory module installation, dual-channel pairing, and isolating memory hardware defects.

## 10. Completion Status
Documented
