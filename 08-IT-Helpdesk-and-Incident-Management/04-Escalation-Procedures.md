# Practical Task: IT Support Escalation Procedures and Tiers

## 1. Objective
Define IT support operational tiers (Tier 1 Helpdesk, Tier 2 Desktop/SysAdmin, Tier 3 Senior Infrastructure/Vendor), establish criteria for escalation, and document warm handoffs.

## 2. Requirements
- Service desk escalation policy
- Communication templates

## 3. Background
No single technician knows everything. Knowing **WHEN** and **HOW** to escalate is as important as knowing how to troubleshoot. In maritime environments, the hierarchy typically consists of:
- **Tier 1 (IT Systems Assistant / Helpdesk):** User onboarding, password resets, desktop hardware, printer maintenance, basic LAN troubleshooting.
- **Tier 2 (IT Systems Specialist / SysAdmin):** Server administration, Active Directory schema, managed switch VLANs, firewall routing, Exchange/M365 administration.
- **Tier 3 / Fleet Management (IT Officer / Shore-side Operations):** Core satellite VSAT uplinks, navigation system interfaces, vendor warranty dispatches, maritime cyber regulations (IMO 2021 compliance).

---

## 4. Escalation Workflow Diagram

```mermaid
flowchart TD
    Issue["User Support Call / Ticket"] --> Tier1["Tier 1: IT Systems Assistant<br/>Initial triage, workstations, printers, passwords"]
    Tier1 --> T1Check{"Can resolve within<br/>30 mins / basic scope?"}
    T1Check -- Yes --> T1Close["Resolve & Close Ticket"]
    T1Check -- No --> WarmHand["Execute Warm Handoff:<br/>Attach diagnostic logs, test results, error screenshots"]
    WarmHand --> Tier2["Tier 2: System Administrator<br/>Server OS, AD DS, Managed Switches, Firewalls"]
    Tier2 --> T2Check{"Resolved at Tier 2?"}
    T2Check -- Yes --> T2Close["Resolve & Notify Tier 1"]
    T2Check -- No --> Tier3["Tier 3: IT Officer / Shore Operations / Vendor<br/>VSAT Uplink, Core Hardware Replacement, Vendor Support"]
    Tier3 --> FinalFix["Permanent Remediation"]
```

---

## 5. Escalation Rules: When Must You Escalate?
1. **SLA Breach Threshold:** When 50% of the SLA resolution window has elapsed without identifying a verified cause.
2. **Access Limitation:** When resolution requires Domain Admin credentials, core firewall modifications, or physical access to sealed navigation equipment.
3. **Safety & Compliance:** Any anomaly touching Bridge Navigation, Maritime Safety, or Engine Automation systems requires immediate escalation to the IT Officer and Chief Engineer.
4. **Hardware Failure Under Warranty:** When components require vendor RMA dispatch.

## 6. Expected Result
Seamless collaboration between support tiers with zero dropped tickets, clear accountability, and rapid customer resolution.

## 7. Completion Status
Documented
