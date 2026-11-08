# Technical Interview Preparation: Cruise Ship IT & Explora Journeys Scenarios

### Q1: Why are you interested in working as an IT Systems Assistant on a cruise ship such as Explora Journeys?
**A:** Working in maritime IT represents a unique blend of technical challenge and high operational impact. A cruise ship is a self-contained floating smart city operating 24/7 at sea without the luxury of calling on-site vendor technicians. The IT Systems Assistant role demands broad, versatile competence: supporting guest Wi-Fi, troubleshooting bridge and engine consoles, maintaining hotel point-of-sale systems, administering Active Directory, and performing preventive maintenance across diverse departments. I am excited by the technical self-sufficiency required and the opportunity to deliver seamless IT experiences in an international luxury hospitality environment.

### Q2: How do you prioritize multiple support calls that arrive simultaneously during embarkation day?
**A:** I evaluate tickets strictly using the **Impact vs. Urgency** matrix:
1. **Priority 1 (Vessel Safety & Compliance):** Any issue affecting Bridge Navigation, Safety Management, or Engine telemetry is attended to immediately.
2. **Priority 2 (Revenue & Check-In Operations):** During embarkation, check-in terminals, keycard encoders, and embarkation manifest printers are business-critical. An outage delaying guest boarding takes precedence over back-office requests.
3. **Priority 3 (Guest Services & Luxury Experience):** Suite entertainment, guest Wi-Fi captive portals, and restaurant Point-of-Sale terminals.
4. **Priority 4 (Individual Crew Administration):** Crew recreation Wi-Fi or non-urgent back-office queries are scheduled once operational milestones are cleared.
Clear, empathetic communication is maintained with all users regarding estimated arrival times.

### Q3: How does troubleshooting network issues at sea differ from troubleshooting in a standard corporate office?
**A:** The fundamental TCP/IP principles are identical, but environmental and infrastructure constraints differ significantly:
- **Satellite Latency & Bandwidth:** Internet connectivity relies on satellite links (VSAT / LEO) with inherent latency (40ms to 600ms) and constrained bandwidth. High packet loss or dropped calls often stem from weather rain fade, mast shadows, or bandwidth saturation rather than local LAN equipment failure.
- **Physical Environment:** Salt air corrosion, ship vibration, and watertight bulkheads make physical cabling integrity and cable dressing vital.
- **No Physical Escalation:** There is no dispatching a vendor technician to the ship while crossing the ocean. You must rely on diagnostic tools, spare part inventories, and standardized cold-spare hardware swaps.
- **Strict Change Control:** Unplanned switch reboots or firewall alterations can disrupt critical vessel operations. All changes must be authorized and logged.

### Q4: Describe how you would handle an angry, high-ranking officer or VIP guest whose Wi-Fi or laptop has failed.
**A:** I apply the **HEAT** customer service methodology:
1. **Hear:** Listen actively without interrupting. Let them fully explain their frustration and acknowledge the disruption to their work or vacation.
2. **Empathize:** Acknowledge their situation professionally: *"I completely understand how critical this report is for you, and I am here to get this resolved right now."*
3. **Apologize:** Offer a sincere, non-defensive apology on behalf of the service: *"I apologize for the frustration this delay has caused."*
4. **Take Action:** Project calm technical competence. Begin systematic troubleshooting immediately, explain each non-invasive step in clear language, resolve the fault, and remain until they have personally verified that their system is functioning perfectly.

### Q5: What would you do if a core departmental network switch fails and you do not have an identical replacement model in the IT spares locker?
**A:**
1. I would assess available unmanaged and managed spare switches in the IT store.
2. If only an unmanaged 16-port switch is available, I verify that the failed switch was serving a single flat access VLAN (e.g., F&B admin office). If so, the unmanaged switch can be deployed immediately as a temporary emergency bridge to restore basic connectivity.
3. If the failed switch handled multiple tagged VLANs (trunking), an unmanaged switch cannot be used. I would locate a spare managed switch, connect via console cable, configure required VLAN IDs (e.g., VLAN 20 and VLAN 30) and port access assignments matching the documented port-map, and deploy it.
4. I would notify the IT Officer, document the temporary hardware swap in the incident report, and order an exact replacement for delivery at the next major turnaround port.

### Q6: Behavioral Question (STAR Method): Tell me about a time you had to troubleshoot a technical problem you had never seen before.
**A:**
- **Situation:** During a lab simulation, an Active Directory client machine joined the domain successfully, but every domain user received the error *"The trust relationship between this workstation and the primary domain failed"* upon login.
- **Task:** I needed to diagnose and restore domain authentication without re-imaging the client workstation.
- **Action:** Instead of guessing or reinstalling the OS, I followed standard troubleshooting methodology. I checked Event Viewer and identified Event ID 3210 (Netlogon failure). I researched the error and discovered that restoring a virtual machine snapshot had caused the client's cached machine account password (`CLIENT01$`) to fall out of sync with the Domain Controller's LSA secret. Using an elevated PowerShell prompt on the client, I executed `Test-ComputerSecureChannel -Repair -Credential (Get-Credential)`.
- **Result:** The secure channel was repaired in under 3 minutes. Domain users logged in successfully without data loss, and I documented the snapshot trust-break behavior in the lab troubleshooting wiki.
