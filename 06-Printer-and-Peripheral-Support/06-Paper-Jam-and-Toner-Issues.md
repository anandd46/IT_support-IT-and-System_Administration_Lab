# Practical Task: Paper Jams, Fuser Errors, and Consumables Replacement

## 1. Objective
Safely clear internal paper jams across all printer feed paths, identify fuser/roller wear, perform routine consumable replacements (toner, imaging drum, waste toner box), and reset maintenance counters.

## 2. Requirements
- Laser printer or multifunction peripheral (MFP)
- Replacement toner cartridge and waste container
- Personal protective equipment (lint-free gloves, microfibre cloth)

## 3. Background
Mechanical components in enterprise laser printers endure extreme thermal and frictional stress. Technicians must understand the laser printing process:
1. **Charging:** Primary charge roller gives drum negative charge.
2. **Exposing:** Laser writes electrostatic latent image.
3. **Developing:** Toner adheres to discharged areas.
4. **Transferring:** High-voltage transfer roller transfers toner to paper.
5. **Fusing:** Heated fuser roller (180°C - 200°C) melts toner into paper fibers under pressure.
6. **Cleaning:** Blade wipes excess toner into waste box.

Paper jams occur when pickup rollers become glazed, paper is damp or fanned incorrectly, or paper fragments obstruct path sensors.

## 4. Step-by-Step Procedure
1. **Power & Safety:** Power off printer and wait 15 minutes if accessing the fuser assembly (extremely high temperature burn hazard).
2. **Safe Paper Extraction:**
   - Open Tray 1, Tray 2, and Rear Duplex Door.
   - **CRITICAL:** Always pull jammed paper gently in the normal direction of paper travel. Never yank backward, which shreds paper and leaves fragments behind optical sensors.
3. **Inspect Optical Sensors & Rollers:** Inspect rubber pickup rollers. Clean glazed rubber using a lint-free cloth dampened with isopropyl alcohol.
4. **Toner Cartridge Replacement:**
   - Remove spent toner cartridge; place directly in recycling bag (avoid skin contact).
   - Unpack new cartridge; gently rock horizontally 5-6 times to evenly distribute toner powder.
   - Remove protective plastic sealing tape completely before insertion.
5. **Print Engine Self-Test:** Print an internal Engine Test / Configuration Page directly from the hardware control panel without relying on Windows.

## 5. Commands Used

### Command 1: Print Clean Test Page via Windows
```cmd
RUNDLL32.EXE PRINTUI.DLL,PrintUIEntry /k /n "HP LaserJet Pro"
```
- **What it does:** Spools a clean Windows printer test page to confirm complete image transfer and fusing.

### Command 2: Query Consumables Status via SNMP (Linux / Net-SNMP)
```bash
snmpwalk -v 2c -c public 192.168.100.50 1.3.6.1.2.1.43.11.1.1
```
- **What it does:** Queries printer MIB for remaining toner percentage and waste container capacity over the network.

## 6. Expected Result
Jammed media is extracted without roller damage, new toner is initialized, and test pages print with crisp, streak-free text.

## 7. Troubleshooting
- **Issue: Repeated jams at the entrance of the fuser unit:**
  - *Cause:* Worn pickup rollers slipping or defective fuser drive gear.
  - *Solution:* Replace feed roller assembly; check fuser temperature error codes on LCD.

## 8. Screenshots / Evidence
- `screenshots/06-printer-paper-jam-lcd.png` — *Pending lab execution: Capture printer LCD error display.*
- `screenshots/06-clean-test-page.png` — *Pending lab execution: Capture printed test page evidence.*

## 9. Practical Learning Outcome
Competence in diagnosing physical print engine faults, executing safe jam extraction, and handling electrophotographic consumables.

## 10. Completion Status
Documented
