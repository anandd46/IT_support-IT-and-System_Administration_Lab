# Practical Task: Peripheral Support: Keyboards, Mice, Monitors, and KVMs

## 1. Objective
Diagnose and resolve workstation peripheral failures, configure multi-monitor display topologies, resolve video resolution and refresh rate mismatches, and manage KVM switches.

## 2. Requirements
- Windows 11 workstation
- External monitors (HDMI, DisplayPort), USB keyboard and mouse
- Device Manager, Windows Display Settings

## 3. Background
Peripheral devices connect end users to computing power. Common peripheral failures:
- **Display Connections:** DisplayPort (carries high refresh/resolution and daisy-chaining) vs HDMI (universal consumer standard) vs VGA/DVI (legacy analog/digital).
- **USB Peripherals:** USB 2.0 (black port, 480 Mbps) vs USB 3.0/3.1 (blue port, 5+ Gbps) vs USB-C. Power overdraw on unpowered hubs causes intermittent disconnects.
- **KVM Switches (Keyboard, Video, Mouse):** Enable a single console to control multiple servers in server rooms or bridge bridge/engine consoles.

## 4. Step-by-Step Procedure
1. **Display Diagnostics ("No Signal"):**
   - Verify monitor power cord and input selection (HDMI 1 vs DP).
   - Verify cable connection directly to dedicated GPU, not integrated motherboard ports.
   - Test with alternate cable or secondary display.
2. **Display Settings Configuration:** Right-click desktop > Display settings. Verify resolution (Native recommended), refresh rate (Advanced display), and multi-monitor arrangement (Extend these displays).
3. **Keyboard & Mouse Diagnostics:**
   - Unresponsive mouse: test alternate USB port; test on another PC.
   - Keystroke chatter / repeated letters: adjust Filter Keys and Repeat Delay in Accessibility settings.
   - Check Device Manager under Human Interface Devices (HID).
4. **KVM Switch Troubleshooting:** Check physical hotkey switching (e.g., Scroll Lock + Scroll Lock + 1), verify USB passthrough power.

## 5. Commands Used

### Command 1: Inspect Video Controllers via PowerShell
```powershell
Get-CimInstance Win32_VideoController | Select-Object Name, VideoProcessor, DriverVersion, CurrentHorizontalResolution, CurrentVerticalResolution, CurrentRefreshRate
```
- **What it does:** Displays GPU hardware model, installed graphics driver version, active resolution, and refresh rate.

### Command 2: Enumerate USB Controllers & Hubs
```powershell
Get-CimInstance Win32_USBController | Select-Object Name, Status, DeviceID
```
- **What it does:** Verifies health of onboard USB Host Controllers and root hubs.

## 6. Expected Result
Workstation displays output at native resolution with correct multi-monitor positioning; keyboard and mouse operate with zero input lag.

## 7. Troubleshooting
- **Issue: Monitor flickers intermittently every few minutes:**
  - *Cause:* Low-quality or excessively long HDMI/DP cable experiencing electromagnetic interference (EMI) or refresh rate mismatch.
  - *Solution:* Replace cable with certified high-speed cable; lock refresh rate to 60 Hz in Windows Display Settings.

## 8. Screenshots / Evidence
- `screenshots/07-display-settings-multi.png` — *Pending lab execution: Capture multi-monitor arrangement.*
- `screenshots/07-powershell-videocontroller.png` — *Pending lab execution: Capture video controller query.*

## 9. Practical Learning Outcome
Ability to diagnose, configure, and troubleshoot workstation displays, human interface devices, and console switching hardware.

## 10. Completion Status
Documented
