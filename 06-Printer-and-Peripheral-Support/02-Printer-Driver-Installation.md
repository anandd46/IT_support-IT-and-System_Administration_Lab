# 02 — Printer Driver Installation and Management

**Status:** Documented  
**Module:** 06 — Printer and Peripheral Support

---

## Overview

A printer driver is the essential software layer between Windows and the physical printer. Without the correct driver, Windows cannot communicate with the printer. This guide covers what a printer driver is, how to identify the correct driver, how to install it, and how to manage and roll back drivers when needed.

---

## Section 1 — What Is a Printer Driver?

A **printer driver** is a software program that acts as a translator between the operating system and the printer hardware. When you send a document to print:

1. The application (e.g., Microsoft Word) generates print data.
2. Windows passes that data to the **printer driver**.
3. The driver translates the print data into a language the printer understands (e.g., PCL, PostScript, or the manufacturer's proprietary format).
4. The translated data is sent to the printer via USB, network, or Bluetooth.
5. The printer produces the physical output.

**Without the correct driver:**
- The printer may not appear in Windows at all.
- Documents may print as garbled characters.
- Advanced features (duplex, stapling, colour settings) will not be available.
- The printer may show as an "Unknown device" in Device Manager.

---

## Section 2 — Identifying the Exact Printer Model

Before downloading any driver, you must confirm the exact printer model number. The same manufacturer may have dozens of similar-sounding models with different drivers.

**Where to find the printer model:**
- **Label on the printer body** — usually on the front, top, or underside of the device.
- **Configuration/information page** — most printers can print a self-test or configuration page from the control panel menu without a connected computer.
- **Printer control panel display** — many printers display the model in the menu.
- **Device Manager in Windows** — right-click the printer > Properties > Details.

> [!IMPORTANT]
> Write down the **full model number** including any suffixes. For example, "HP LaserJet Pro M404dn" — the "dn" suffix indicates duplex and network capabilities. Using the wrong variant may install a driver missing key features.

---

## Section 3 — Finding Drivers on Manufacturer Websites

Each major manufacturer provides a dedicated support portal for driver downloads. Always use the **official manufacturer website** — never download drivers from third-party sites.

### HP (Hewlett-Packard)
- **URL:** https://support.hp.com
- Navigate to: **Support > Software and Drivers**
- Enter the printer model in the search box
- HP also offers the **HP Smart** app for simplified installation

### Canon
- **URL:** https://usa.canon.com/support
- Select **Printers** from the product category
- Search by model number
- Canon provides both full and basic driver packages

### Epson
- **URL:** https://www.epson.com/support
- Search by product name or browse by category
- Epson's **EpsonNet Setup** utility assists with network printer configuration

### Brother
- **URL:** https://support.brother.com
- Enter model number on the main page
- Brother provides separate drivers for printing and scanning

### General Driver Search Steps

1. Navigate to the manufacturer's support site.
2. Enter the **full printer model number**.
3. Select **Drivers & Downloads** (naming varies by manufacturer).
4. Select your operating system: **Windows 10** or **Windows 11**.
5. Select architecture: **64-bit** (the standard for all modern PCs).
6. Review available driver packages and select the appropriate type (see Section 4).
7. Click Download and save the file.
8. Run the installer as Administrator.

---

## Section 4 — Choosing the Correct Driver Type

Manufacturer sites often offer multiple driver packages for the same printer:

| Driver Type | Description | When to Use |
|---|---|---|
| **Full Driver Package** | Complete installation including all features, scanning, utilities, and status monitor | Preferred for standalone workstations with the printer connected directly |
| **Basic Driver (Print Only)** | Minimal driver — printing only, no scanning or status utilities | Useful when you only need printing and want a smaller install |
| **Universal Print Driver (UPD)** | One driver that works across many models from the same manufacturer | Corporate environments with multiple printer models |
| **PCL Driver** | Printer Command Language — standard language, broad compatibility | Most office printing |
| **PostScript Driver** | High-quality output, used in graphic design and publishing | Graphic-intensive work, PDF printing |

---

## Section 5 — Universal Print Driver (HP UPD)

The **HP Universal Print Driver (UPD)** is an example of a universal driver concept supported by several manufacturers. Instead of installing a separate driver for each HP model, one driver supports a wide range of HP laser printers.

**Benefits of Universal Print Driver:**
- Reduces IT workload in environments with many printer models.
- Simplifies driver management and updates.
- Supports dynamic mode (connects to any HP printer on the network automatically).
- Reduces compatibility issues when printers are replaced.

**Limitations:**
- May not support all advanced features of specific models.
- Not recommended for specialty printers (photo printers, label printers).

HP UPD is available at: https://support.hp.com (search "HP Universal Print Driver")

---

## Section 6 — Driver Installation Process

Once the driver file has been downloaded:

1. **Close all open applications** to avoid conflicts during installation.
2. **Run the installer** — right-click the downloaded `.exe` file and select **Run as administrator**.
3. **Accept the license agreement** if prompted.
4. **Choose installation type** — select **Full Installation** unless you have a specific reason to choose basic.
5. **Connect the printer when prompted** — the wizard will tell you when to plug in the USB cable.
6. **Complete the installation** — the installer will configure the driver and add the printer to Windows.
7. **Print a test page** when prompted, or do so manually from Printer Properties.

---

## Section 7 — Verifying Driver Installation

After installation, verify the driver is correctly installed:

```powershell
# List all installed printer drivers with their environment (architecture)
Get-PrinterDriver | Select-Object Name, PrinterEnvironment, MajorVersion

# View all installed printers and their associated drivers
Get-Printer | Select-Object Name, DriverName, PrinterStatus
```

You can also verify via **Device Manager**:
1. Press **Windows + X > Device Manager**.
2. Expand **Printers**.
3. Right-click the printer > **Properties > Driver** tab.
4. Confirm the driver version and date are as expected.

---

## Section 8 — Rolling Back a Printer Driver

If a driver update causes problems (printer stops working, produces errors), roll back to the previous driver:

**Via Device Manager:**
1. Press **Windows + X** and select **Device Manager**.
2. Expand the **Printers** section.
3. Right-click the affected printer and select **Properties**.
4. Click the **Driver** tab.
5. Click **Roll Back Driver** (this option is only available if a previous driver is stored).
6. Select a reason from the prompted list and click **Yes**.
7. Restart the computer if prompted.

> [!NOTE]
> The **Roll Back Driver** option will be greyed out if no previous driver version is stored. In that case, uninstall the current driver and manually install an older version from the manufacturer's website.

---

## Section 9 — Removing a Printer Driver

When retiring a printer or resolving a driver conflict, remove the driver completely:

**Step 1 — Remove the printer:**
1. Go to **Settings > Bluetooth & devices > Printers & scanners**.
2. Click the printer > **Remove**.

**Step 2 — Remove the driver from the driver store:**
```powershell
# View all installed printer drivers
Get-PrinterDriver | Select-Object Name, PrinterEnvironment

# Remove a specific printer driver (replace name as appropriate)
Remove-PrinterDriver -Name "HP LaserJet Pro M404 PCL-6" -ErrorAction SilentlyContinue
```

**Step 3 — Full clean via Print Management (optional):**
1. Open **Print Management** (run `printmanagement.msc`).
2. Navigate to **Drivers**.
3. Right-click the driver and select **Delete**.

---

## Section 10 — The Windows Driver Store

Windows maintains a local repository of drivers called the **Driver Store**. When a driver is installed, Windows copies it here for future use:

**Location:** `C:\Windows\System32\DriverStore\FileRepository`

Each driver is stored in a subfolder named after the driver `.inf` file. When Windows detects a device, it first checks this store before going to Windows Update.

**Driver Store commands:**
```powershell
# View staged drivers in the driver store using DISM
# (Run as Administrator)
DISM /Online /Get-Drivers /All | Select-String "HP"

# Remove a driver from the driver store (use driver .inf filename)
# pnputil /delete-driver oem15.inf /uninstall /force
```

> [!CAUTION]
> Do not manually delete files from the DriverStore folder. Use `pnputil` or Device Manager to safely remove drivers.

---

## Section 11 — Common Driver Issues and Fixes

| Issue | Likely Cause | Fix |
|---|---|---|
| Driver not found during install | Incompatible driver or internet offline | Download from manufacturer website |
| Printer shows "Driver unavailable" | Driver corrupted or removed | Reinstall driver |
| Wrong driver installed | Incorrect model selected | Uninstall and reinstall correct driver |
| Driver install fails with error code | Conflicting existing driver | Remove old driver first, then install |
| 64-bit driver on 32-bit system (or reverse) | Architecture mismatch | Confirm system architecture and download correct version |
| Driver installs but no features | Basic driver installed | Install Full Driver Package |

---

## Summary

| Task | Method |
|---|---|
| Find model number | Label on printer body or printer info page |
| Download driver | Manufacturer's official support website |
| Choose driver type | Full package preferred; UPD for multi-printer environments |
| Verify installation | `Get-PrinterDriver` in PowerShell or Device Manager |
| Roll back driver | Device Manager > Printer > Properties > Driver > Roll Back |
| Remove driver | `Remove-PrinterDriver` or Print Management console |

---

*Last Updated: 2024 | Status: Documented | No physical printer used in documentation*
