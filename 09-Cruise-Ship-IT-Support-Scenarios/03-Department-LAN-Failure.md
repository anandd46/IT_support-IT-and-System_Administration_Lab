# Scenario 03: Complete Departmental LAN Switch Failure

## 1. Scenario Description
During operational cruise hours, all 8 workstations and 2 network printers in the Food & Beverage (F&B) and Galley administration office simultaneously lose local network connectivity. Workstations display "No Internet, secured" and cannot reach shipboard inventory servers.

## 2. Possible Causes
1. Physical power loss to the F&B departmental edge switch.
2. Core switch uplink cable disconnected, severed, or damaged by physical movement.
3. Switch port failure on core backbone switch.
4. Spanning Tree Protocol (STP) loop caused by someone looping an Ethernet patch cord between two wall jacks.
5. Departmental switch hardware power supply failure.

## 3. Initial Diagnosis
- **Check Multiple PCs:** Inspect 3 separate workstations in the office. All display APIPA addresses (`169.254.x.x`) or report media disconnected.
- **Physical Switch Room Inspection:** Navigate to Deck 3 local communications locker. Inspect the departmental 16-port switch.
- **Observation:** All switch port status LEDs are completely dark.

## 4. Troubleshooting Procedure
1. **Power Inspection:** Check AC power cable into switch and PDU.
2. **UPS / PDU Check:** Confirm PDU socket has power (test with multimeter or secondary device). Power socket is live.
3. **Power Cycle:** Re-seat power cable into switch. Zero LED activity observed; internal power supply has suffered hardware failure.
4. **Deploy Emergency Spare:**
   - Retrieve pre-configured cold-spare 16-port switch from IT Spares Locker.
   - Unpack spare switch; mount into communications rack.
   - Connect AC power cable; confirm power LED illuminates green.
5. **Port Migration:**
   - Transfer Uplink fiber/copper cable to Port 1. Verify link LED with core switch turns solid green.
   - Transfer departmental patch leads 1-through-10 to corresponding ports.
6. **Workstation Validation:**
   - On Workstation 1, run `ipconfig /release` and `ipconfig /renew`.
   - Confirm receipt of valid IP (`192.168.60.15`).
   - Ping shipboard inventory server (`ping 192.168.10.10`).

## 5. Commands and Tools Used
```cmd
ipconfig /renew
ping 192.168.10.10
tracert 192.168.10.10
```

## 6. Resolution
Replaced defective departmental edge switch with pre-configured cold-spare unit; migrated patch cabling; verified DHCP lease assignment and server reachability across all 8 workstations.

## 7. When to Escalate
- If the replacement switch fails to establish an uplink with the Core Switch room (indicates structural cable severance through watertight bulkheads requiring Chief Electrical Officer).
- If the outage involves bridge navigation subnets.

## 8. Preventive Measures
1. Maintain documented port-mapping sheets taped inside every local communications locker.
2. Ensure at least two pre-configured spare switches are maintained in IT spares storage.
3. Enable Spanning Tree Protocol (`BPDU Guard`) on all access ports.

## 9. Sample Completed Incident Report
- **Incident ID:** INC-2024-0312
- **Priority:** P2 (High)
- **Time to Resolve:** 26 Minutes
- **Technician:** Anand D (IT Systems Assistant)
- **Sign-off:** F&B Manager confirmed all point-of-sale inventory terminals operating normally.

## 10. Completion Status
Documented
