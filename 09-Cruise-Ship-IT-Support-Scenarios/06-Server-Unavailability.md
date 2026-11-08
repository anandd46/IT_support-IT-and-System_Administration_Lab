# Scenario 06: Core IT Server Room Host Unavailability (Critical P1 Outage)

## 1. Scenario Description
At 03:00 UTC at sea, automated monitoring alarms trigger and the Night Auditor calls the IT duty phone: all shipboard intranet services, file shares, and domain authentication are unresponsive. P1 Emergency Outage declared.

## 2. Possible Causes
1. Total AC power failure or tripped breaker in IT Server Room.
2. Uninterruptible Power Supply (UPS) battery failure or shutdown.
3. Server hardware failure (motherboard, dual PSU burnout, RAM panic).
4. Storage volume failure or RAID array collapse.
5. Hypervisor kernel crash or operating system blue screen.

## 3. Initial Diagnosis
1. **Immediate Physical Attendance:** Arrive in IT Server Room within 5 minutes.
2. **Environmental & Power Check:**
   - Server room air conditioning is running (20°C).
   - Rack PDUs display active green LEDs (mains power healthy).
   - APC Smart-UPS displays online power with 100% battery capacity.
3. **Physical Server Console Inspection:**
   - Server chassis fans are spinning at 100% RPM.
   - Front LCD panel displays blue screen stop code: `KERNEL_DATA_INPAGE_ERROR`.
   - Deduction: Hypervisor / OS crashed due to temporary I/O timeout on primary boot controller.

## 4. Troubleshooting Procedure
1. **Document Screen:** Photograph exact BSOD stop parameters for post-mortem analysis.
2. **Controlled Power Cycle:** Press and hold power button for 10 seconds; wait 30 seconds; power on server.
3. **Observe POST Sequence:**
   - Motherboard POST passes with 1 clean beep.
   - RAID controller initializes: `All virtual disks optimal (RAID 10)`.
   - Windows Server 2022 loads successfully.
4. **Service Health Audit:**
   - Log into server console as `LAB\Administrator`.
   - Check core services: AD DS (`NTDS`), DNS, DHCP, SMB (`LanmanServer`) are all active.
5. **Run Storage Health Scan:**
   - Execute `chkdsk C: /scan`. Zero integrity violations reported.
   - Run `dcdiag /test:DNS /test:Services`. All tests pass.
6. **Fleet Verification:** Test login from Night Auditor workstation. Authentication succeeds; shared folders open instantly.

## 5. Commands and Tools Used
```powershell
Get-Service NTDS, DNS, Dhcp, LanmanServer
dcdiag /q
chkdsk C: /scan
```

## 6. Resolution
Recovered server from kernel panic via cold hardware reset; verified RAID storage array integrity; confirmed all core services running; restored vessel operations in 22 minutes.

## 7. When to Escalate
- If RAID controller reports degraded or failed disks, immediately alert IT Officer and log call with server hardware vendor for emergency parts delivery at next port of call.

## 8. Preventive Measures
1. Schedule offline hardware diagnostic scan on the server during the next scheduled port turnaround.
2. Review RAID controller firmware release notes.

## 9. Sample Completed Incident Report
- **Incident ID:** INC-2024-0325
- **Priority:** P1 (Critical Outage)
- **Time to Resolve:** 22 Minutes
- **Technician:** Anand D (IT Systems Assistant)
- **Escalated To:** IT Officer & Chief Engineer notified.

## 10. Completion Status
Documented
