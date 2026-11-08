# Practical Task: Device Manager and Hardware Driver Administration

## 1. Objective
Demonstrate hardware peripheral diagnostics, driver installation, driver rollback, signed driver verification, and troubleshooting unknown devices in Windows 11.

## 2. Requirements
- Windows 11 workstation
- Administrative rights
- Hardware peripherals (network card, audio device, display adapter, or USB peripherals)
- Tools: Device Manager (`devmgmt.msc`), PnPUtil command line

## 3. Background
Hardware drivers serve as the software translation bridge between the Windows Kernel and physical hardware controllers. Driver corruption, incorrect OEM revisions, or failed automatic updates manifest as blue screens (BSOD), peripheral failure, network loss, or sound dysfunction.

Device Manager status symbols:
- **Yellow Exclamation Triangle (!):** Device detected but driver missing, corrupt, or device reporting error code (e.g., Code 10, Code 43).
- **Red X / Black Down Arrow:** Device physically or logically disabled by administrator.
- **Unknown Device:** Windows cannot resolve Hardware ID against driver repository or Windows Update.

## 4. Step-by-Step Procedure
1. **Launch Device Manager:** Press Win + X and select Device Manager or run `devmgmt.msc`.
2. **Scan for Hardware Changes:** Select the root computer node and click Action > Scan for hardware changes.
3. **Inspect Hardware IDs:** Right-click an unknown device > Properties > Details tab > Select `Hardware Ids`. Note `VEN_xxxx` (Vendor ID) and `DEV_xxxx` (Device ID).
4. **Update Driver:** Right-click device > Update driver > Choose between automatic search or manual browsing (`C:\Drivers`).
5. **Roll Back Driver:** If a newly updated driver causes instability, navigate to Properties > Driver tab > Click `Roll Back Driver`.
6. **Disable / Re-enable Adapter:** Test hardware re-initialization by disabling and re-enabling an onboard adapter.
7. **Manage Driver Store via PnPUtil:** List third-party OEM drivers using command prompt.

## 5. Commands Used

### Command 1: Launch Device Manager
```cmd
devmgmt.msc
```
- **What it does:** Opens the Device Manager Microsoft Management Console.
- **Why it is used:** Direct execution saves time when navigating Windows 11 settings hierarchy.

### Command 2: PnPUtil - Inspect Third-Party Drivers
```cmd
pnputil /enum-drivers
```
- **What it does:** Displays all third-party (OEM) driver packages stored in the Windows Driver Store (`oem#.inf`).
- **Why it is used:** Allows technicians to identify installed driver versions, dates, and package providers.

### Command 3: PnPUtil - Export / Backup Drivers
```cmd
pnputil /export-driver * C:\DriverBackup
```
- **What it does:** Exports all installed third-party drivers into a designated backup directory.
- **Why it is used:** Critical step before system re-imaging or motherboard upgrades, ensuring legacy peripheral drivers are preserved.

## 6. Expected Result
All hardware devices in Device Manager display clean status without error badges. Outdated or faulty drivers are rolled back or updated, and unknown devices are identified using Vendor/Device IDs.

## 7. Troubleshooting
- **Issue: Device displays "Code 10: This device cannot start":**
  - *Cause:* Driver outdated, corrupted configuration, or hardware malfunction.
  - *Solution:* Uninstall device, restart computer to allow Windows to re-enumerate hardware, and install certified OEM driver.
- **Issue: Device displays "Code 43: Windows has stopped this device because it has reported problems":**
  - *Cause:* Common on GPUs and USB controllers; indicates firmware mismatch, physical loose connection, or hardware defect.
  - *Solution:* Power cycle machine completely (discharge capacitors), update motherboard BIOS, and reseat PCIe/USB connection.

## 8. Screenshots / Evidence
- `screenshots/04-device-manager-overview.png` — *Pending lab execution: Capture clean Device Manager tree.*
- `screenshots/04-hardware-id-lookup.png` — *Pending lab execution: Capture Hardware IDs property window.*
- `screenshots/04-pnputil-export.png` — *Pending lab execution: Capture PnPUtil driver enumeration.*

## 9. Practical Learning Outcome
Ability to diagnose hardware faults at the driver layer, identify unknown peripherals via PCI/USB hardware IDs, execute safe rollbacks, and manage the Windows driver store.

## 10. Completion Status
Documented
