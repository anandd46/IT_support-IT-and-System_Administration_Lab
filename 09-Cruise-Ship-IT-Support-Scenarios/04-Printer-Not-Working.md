# Scenario 04: Shore Excursions Desk Network Printer Offline

## 1. Scenario Description
With 400 guests waiting in the main lounge to disembark for shore excursions in port, the Shore Excursions desk network printer goes offline. Staff are unable to print excursion tour tickets and guest manifests.

## 2. Possible Causes
1. Paper tray empty or paper jam in fuser.
2. Network patch cable dislodged by desk movement.
3. Printer IP address changed due to DHCP reservation expiration.
4. Print Spooler on local print server crashed or queue deadlocked.
5. Windows SNMP status polling falsely reporting offline.

## 3. Initial Diagnosis
- Rapid physical inspection: Printer power light is solid green. LCD reports "Ready". Paper Tray 2 is full.
- From Shore Excursions PC, open Command Prompt and ping printer IP: `ping 192.168.40.50` -> **Packets respond with <1ms latency!**
- Deduction: Physical printer and network connection are 100% healthy. The problem is purely within the Windows print queue / spooler software stack.

## 4. Troubleshooting Procedure
1. **Inspect Print Queue:** Open print queue. Find 14 documents queued; the first document shows status "Error - Printing".
2. **Clear Stuck Spooler Files:**
   - Open elevated Command Prompt on the PC.
   - Stop Print Spooler: `net stop spooler`.
   - Delete stuck spool files: `del /Q /F /S "%systemroot%\System32\spool\PRINTERS\*"`.
   - Restart Print Spooler: `net start spooler`.
3. **Disable SNMP Status Polling:**
   - In Printer Properties > Ports tab > Select port `192.168.40.50` > Click Configure Port.
   - Uncheck `SNMP Status Enabled`. Click OK.
4. **Trigger Test Print:** Print a single test page. Page prints immediately.
5. **Re-print Guest Manifest:** Staff re-send the manifest document; tickets print successfully.

## 5. Commands and Tools Used
```cmd
net stop spooler
del /Q /F /S "%systemroot%\System32\spool\PRINTERS\*"
net start spooler
```

## 6. Resolution
Cleared corrupted print spool file locking the queue, disabled SNMP status polling to prevent false offline flags, restarted spooler service, and verified live printing.

## 7. When to Escalate
- If the printer exhibits recurring mechanical drum failure or physical board breakdown during guest disembarkation, immediately re-route the print queue to an adjacent Guest Services printer.

## 8. Preventive Measures
1. Configure a secondary backup network printer mapped on all excursion desks.
2. Train staff on simple queue checks.

## 9. Sample Completed Incident Report
- **Incident ID:** INC-2024-0315
- **Priority:** P2 (High)
- **Time to Resolve:** 8 Minutes
- **Technician:** Anand D (IT Systems Assistant)

## 10. Completion Status
Documented
