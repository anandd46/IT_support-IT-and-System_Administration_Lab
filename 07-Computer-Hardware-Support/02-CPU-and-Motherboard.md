# Practical Task: CPU Architecture, Motherboard Sockets, and Thermal Management

## 1. Objective
Inspect CPU specifications, understand Intel vs. AMD socket types, diagnose thermal throttling and overheating, apply thermal compound correctly, and replace the motherboard CMOS battery.

## 2. Requirements
- Workstation PC with CPU heatsink
- High-grade thermal paste (e.g., Arctic MX-4) and 99% isopropyl alcohol
- New CR2032 3V lithium coin battery
- Hardware monitor utility (HWiNFO64 or Core Temp)

## 3. Background
- **CPU Sockets:** Intel LGA (Land Grid Array - pins are on motherboard) vs. AMD AM4/AM5. Incorrect seating damages fragile socket pins.
- **Thermal Interface Material (TIM):** Thermal paste fills microscopic air gaps between the CPU Integrated Heat Spreader (IHS) and heatsink base. Over 2-3 years, thermal paste dries out, leading to severe thermal throttling (CPU clocks down to 800 MHz to prevent melting) and sudden thermal shutdowns.
- **CMOS Battery (CR2032):** Powers the Real-Time Clock (RTC) and CMOS SRAM when AC power is disconnected. A dead battery causes system clock reset to year 2000/2015 and lost BIOS settings on every reboot.

## 4. Step-by-Step Procedure
1. **Monitor CPU Temperatures:** Launch HWiNFO64. Record baseline idle temperatures (normal: 35°C - 45°C). Run a compute stress test and record peak temperature (throttle limit: 90°C - 100°C).
2. **Thermal Repasting Procedure:**
   - Detach heatsink mounting screws in a diagonal cross pattern.
   - Gently twist heatsink to break old thermal paste seal before lifting.
   - Clean dried paste from CPU IHS and heatsink base using 99% isopropyl alcohol and lint-free wipes until polished clean.
   - Apply a pea-sized dot (~4mm) of new thermal paste in the center of the CPU IHS.
   - Remount heatsink, tightening screws incrementally in an X-pattern for uniform pressure.
3. **Re-Test Temperatures:** Verify load temperatures drop by 10°C - 20°C.
4. **CMOS Battery Replacement:**
   - Locate CR2032 battery holder on motherboard.
   - Press retention clip; battery pops up.
   - Insert fresh CR2032 (+ side facing up).
   - Enter BIOS/UEFI (press Del/F2 at boot), set correct time/date, and enable XMP/Secure Boot.

## 5. Commands Used

### Command 1: Query CPU Specifications via PowerShell
```powershell
Get-CimInstance Win32_Processor | Select-Object Name, SocketDesignation, NumberOfCores, NumberOfLogicalProcessors, MaxClockSpeed, L3CacheSize
```

## 6. Expected Result
CPU temperatures remain within safe operating thresholds (<75°C under sustained load), eliminating thermal throttling; system maintains real-time clock across power cuts.

## 7. Troubleshooting
- **Issue: PC shuts down within 30 seconds of powering on:**
  - *Cause:* CPU heatsink fan unplugged or heatsink mounted with plastic protective film left on the base.
  - *Solution:* Verify CPU_FAN header connection; dismount heatsink and remove protective peel.

## 8. Screenshots / Evidence
- `screenshots/02-hwinfo-temperatures.png` — *Pending lab execution: Capture CPU temperature telemetry.*
- `screenshots/02-cmos-battery-replacement.png` — *Pending lab execution: Capture CMOS battery socket.*

## 9. Practical Learning Outcome
Ability to diagnose thermal throttling, perform professional CPU thermal repasting, and replace CMOS batteries.

## 10. Completion Status
Documented
