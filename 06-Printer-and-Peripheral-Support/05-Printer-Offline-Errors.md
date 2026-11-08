# Practical Task: Printer Offline Errors and SNMP Status Troubleshooting

## 1. Objective
Diagnose and resolve persistent "Printer Offline" error states in Windows 11, configure Simple Network Management Protocol (SNMP) status settings, and verify bidirectional printer communication.

## 2. Requirements
- Windows 11 client with networked or local printer
- Administrator privileges
- Tools: Print Management console (`printmanagement.msc`), PowerShell, ping

## 3. Background
"Printer Offline" is one of the highest-volume printer incidents reported to IT helpdesks. An offline status can stem from four distinct problem domains:
1. **Physical / Environmental:** Printer powered off, sleeping aggressively, loose Ethernet/USB cable, or internal hardware error.
2. **Network / Addressing:** IP address mismatch (printer IP changed due to DHCP lease expiration while Windows port configuration remains static).
3. **SNMP Protocol Anomaly:** Windows Print Spooler periodically polls the printer using SNMP Community `public` over UDP Port 161. If the printer's SNMP community differs or a switch/firewall drops UDP 161, Windows falsely flags the printer as offline even though raw printing over Port 9100 works.
4. **Spooler State:** Stale spooler cache or manual toggle to "Use Printer Offline".

## 4. Step-by-Step Procedure
1. **Physical & Network Verification:** Verify printer power LED, check paper tray, and verify link light. Ping the printer's IP address (`ping 192.168.100.50`).
2. **Disable "Use Printer Offline":** Open Settings > Bluetooth & devices > Printers & scanners > Click printer > Open print queue > Click Printer menu > Ensure `Use Printer Offline` is unchecked.
3. **Disable SNMP Status Enabled:**
   - In `printmanagement.msc` or Printer Properties > Ports tab.
   - Select active Standard TCP/IP Port > Click `Configure Port...`.
   - Uncheck `SNMP Status Enabled` (prevents false offline flags).
4. **Restart Print Spooler:** Restart spooler via PowerShell or Command Prompt.
5. **Port IP Alignment:** If printer received a new DHCP IP, update the TCP/IP port settings to match or assign a persistent static reservation.

## 5. Commands Used

### Command 1: Inspect Printer Status via PowerShell
```powershell
Get-Printer | Select-Object Name, PrinterStatus, PortName, DriverName
```
- **What it does:** Displays all installed printers and their active operational status.

### Command 2: Restart Spooler Service
```powershell
Restart-Service -Name Spooler -Force
```
- **What it does:** Stops and immediately restarts the Print Spooler service, clearing memory deadlocks.

### Command 3: Test Raw Printing Port (Port 9100)
```powershell
Test-NetConnection -ComputerName 192.168.100.50 -Port 9100
```
- **What it does:** Verifies that the printer's raw JetDirect listening socket is reachable through the network.

## 6. Expected Result
The printer status changes from "Offline" to "Ready", and queued documents begin printing immediately.

## 7. Troubleshooting
- **Issue: Printer shows offline every morning until physically rebooted:**
  - *Cause:* Aggressive deep-sleep energy mode on printer NIC disables response to ARP requests.
  - *Solution:* Access printer web administration page (HTTP); disable Deep Sleep Mode or set energy timeout to "Never".

## 8. Screenshots / Evidence
- `screenshots/05-printer-offline-error.png` — *Pending lab execution: Capture printer offline status.*
- `screenshots/05-snmp-uncheck-dialog.png` — *Pending lab execution: Capture Port configuration dialog.*

## 9. Practical Learning Outcome
Ability to systematically isolate physical, network, and protocol-level SNMP causes behind printer offline faults.

## 10. Completion Status
Documented
