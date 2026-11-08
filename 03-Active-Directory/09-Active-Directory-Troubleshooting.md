# Practical Task: Active Directory Troubleshooting and Diagnostic Tools

## 1. Objective
Diagnose and resolve common Active Directory authentication failures, trust relationship breakdowns, time drift anomalies, and directory replication faults using industry-standard CLI diagnostics.

## 2. Requirements
- Domain Controller (`SERVER01`)
- Client Workstation (`CLIENT01`)
- Diagnostic tools: `dcdiag`, `repadmin`, `netdom`, `w32tm`, `klist`

## 3. Background
Active Directory relies on interconnected subsystems: Kerberos for authentication, LDAP for queries, DNS for location services, RPC for inter-server replication, and W32Time for clock synchronization. Failures in any single component create cascading issues for users.

---

## 4. Top Active Directory Faults & Procedures

### Scenario 1: "The trust relationship between this workstation and the primary domain failed"
- **Symptom:** Domain user cannot log in from a workstation; receives trust failure notice.
- **Cause:** Computer password (`CLIENT01$`) out of sync between local LSA secret and Active Directory machine account (often occurs when restoring a VM snapshot).
- **Resolution:**
```powershell
Test-ComputerSecureChannel -Repair -Credential (Get-Credential)
```
*If command fails, log in as local administrator, unjoin domain to workgroup, restart, and rejoin `lab.local`.*

### Scenario 2: Kerberos Time Synchronization Drift (> 5 Minutes)
- **Symptom:** Users cannot authenticate; Kerberos error `KRB_AP_ERR_SKEW`.
- **Cause:** Clock on client workstation drifts more than 300 seconds away from the Domain Controller clock.
- **Resolution:**
```cmd
w32tm /query /status
w32tm /config /syncfromflags:domhier /update
net stop w32time && net start w32time
w32tm /resync /force
```

### Scenario 3: Domain Controller Health Diagnostics (`dcdiag`)
- **Symptom:** Sluggish authentication, missing SYSVOL share, or unexpected logon failures.
- **Procedure:** Run complete domain controller health check.
```cmd
dcdiag /v /c /d /e /s:SERVER01
```
*Evaluates Connectivity, Advertising, FrsSysVol, MachineAccount, Services, and Replications.*

### Scenario 4: Active Directory Replication Diagnostics (`repadmin`)
- **Symptom:** Changes made on one DC do not reflect on secondary DCs.
- **Procedure:** Check replication status across all naming contexts.
```cmd
repadmin /showrepl
repadmin /replsummary
```

### Scenario 5: Purging Corrupted Kerberos Tickets on Client (`klist`)
- **Symptom:** User was added to a security group but permissions fail to apply.
- **Resolution:**
```cmd
klist
klist purge
```
*Purges cached ticket granting tickets (TGT), forcing immediate re-authentication with updated group memberships without a full reboot.*

---

## 5. Summary Commands Table
| Utility | Primary Function | Command Syntax |
|---|---|---|
| `dcdiag` | DC health audit | `dcdiag /test:DNS` |
| `repadmin` | Replication audit | `repadmin /showrepl` |
| `w32tm` | Time sync audit & repair | `w32tm /resync /force` |
| `klist` | Kerberos ticket inspector | `klist purge` |
| `nltest` | Secure channel query | `nltest /sc_query:lab.local` |

## 6. Expected Result
The technician diagnoses AD anomalies, rebuilds broken machine trust accounts, forces Kerberos synchronization, and maintains domain controller health.

## 7. Troubleshooting
- **Issue: `dcdiag` reports "Failed test Advertising":**
  - *Cause:* Netlogon service is not broadcasting DC roles due to incomplete promotion or DNS zone failure.
  - *Solution:* Verify Netlogon and DNS Server services are running; inspect `_msdcs.lab.local` DNS zone records.

## 8. Screenshots / Evidence
- `screenshots/09-dcdiag-clean-summary.png` — *Pending lab execution: Capture dcdiag summary output.*
- `screenshots/09-w32tm-resync.png` — *Pending lab execution: Capture successful w32tm /resync command.*

## 9. Practical Learning Outcome
Mastery in enterprise directory diagnostics, troubleshooting machine trust accounts, and maintaining infrastructure time and replication health.

## 10. Completion Status
Documented
