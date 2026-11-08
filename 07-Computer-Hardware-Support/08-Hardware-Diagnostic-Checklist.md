# Practical Task: Master Hardware Diagnostic Checklist and Troubleshooting Matrix

## 1. Objective
Provide a unified, rigorous hardware diagnostic checklist to guide desktop support technicians through structured physical fault isolation.

## 2. Master Hardware Diagnostic Checklist

### Section A: Power & Boot Stage
- [ ] AC power cord firmly seated in PSU and working wall outlet.
- [ ] PSU rear rocker switch set to ON (`|`).
- [ ] Motherboard standby LED illuminated (confirms +5VSB power delivery).
- [ ] Front panel power switch header connected to correct motherboard pins.
- [ ] PSU passes paperclip jump test or digital voltage test (+12V, +5V, +3.3V within 5%).
- [ ] CPU 8-pin EPS and motherboard 24-pin ATX connectors fully latched.

### Section B: POST & Core Initialization
- [ ] Motherboard debug LEDs cycle through CPU -> DRAM -> VGA -> BOOT.
- [ ] Motherboard speaker emits single clean POST beep.
- [ ] CPU heatsink firmly clamped; fan spinning on `CPU_FAN` header.
- [ ] RAM sticks firmly seated in slots 2 and 4 (A2/B2); retaining clips locked.
- [ ] CMOS battery delivers >= 3.0V; date/time preserved across power cuts.

### Section C: Display & Graphics
- [ ] Video cable connected to dedicated GPU ports, not integrated motherboard ports.
- [ ] Monitor input source (HDMI/DP) manually verified.
- [ ] PCIe x16 graphics card auxiliary power cables (6-pin/8-pin) plugged in.
- [ ] Tested with known-working cable and secondary monitor.
- [ ] Zero visual artifacting, screen tearing, or horizontal banding present.

### Section D: Storage & Boot Media
- [ ] Storage drives detected in UEFI/BIOS device list.
- [ ] M.2 NVMe SSD secured with standoff screw; thermal pad applied.
- [ ] SATA data and power cables firmly latched.
- [ ] S.M.A.R.T. status reporting "Good" in CrystalDiskInfo.
- [ ] Windows Boot Manager set as Priority #1 in BIOS boot order.

### Section E: Thermals & Acoustics
- [ ] CPU idle temperature between 35°C and 45°C.
- [ ] CPU load temperature below 80°C.
- [ ] Case intake and exhaust fans spinning in correct airflow orientation (front in, rear/top out).
- [ ] Zero mechanical clicking or grinding sounds from hard drives.
- [ ] Zero high-pitched capacitor squeal (coil whine) from PSU or motherboard.

---

## 3. Hardware Fault Isolation Decision Matrix

| Observed Symptom | Most Probable Cause | First Verification Step | Recommended Corrective Action |
|---|---|---|---|
| Completely dead; no lights or fan twitch | PSU failed or AC outlet dead | Test outlet with lamp; check rear PSU switch | Replace PSU; test with power supply tester |
| Fans spin at 100%, black screen, no POST | Unseated RAM or CPU power cable loose | Inspect motherboard debug LEDs | Reseat RAM sticks in A2/B2 slots; reseat 8-pin EPS |
| Powers on for 2 seconds, immediately shuts off | Short circuit or severe CPU overheating | Check heatsink seating; check for loose screws | Remount CPU heatsink; inspect standoff alignment |
| 1 Long Beep, 2 Short Beeps | Video card initialization failed | Check PCIe seating | Reseat GPU; verify 8-pin PCIe power lead |
| Continuous reboots on Windows logo | Corrupted storage or RAM corruption | Boot Windows USB installer | Run `chkdsk /f` and `mdsched.exe` |
| CMOS date resets to 2015 on power loss | Dead CR2032 coin cell battery | Measure battery voltage with multimeter | Replace with fresh CR2032 battery |
| Screen displays multi-colored artifacts | Failing GPU VRAM or GPU overheating | Monitor GPU temps in HWiNFO64 | Clean GPU cooler; downclock or replace GPU |

## 4. Completion Status
Documented
