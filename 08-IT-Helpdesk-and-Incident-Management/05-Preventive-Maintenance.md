# Practical Task: Enterprise IT Preventive Maintenance Scheduling

## 1. Objective
Design and implement recurring IT preventive maintenance (PM) schedules across workstations, servers, network switches, and peripheral equipment to minimize operational downtime.

## 2. Requirements
- Preventive maintenance schedule spreadsheet
- Workstation maintenance checklist
- Diagnostic flash drive

## 3. Background
Preventive maintenance transforms an IT department from a reactive "firefighting" posture into a proactive, high-availability service. Onboard cruise ships where physical stores are limited, hardware longevity is critical.

---

## 4. Scheduled Maintenance Matrix

| Frequency | Scope | Action Items | Duration |
|---|---|---|---|
| **Weekly** | Backup Systems | Verify completion of nightly Veeam/Windows Server backups; inspect backup repository capacity | 30 mins |
| **Bi-Weekly** | Antivirus & EDR | Audit Microsoft Defender endpoint definitions across fleet; review quarantined files | 45 mins |
| **Monthly** | Patching | Deploy tested Windows Cumulative Updates to workstations during scheduled off-peak windows | 2 hours |
| **Monthly** | Storage & Temp | Run automated disk cleanup scripts; verify servers retain > 20% free volume space | 1 hour |
| **Quarterly** | Physical Servicing | Disconnect and blow out dust from workstation and printer fans; clean intake filters | 3 hours |
| **Quarterly** | Disaster Recovery | Perform test restore of sample files and Active Directory objects from backup media | 2 hours |
| **Semi-Annual**| Network Hardware | Inspect switch fan status; review switch port error counters; audit UPS battery runtime | 2 hours |
| **Annual** | Asset Audit | Complete 100% physical hardware inventory audit; update asset tags and serials | 1 day |

## 5. Expected Result
Hardware failure rates drop significantly, servers maintain predictable performance baselines, and equipment inventories remain completely auditable.

## 6. Completion Status
Documented
