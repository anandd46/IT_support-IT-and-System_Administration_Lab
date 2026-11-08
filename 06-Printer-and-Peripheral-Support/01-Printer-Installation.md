# 01 — USB Printer Installation

**Status:** Documented  
**Module:** 06 — Printer and Peripheral Support

---

## Overview

Installing a USB printer is one of the most common helpdesk tasks. Modern versions of Windows include a large library of built-in drivers and can download additional drivers automatically through Windows Update. This guide covers the full process from physical connection through to printing a test page.

---

## Section 1 — What You Need Before You Start

Before beginning printer installation, gather the following:

- The printer and its USB cable (usually USB Type-A to USB Type-B)
- The power cable for the printer
- Administrator access on the Windows computer
- Internet access (for automatic driver download via Windows Update)
- Optionally: the printer manufacturer's driver disc or the driver file downloaded from the manufacturer's website

---

## Section 2 — Physical Connection

Follow these steps to physically connect the printer:

1. **Place the printer** on a stable, flat surface with adequate clearance for paper loading and output.
2. **Connect the power cable** from the printer to a wall outlet or power strip. Do not power on yet.
3. **Connect the USB cable** — plug the USB Type-B end into the printer's USB port and the USB Type-A end into an available USB port on the computer.
4. **Power on the printer** using its power button. Wait for the printer to initialise fully (indicator light should stop flashing and become steady).

> [!NOTE]
> USB printers should be connected directly to the computer's USB port when first installing, rather than through a USB hub. Hubs can sometimes cause driver detection issues during initial setup.

---

## Section 3 — Windows Automatic Driver Detection

Once the printer is powered on and connected via USB, Windows will typically detect it automatically:

1. A notification may appear in the system tray: **"Setting up a device"** or **"Device driver software installed successfully"**.
2. The printer will appear in **Settings > Bluetooth & devices > Printers & scanners**.
3. Windows uses **Windows Update** to download the appropriate driver in the background.
4. This process usually takes 1–3 minutes depending on internet speed.

If the printer installs successfully, you will see it listed by name under Printers & scanners with the status **"Ready"**.

---

## Section 4 — Manually Adding a Printer

If Windows does not automatically detect and install the printer, add it manually:

1. Open **Settings** (Windows key + I).
2. Navigate to **Bluetooth & devices > Printers & scanners**.
3. Click **Add device**.
4. Windows will scan for available printers and display a list.
5. If your printer appears in the list, click on it and click **Add device**.
6. If it does not appear, click **"The printer that I want isn't listed"** to open the manual add wizard.

---

## Section 5 — Adding a Printer Manually (Not Detected)

If the printer is not detected during the scan:

1. In the manual add wizard, select **"Add a local printer or network printer with manual settings"**.
2. Select the existing port: usually **USB001 (Virtual printer port for USB)** or the appropriate USB port.
3. Click **Next**.
4. Choose the **printer manufacturer and model** from the built-in driver list, or click **"Have Disk"** if you have the driver file.
5. Name the printer (use a descriptive name, e.g., `HP LaserJet Pro M404dn`).
6. Choose whether to share the printer.
7. Click **Finish**.

---

## Section 6 — Printing a Test Page

Always print a test page immediately after installation to confirm the printer is working correctly:

**Method 1 — From Settings:**
1. Go to **Settings > Bluetooth & devices > Printers & scanners**.
2. Click on the newly installed printer.
3. Click **Print a test page**.

**Method 2 — From Printer Properties:**
1. Go to **Control Panel > Hardware and Sound > Devices and Printers**.
2. Right-click the printer and select **Printer properties**.
3. On the **General** tab, click **Print Test Page**.

A test page will print, confirming the driver, connection, and printer are all working.

---

## Section 7 — Setting as Default Printer

To set the newly installed printer as the default:

1. Go to **Settings > Bluetooth & devices > Printers & scanners**.
2. Click on the printer.
3. Click **Set as default**.

Alternatively, disable **"Let Windows manage my default printer"** at the top of the Printers & scanners page, then manually set the default.

---

## Section 8 — PowerShell Printer Commands

The following PowerShell commands are useful for managing printers in a helpdesk environment:

```powershell
# View all installed printers on the system
Get-Printer

# View printer name, status, and driver details
Get-Printer | Select-Object Name, PrinterStatus, DriverName

# Set a printer's sharing state (disable sharing)
Set-Printer -Name "HP LaserJet" -Shared $false

# Print a test page via command line (replace printer name as needed)
(New-Object -ComObject WScript.Shell).Run('RUNDLL32 PRINTUI.DLL,PrintUIEntry /k /n "HP LaserJet"')

# View print jobs in the queue
Get-PrintJob -PrinterName "HP LaserJet"

# Remove a printer from the system
Remove-Printer -Name "HP LaserJet"
```

> [!TIP]
> Run PowerShell as Administrator when managing printers via command line to avoid permission errors.

---

## Section 9 — Key Troubleshooting Scenarios

### Driver Not Found
- Windows was unable to find a driver automatically.
- **Fix:** Download the driver manually from the manufacturer's website (see Section 10).
- Always download the driver that matches your Windows version and architecture.

### 32-bit vs 64-bit Driver Mismatch
- Installing a 32-bit driver on a 64-bit Windows system (or vice versa) will fail.
- **Fix:** Confirm Windows architecture: **Settings > System > About > System type**.
- Download the correct driver version: most modern systems use **Windows 11/10 64-bit**.

### USB Port Not Recognised
- Device Manager shows an error or the printer does not appear at all.
- **Fix steps:**
  1. Try a different USB port on the computer.
  2. Try a different USB cable.
  3. Open **Device Manager** and look for any devices with a yellow warning triangle.
  4. Right-click the device and select **Update driver** or **Uninstall device**, then reconnect.
  5. Check if the USB controller driver needs updating.

### Printer Installed but Not Printing
- Printer shows as installed but documents do not print.
- **Fix:** Check the print queue for stuck jobs, restart the Print Spooler service (see Module 06-04).

---

## Section 10 — Manufacturer Driver Download Websites

When Windows cannot find a driver automatically, download it directly from the manufacturer:

| Manufacturer | Support URL |
|---|---|
| HP | https://support.hp.com |
| Canon | https://usa.canon.com/support |
| Epson | https://www.epson.com/support |
| Brother | https://support.brother.com |
| Lexmark | https://www.lexmark.com/en_us/support.html |
| Samsung | https://www.samsung.com/us/support (many models now under HP) |
| Xerox | https://www.support.xerox.com |

**Steps when downloading a driver:**
1. Visit the manufacturer's support site.
2. Enter the full printer model number (found on the label on the printer itself).
3. Select **Windows** as the operating system.
4. Select the correct version (Windows 10 or Windows 11) and architecture (64-bit).
5. Download the **Full Driver Package** where available (includes all features, utilities, and scanning drivers).
6. Run the downloaded installer and follow the on-screen instructions.

---

## Summary

| Task | Method |
|---|---|
| Connect printer | USB cable from printer to PC, power on |
| Automatic install | Windows detects and downloads driver |
| Manual add | Settings > Printers & scanners > Add device |
| Test print | Printer properties > Print test page |
| PowerShell management | `Get-Printer`, `Set-Printer`, `Remove-Printer` |
| Driver source | Manufacturer support website |

---

*Last Updated: 2024 | Status: Documented | No physical printer used in documentation*
