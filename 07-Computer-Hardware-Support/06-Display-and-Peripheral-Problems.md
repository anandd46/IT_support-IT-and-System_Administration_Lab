# Practical Task: Video Display, GPU, and Screen Artifact Troubleshooting

## 1. Objective
Diagnose and resolve display blackouts, graphic artifacting, driver crashes, multi-monitor configuration errors, and GPU thermal throttling.

## 2. Requirements
- PC workstation with dedicated graphics card (PCIe) or integrated GPU
- Display monitor and cables (HDMI / DisplayPort)
- Tools: Device Manager, Display Driver Uninstaller (DDU), FurMark (GPU stress test)

## 3. Background
Display problems range from simple cable disconnections to failing VRAM chips on graphics cards.
- **Visual Artifacts:** Screen tearing, checkered patterns, multicolored pixels, or horizontal lines appearing across the screen. Usually caused by overheating VRAM or failing GPU silicon.
- **Black Screen with Audio:** Windows boots (login chime heard), but monitor displays "No Signal". Usually caused by GPU driver crash, incorrect refresh rate, or loose video cable.
- **Display Driver Reset:** Windows screen goes black for 2 seconds, returns, and shows "Display driver stopped responding and has recovered" (TDR - Timeout Detection and Recovery).

## 4. Step-by-Step Procedure
1. **Cable & Port Verification:**
   - Confirm monitor video cable is connected to the **dedicated GPU ports** located lower on the chassis, NOT the motherboard ports at the top.
   - Test with alternate HDMI / DisplayPort cable.
2. **Keyboard Video Reset Shortcut:** Press Win + Ctrl + Shift + B. Screen flickers and beeps as the graphics subsystem restarts.
3. **Boot into Safe Mode for Driver Cleanup:**
   - If Windows crashes during driver load, boot to Safe Mode.
   - Run Display Driver Uninstaller (DDU) to wipe corrupted GPU drivers.
   - Reboot to normal mode and install clean certified OEM driver.
4. **GPU Stress Test & Thermal Inspection:** Run GPU benchmark (e.g., FurMark) while monitoring GPU core and hotspot temperatures in HWiNFO64.

## 5. Commands Used

### Command 1: Inspect GPU Status via PowerShell
```powershell
Get-CimInstance Win32_VideoController | Select-Object Name, Status, DriverVersion, DriverDate, AdapterRAM
```
- **What it does:** Returns GPU model, Device Manager health status, and driver metadata.

## 6. Expected Result
Display issues are resolved, corrupted graphics drivers are purged, and video cards operate at stable resolutions without artifacts.

## 7. Troubleshooting
- **Issue: Small green dots/lines appear in 3D applications and games:**
  - *Cause:* Overheating or dying GDDR video memory (VRAM).
  - *Solution:* Clean dust from GPU heatsink and fans; downclock VRAM via software; replace GPU if artifacts persist.

## 8. Screenshots / Evidence
- `screenshots/06-gpu-device-manager.png` — *Pending lab execution: Capture GPU properties in Device Manager.*

## 9. Practical Learning Outcome
Ability to diagnose video subsystem failures, manage display driver recovery, and isolate GPU hardware breakdown.

## 10. Completion Status
Documented
