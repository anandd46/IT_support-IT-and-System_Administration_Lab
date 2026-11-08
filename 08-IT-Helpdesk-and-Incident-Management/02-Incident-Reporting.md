# Practical Task: Incident Reporting and Root Cause Analysis (RCA)

## 1. Objective
Author professional IT Incident Reports, conduct post-incident reviews, perform structured Root Cause Analysis (RCA) using the 5-Whys methodology, and define preventive measures.

## 2. Requirements
- Standard Incident Report Template
- Incident timeline documentation

## 3. Background
When major IT incidents occur (server outages, network downtime, security breaches), technical teams must produce formal Incident Reports for IT management, department heads, and compliance auditors.

An incident report provides:
1. **Executive Summary:** High-level non-technical summary of what happened.
2. **Timeline:** Chronological sequence from detection to resolution.
3. **Impact Analysis:** Systems affected, user downtime, and business implications.
4. **Root Cause Analysis (RCA):** The underlying mechanical, logical, or human flaw that allowed the incident to occur.
5. **Corrective & Preventive Actions (CAPA):** Specific technical modifications to permanently prevent recurrence.

---

## 4. The 5-Whys Root Cause Analysis Methodology Example
- **Problem:** The Domain Controller crashed, disabling shipboard logins for 25 minutes.
  1. *Why did it crash?* The system volume C: reached 0% free space.
  2. *Why was storage exhausted?* An IIS web log grew to 45 GB in 48 hours.
  3. *Why did the log grow so fast?* A misconfigured bridge application entered a continuous authentication loop generating 500 error entries per second.
  4. *Why did the loop occur?* The application's service account password had been changed without updating the bridge config file.
  5. *Root Cause:* Lack of change-control coordination during service account password rotations, combined with missing automated disk space threshold alerts on the server.

---

## 5. Sample Completed Incident Report
*(See full standardized template in `templates/incident-report-template.md`)*

- **Incident ID:** INC-2024-0089
- **Title:** Unplanned Outage of Departmental Shared Folder Storage
- **Severity:** P2 (High)
- **Duration:** 42 Minutes
- **Resolution Summary:** Rebooted hung File Server virtual machine, cleared file lock deadlock, and verified SMB share accessibility.
- **Preventive Action:** Configured Daily PowerShell disk space alert script with email notification when free storage drops below 15%.

## 6. Expected Result
The technician delivers clear, concise, professional post-incident reports that communicate technical findings to both technical and managerial leadership.

## 7. Completion Status
Documented
