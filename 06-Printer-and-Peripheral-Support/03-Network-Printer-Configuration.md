# 03 — Network Printer Configuration

**Status:** Documented  
**Module:** 06 — Printer and Peripheral Support

---

## Overview

Network printing allows multiple computers to share a single printer over a local area network (LAN). This guide covers IP-based network printer setup, shared printer access, PowerShell commands, and troubleshooting common network printer problems.

---

## Section 1 — IP-Based vs Shared Printer

There are two primary methods to connect to a network printer:

| Method | Description | Best For |
|---|---|---|
| **IP-Based (Direct TCP/IP)** | Connect directly to the printer's IP address | Standalone network printers with built-in network cards |
| **Shared Printer** | Connect through another PC that has the printer attached | Small offices sharing a USB-connected printer |

**IP-based printing** is more reliable and does not depend on another computer being powered on. It is the preferred method in professional environments.

**Shared printing** is simpler to set up for small home/office networks but requires the host PC to be running and the printer sharing feature to be enabled.

---

## Section 2 — Finding the Printer's IP Address

Before adding a network printer, you need its IP address. There are several ways to find it:

### Method 1 — Printer Control Panel
Most network printers have a small LCD or display panel. Navigate to:
- **Network Settings** or **Network Information** in the printer menu.
- The IPv4 address will be displayed.

### Method 2 — Print a Configuration/Network Page
Almost all network printers can print a configuration page directly:
- Press and hold the printer's information or settings button (varies by model).
- This page shows IP address, subnet mask, gateway, and MAC address.

### Method 3 — Router DHCP Table
1. Log in to your router's admin page (typically `192.168.1.1` or `192.168.0.1`).
2. Navigate to **DHCP Client List** or **Connected Devices**.
3. Find the printer by its MAC address or hostname (e.g., `HP-LaserJet-Pro`).
4. Note the assigned IP address.

### Method 4 — Ping Broadcast and ARP
```cmd
# Ping broadcast to populate ARP table, then view
ping 192.168.1.255
arp -a
```

---

## Section 3 — Setting a Static IP on the Printer (Recommended)

By default, printers receive a dynamic IP address from the DHCP server (router). If the IP changes, Windows will lose the printer connection. It is strongly recommended to assign a **static IP address** to network printers.

**Method 1 — Set via printer control panel:**
1. Access the printer's network settings menu.
2. Navigate to: **Network > TCP/IP Settings > IP Address Method**.
3. Change from **DHCP/Automatic** to **Manual/Static**.
4. Enter the desired IP address (e.g., `192.168.1.20`), subnet mask (`255.255.255.0`), and default gateway.
5. Save and reboot the printer.

**Method 2 — Set via printer web interface:**
1. Open a web browser and type the printer's current IP address.
2. Log in with admin credentials (default is often `admin/admin` or printed on the device).
3. Navigate to **Network Settings > IP Configuration**.
4. Set to **Manual** and enter the static IP details.
5. Apply and reboot.

> [!TIP]
> Choose a static IP address outside the DHCP pool range to avoid conflicts. For example, if your DHCP range is `192.168.1.100–200`, use `192.168.1.20` for printers.

---

## Section 4 — Adding a Network Printer via IP Address (Windows GUI)

1. Open **Settings** (Windows key + I).
2. Navigate to **Bluetooth & devices > Printers & scanners**.
3. Click **Add device**.
4. Wait for the scan to complete. If the printer appears, click it and select **Add device**.
5. If the printer is not found automatically, click **"The printer that I want isn't listed"**.
6. Select **"Add a printer using an IP address or hostname"** and click **Next**.
7. In the **Device type** field, leave as **"TCP/IP Device"**.
8. Enter the printer's **IP address** or **hostname** (e.g., `192.168.1.20` or `printer-finance.local`).
9. Leave **Port name** to auto-populate.
10. Click **Next** and allow Windows to query the printer.
11. If a driver is not automatically selected, choose the correct driver from the list or click **Have Disk**.
12. Name the printer (use a descriptive name, e.g., `Finance-HP-LaserJet`).
13. Print a test page to confirm connectivity.

---

## Section 5 — Connecting to a Shared Printer from Another PC

If a printer is shared from another Windows computer on the network:

