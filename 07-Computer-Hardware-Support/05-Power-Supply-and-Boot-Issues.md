# Practical Task: Power Supply Unit (PSU) and Power-On Self Test (POST) Boot Diagnostics

## 1. Objective
Diagnose computer boot failures, isolate Power Supply Unit (PSU) faults, interpret motherboard POST beep codes and diagnostic debug LEDs, and test power switches.

## 2. Requirements
- Desktop PC chassis
- Digital multimeter or dedicated ATX power supply tester
- Motherboard speaker / diagnostic LEDs

## 3. Background
When the user presses the power button, the motherboard initiates the power-on sequence:
1. Motherboard pulls Green `PS_ON#` wire (Pin 16) to ground, signaling PSU to start.
2. PSU stabilizes outputs and sends a +5V `PWR_OK` (Power Good) signal (Pin 8) back to motherboard.
3. CPU executes UEFI/BIOS code from flash ROM.
4. **POST (Power-On Self Test):** Tests CPU, initializes memory controllers, verifies first 64KB RAM, and initializes GPU.
5. If POST succeeds: Single short beep emitted; display turns on; boot manager loads.
6. If POST fails: Diagnostic beep codes or motherboard debug LEDs (CPU, DRAM, VGA, BOOT) indicate the failed component.

## 4. Step-by-Step Procedure
1. **Initial Assessment (Completely Dead PC - No Fans, No Lights):**
   - Verify power cord, outlet voltage, and I/O switch on rear of PSU.
   - Inspect front panel power switch header on motherboard. Test shorting power switch pins momentarily with a flathead screwdriver to bypass a broken chassis button.
2. **PSU Paperclip Jump Test:**
   - Disconnect 24-pin ATX connector from motherboard.
   - Connect a fan as load.
   - Bridge Pin 16 (Green `PS_ON`) to any adjacent Black Ground pin with a jumper wire.
   - If PSU fan spins: PSU basic switching operational. If completely silent: PSU is dead.
3. **Motherboard Debug LED Analysis:** Observe 4 diagnostic LEDs (CPU, DRAM, VGA, BOOT):
   - Stuck on CPU: Processor missing, unseated, or 8-pin EPS cable disconnected.
   - Stuck on DRAM: RAM unseated or incompatible.
   - Stuck on VGA: Graphics card unseated or lacking PCIe power cables.
   - Stuck on BOOT: No bootable drive found.

## 5. Common POST Beep Codes Reference (Standard AMI BIOS)
| Beep Pattern | Diagnostic Meaning | Primary Action |
|---|---|---|
| 1 Short Beep | POST Successful | Normal operation |
| 1 Continuous Long Beep | Memory (RAM) failure | Reseat RAM; test one stick at a time |
| 1 Long, 2 or 3 Short Beeps | Video card failure | Reseat GPU; verify monitor cable |
| Continuous Rapid Beeps | Power supply or motherboard fault | Test PSU voltages |
| No Beeps / Silence | Dead PSU, dead motherboard, or speaker disconnected | Perform PSU paperclip test |

## 6. Expected Result
The technician identifies the exact point of boot failure within 3 minutes and replaces the defective component.

## 7. Safety Precautions
- Disconnect AC power before plugging/unplugging internal motherboard power connectors.
- Never test power components on wet surfaces or in humid environments.

## 8. Screenshots / Evidence
- `screenshots/05-debug-leds-motherboard.png` — *Pending lab execution: Capture motherboard diagnostic LEDs.*

## 9. Practical Learning Outcome
Mastery in power-on sequencing, interpreting POST hardware diagnostic indicators, and isolating electrical boot failures.

## 10. Completion Status
Documented
