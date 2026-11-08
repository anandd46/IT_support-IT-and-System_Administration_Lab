# Technical Interview Preparation: Printer and Peripheral Support

### Q1: A network printer is physically powered on and connected to the switch, but users cannot print and it shows "Offline" in Windows. How do you troubleshoot this step by step?
**A:**
1. **Physical & Network Check:** Verify link lights on printer NIC and switch port. Print an internal Configuration/Network Page directly from the printer's hardware control panel to confirm its active IP address.
2. **Ping Test:** Ping the printer IP from a workstation: `ping 192.168.100.50`. If it fails, the printer's IP may have changed via DHCP (re-align port IP or configure static reservation).
3. **Queue Check:** Open Windows print queue. Verify that "Use Printer Offline" is not checked under the Printer menu.
4. **SNMP Status Verification:** In Printer Properties > Ports tab > Configure Port, uncheck `SNMP Status Enabled`. If the printer community string differs or firewalls block UDP 161, Windows falsely flags the printer as offline.
5. **Restart Print Spooler:** Run `net stop spooler` followed by `net start spooler` to clear stuck spool threads.

### Q2: How do you manually clear a print queue that has a stuck document refusing to delete?
**A:** When a print job crashes, it locks the spool file on disk. Attempting to click "Cancel" in the GUI frequently hangs. The industry-standard resolution:
```cmd
net stop spooler
del /Q /F /S "%systemroot%\System32\spool\PRINTERS\*"
net start spooler
```
This stops the service, deletes the corrupted `.SHD` (shadow) and `.SPL` (spool data) files from disk, and restarts the service cleanly.

### Q3: What is the difference between a PCL driver and a PostScript (PS) driver?
**A:** PCL (Printer Command Language, developed by HP) is widely used in standard office environments. It processes print rendering partially on the client workstation, resulting in faster initial page output and smaller spool files for standard text documents. PostScript (developed by Adobe) is an object-oriented page description language that renders the page entirely inside the printer's onboard processor; it provides exact color fidelity, vector geometry rendering, and cross-platform consistency, making it the standard for desktop publishing and graphic design.

### Q4: What causes recurring paper jams at the intake paper tray, and how do you fix it?
**A:**
- **Causes:** Glazed or worn rubber pickup rollers that slip against paper; overloaded paper trays; curled or damp paper caused by high humidity; or small torn paper scraps obstructing optical flag sensors.
- **Remediation:** Remove paper tray; clean rubber pickup and separation rollers using a lint-free cloth dampened with isopropyl alcohol to restore rubber tackiness; fan the paper ream before loading to prevent static bonding; ensure tray guides are adjusted snug against paper edges without bending sheets; and replace worn pickup roller assemblies if rubber is smooth/cracked.

### Q5: How do you install a network printer via its IP address using PowerShell?
**A:**
```powershell
Add-PrinterPort -Name "IP_192.168.100.50" -PrinterHostAddress "192.168.100.50"
Add-PrinterDriver -Name "HP Universal Printing PCL 6"
Add-Printer -Name "HP LaserJet Pro" -DriverName "HP Universal Printing PCL 6" -PortName "IP_192.168.100.50"
```
