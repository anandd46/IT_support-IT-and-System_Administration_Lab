# Scenario 08: Inter-VLAN Communication Breakdown (Bridge to Engine Room)

## 1. Scenario Description
Following overnight network firmware maintenance, the Bridge navigation watch officer reports they can no longer reach the Engine Room control system web portal (`http://192.168.50.10`) from Bridge workstations. Both departments retain local network access and can reach the main server.

## 2. Possible Causes
1. Access Control List (ACL) or firewall rule dropped inter-VLAN routing between Bridge (VLAN 10) and Engine Room (VLAN 50).
2. Managed switch trunk port stripped 802.1Q VLAN tags.
3. Engine Room server default gateway misconfigured during maintenance.
4. IP address conflict on the engine automation server.

## 3. Initial Diagnosis
- From Bridge PC (`192.168.10.15`), test traceroute:
```cmd
tracert 192.168.50.10
```
- **Result:** Packet reaches Bridge Default Gateway `192.168.10.1` at Hop 1, then displays `* * * Request timed out`.
- Deduction: The local Bridge LAN is functional; packets are being dropped at the Layer 3 core routing boundary.

## 4. Troubleshooting Procedure
1. **Review Maintenance Change Log:** Inspect overnight firewall/switch configuration commits.
2. **Identify Policy Change:** An automated security hardening script applied a default `DENY` rule blocking inter-VLAN routing from VLAN 10 to VLAN 50.
3. **Coordinate with IT Officer:** Present traceroute evidence to IT Officer; obtain written authorization to update firewall rule.
4. **Update Routing Policy:**
   - In Core Router / Firewall, create explicit bidirectional permit rule:
   - Source: `VLAN 10 (192.168.10.0/24)` -> Destination: `192.168.50.10:80,443` -> Action: `PERMIT`.
5. **Re-Test Connectivity:**
   - From Bridge PC, run `Test-NetConnection 192.168.50.10 -Port 80`.
   - Result: `TcpTestSucceeded: True`.
   - Bridge officer opens engine status portal; telemetry updates live.

## 5. Commands Used
```cmd
tracert 192.168.50.10
Test-NetConnection -ComputerName 192.168.50.10 -Port 80
```

## 6. Resolution
Traced packet drop to newly applied firewall access list; coordinated change control; implemented explicit inter-VLAN permit rule; restored Bridge-to-Engine monitoring.

## 7. When to Escalate
- Any network change affecting Bridge or Engine systems is subject to strict Maritime Safety Management (SMS) change-control; **never** alter core routing rules without IT Officer and Officer of the Watch authorization!

## 8. Preventive Measures
All firewall policy updates must be tested in a staging lab environment prior to live deployment on vessel networks.

## 9. Sample Completed Incident Report
- **Incident ID:** INC-2024-0335
- **Priority:** P1 (Critical Vessel Operations)
- **Time to Resolve:** 18 Minutes
- **Technician:** Anand D (IT Systems Assistant)

## 10. Completion Status
Documented