### Method 1 — Browse (GUI)
1. Go to **Settings > Bluetooth & devices > Printers & scanners > Add device**.
2. Click **"The printer that I want isn't listed"**.
3. Select **"Select a shared printer by name"**.
4. Click **Browse** to browse the network for available shared printers.
5. Navigate to the host computer and select the shared printer.
6. Click **Select** and then **Next**.

### Method 2 — Direct UNC Path
1. Press **Windows + R**, type the UNC path, and press Enter:
   ```
   \\COMPUTERNAME\PrinterShareName
   ```
   Example: `\\WORKSTATION01\HP-Office`
2. Windows will prompt to install the driver and add the printer automatically.

> [!NOTE]
> The host PC must have printer sharing enabled: **Control Panel > Network and Sharing Center > Advanced sharing settings > Turn on file and printer sharing**.

---

## Section 6 — PowerShell Network Printer Commands

PowerShell provides efficient methods for adding and managing network printers — especially useful when deploying printers to multiple computers:

```powershell
# Add a shared printer from a print server
Add-Printer -ConnectionName "\\SERVER01\HP-Office-Printer"

# Add a network printer via IP address (manual method)
# Step 1: Create the TCP/IP port
Add-PrinterPort -Name "192.168.1.20" -PrinterHostAddress "192.168.1.20"

# Step 2: Ensure the driver is installed (or install it)
Add-PrinterDriver -Name "HP Universal Printing PCL 6"

# Step 3: Add the printer using the port and driver
Add-Printer -Name "HP Network Printer" -DriverName "HP Universal Printing PCL 6" -PortName "192.168.1.20"

# Verify the printer was added
Get-Printer -Name "HP Network Printer" | Select-Object Name, PortName, DriverName, PrinterStatus

# Remove a network printer
Remove-Printer -Name "HP Network Printer"

# Remove the printer port when no longer needed
Remove-PrinterPort -Name "192.168.1.20"
```

> [!TIP]
> The `Add-Printer -ConnectionName` method (connecting to a shared printer) automatically installs the driver from the print server — no need to install the driver separately.

---

## Section 7 — Troubleshooting Network Printer Connections

### Cannot Connect to Printer (IP-Based)

| Check | Action |
|---|---|
| Can you ping the printer? | Run `ping 192.168.1.20` — if no reply, check network cable on printer or Wi-Fi |
| Is the port number correct? | Standard TCP/IP printing uses port 9100; verify with manufacturer |
| Firewall blocking? | Check Windows Firewall is not blocking print traffic |
| IP address changed? | Re-confirm printer IP; consider setting static IP |

### Access Denied When Connecting to Shared Printer

- The user account may not have permission to use the shared printer.
- **Fix:** On the host PC, right-click the printer > **Printer properties > Security tab** > add the user or **Everyone** with Print permission.
- May require entering network credentials if the host PC is in a different workgroup.

### Wrong Credentials

- When connecting to a shared printer on another PC, Windows may prompt for credentials.
- Use the **username and password of an account on the host PC**.
- In a domain environment, use domain credentials: `DOMAIN\Username`.

### Printer Shows as Offline Despite Network Connection

- The printer's TCP/IP port setting may need updating.
- Check **Devices and Printers > Right-click printer > Printer properties > Ports tab** — verify the IP address matches the printer's current IP.

---

## Section 8 — Printer Port Types

| Port Type | Description | Use Case |
|---|---|---|
| **Standard TCP/IP Port** | Direct IP connection to printer | Most network printers |
| **WSD Port** | Web Services for Devices — auto-discovery | Printers that support WSD |
| **USB Port** | Local USB connection | USB-attached printers |
| **LPT Port** | Legacy parallel port | Very old printers only |

---

## Summary

| Task | Method |
|---|---|
| Find printer IP | Printer control panel, config page, router DHCP table |
| Set static IP | Printer web interface or control panel |
| Add via IP (GUI) | Settings > Printers > Add > IP address or hostname |
| Add shared printer | \\COMPUTERNAME\ShareName or browse network |
| PowerShell add | `Add-Printer`, `Add-PrinterPort`, `Add-PrinterDriver` |
| Troubleshoot offline | Verify IP, ping test, check port settings |

---

*Last Updated: 2024 | Status: Documented | No physical network printer used in documentation*
