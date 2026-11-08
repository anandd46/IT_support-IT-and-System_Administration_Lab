# Scenario 02 — Guest Wi-Fi Connectivity Failure

**Module:** 09 — Cruise Ship IT Support Scenarios  
**Difficulty:** Intermediate  
**Status:** Documented  
**Department:** Guest Services / IT  
**Priority:** High (P2) — Multiple guests affected

---

## 1. Scenario Description

Guest Services contacts IT support reporting that multiple guests on **Deck 7** cannot connect to the ship's guest Wi-Fi network. Guests on other decks are able to connect without issues. The problem started approximately **30 minutes ago** and has affected at least 6–8 guest cabins on the same deck.

**Key Facts:**
- Multiple guests affected (not a single-device problem)
- Geographically isolated to Deck 7
- Guests on Deck 8 and other areas have full connectivity
- Issue began approximately 30 minutes ago with no known maintenance activity
- Guests are receiving either "Cannot connect to network" or the network is simply not visible

> **Important Note:** Guest and crew networks are logically isolated using VLANs. When troubleshooting guest Wi-Fi, work only within the guest network segment. Never investigate or modify crew or operations network components without authorisation. Any cross-VLAN troubleshooting must be escalated to the IT Officer.

---

## 2. Possible Causes

| # | Possible Cause | Likelihood |
|---|---|---|
| 1 | Access Point on Deck 7 has gone offline (power loss, hardware fault) | High |
| 2 | PoE (Power over Ethernet) port on the switch failed — AP has no power | High |
| 3 | Switch port the AP is connected to has gone down | Medium |
| 4 | AP firmware update triggered automatically and is rebooting | Medium |
| 5 | DHCP scope for the guest VLAN is exhausted (no more IP addresses) | Medium |
| 6 | AP configuration was lost or SSID became disabled | Low |
| 7 | Physical damage to the AP (unusual on a cruise ship but possible) | Low |
| 8 | VLAN misconfiguration after a previous change pushed to the switch | Low |

---

## 3. Initial Diagnosis

**Before going to Deck 7, gather information remotely:**

1. **How many guests are affected?** Ask Guest Services to confirm whether the issue is in specific cabin numbers only, or the entire Deck 7 area. This helps identify whether it is a single AP or a switch/uplink issue.

2. **Is the guest SSID visible or just not connecting?** If the SSID is not visible at all, the AP is likely offline. If the SSID is visible but devices cannot authenticate or receive an IP, the issue may be DHCP or authentication-related.

3. **Check the AP management console or Wi-Fi controller** (from the IT management workstation):
   - Is the Deck 7 AP shown as online or offline?
   - What is the last check-in time?
   - Is there an alert or alarm for that AP?

4. **Check switch panel physically** (if the switch is accessible):
   - Is the PoE port LED for the Deck 7 AP link light on?
   - Is there a port fault indicator?

---

## 4. Troubleshooting Procedure

### Step 1 — Check the AP Management Console

Log into the AP management interface or Wi-Fi controller from the IT admin workstation:

```
Access point controller: http://192.168.99.10 (example management IP)
Credentials: use IT department admin credentials — do not share
```

Look for:
- Deck 7 AP listed as **Disconnected** or **Offline**
- Last heartbeat time (more than 30 minutes ago confirms the fault window matches)
- Any active alarms or firmware update status
- Current DHCP lease count on the guest VLAN

> If the AP shows offline in the controller, the problem is confirmed at the AP or the switch port supplying it.

---

### Step 2 — Ping the AP Management IP Address

From the IT admin workstation or server, attempt to ping the Deck 7 AP's management IP address:

```cmd
ping 192.168.50.5
```

**Interpreting the result:**

| Ping Result | Interpretation |
|---|---|
| Reply received | AP is reachable on the network — the issue may be its radio/SSID config |
| Request timed out | AP is not reachable — hardware off, PoE failure, or switch port down |
| Destination unreachable | Routing issue between management VLAN and AP VLAN |

---

### Step 3 — Check the ARP Table for the AP's MAC Address

```cmd
arp -a
```

Look for the Deck 7 AP's MAC address in the ARP table. If the MAC is not present and the AP was reachable before, this further confirms the AP is offline.

---

### Step 4 — Check the Physical Switch Port (PoE)

Go to the network equipment closet or the floor switch serving Deck 7:

- Locate the patch panel or switch port connected to the Deck 7 AP (refer to network documentation / cable labels)
- Check the **Link LED** on the port:
  - **Green / Amber flashing** = link active, traffic flowing
  - **Off** = no link detected — cable issue or AP offline
- Check if the port has a **PoE fault indicator** (some switches show this with an orange LED or on the management console)

If the switch has a PoE management interface, check:
```
Switch management interface: http://192.168.99.2 (example)
Navigate to: PoE Status → Port connected to Deck 7 AP
```

---

### Step 5 — Attempt to Access the AP Management Page

If the AP responds to ping (Step 2 succeeded), try accessing its built-in management interface via a web browser:

```
http://192.168.50.5
```

This may reveal whether the AP is in a firmware update loop, has had its configuration reset, or is experiencing a software fault.

---

### Step 6 — Reboot the Access Point

**Method A — Via Management Console (preferred):**
If the controller or AP management page is accessible, use the reboot function within the interface. This is a controlled, logged reboot.

**Method B — Power Cycle (if management console unreachable):**
Locate the patch panel port or the PoE switch port connected to the Deck 7 AP.
Disconnect the network cable from the switch port for **10 seconds**, then reconnect.

> **Wait 2–3 minutes** after power restore before testing. APs take time to boot, associate with the controller, and begin broadcasting the SSID.

---

### Step 7 — Test from a Guest Device

After the reboot, ask Guest Services to have a guest or a staff member test the connection on Deck 7:

1. Enable Wi-Fi on the test device
2. Look for the guest SSID in the available networks list
3. Connect and verify that an IP address is assigned (device shows "Connected" rather than "No internet")
4. Test browsing or guest portal access

---

### Step 8 — Check DHCP Lease Assignments (If AP Is Online But Devices Cannot Connect)

If the AP is online but guests still cannot receive IP addresses, the DHCP scope for the guest VLAN may be exhausted.

From the DHCP server or router admin interface, check the guest VLAN DHCP pool:
- How many leases are active?
- What is the pool size?
- Are there any stale leases from devices that are no longer connected?

If the pool is exhausted, temporary remediation options include:
- Reducing the DHCP lease time to clear stale assignments faster
- Expanding the DHCP pool range (requires authorisation)
- Restarting the DHCP service to clear stale leases (escalate if on a critical server)

---

## 5. Commands and Tools Used

| Command / Tool | Purpose |
|---|---|
| `ping 192.168.50.5` | Test reachability of the AP |
| `arp -a` | View ARP table to confirm AP's MAC is known |
| AP Management Console / Wi-Fi Controller | View AP status, perform managed reboot |
| Switch Management Interface | Check PoE status, port link status |
| DHCP Server Interface | Check guest VLAN DHCP lease pool |

---

## 6. Resolution

**Most Common Resolution:** The Deck 7 AP had lost power due to a PoE port fault on the floor switch. After identifying the specific switch port via the management console, the port was power-cycled by temporarily disabling and re-enabling the PoE on that port via the switch interface. The AP rebooted, the SSID became visible on Deck 7, and guest connectivity was restored within 4 minutes.

**Secondary Resolution:** In a scenario where the AP firmware update ran automatically and the AP was stuck in a reboot loop, a full power cycle resolved the loop and the AP came back online running the updated firmware.

---

## 7. When to Escalate

Escalate to the IT Officer or shore-based support if:

- The AP hardware appears physically damaged (burn marks, physical impact, water damage)
- The AP does not come back online after multiple power cycles
- The Wi-Fi controller software is experiencing an error affecting multiple APs
- The switch itself is unresponsive (affecting more than just the AP)
- The DHCP scope issue is on a production server and expanding the pool requires authorised network changes
- VLAN misconfiguration is suspected — do not modify VLAN settings without IT Officer authorisation
- The issue recurs repeatedly in a short time period (recurring fault)

---

## 8. Preventive Measures

- **Regular AP Health Monitoring:** Configure the Wi-Fi controller to alert IT when any AP goes offline. This allows proactive response before guests report the issue.
- **Scheduled Firmware Updates:** Schedule AP firmware updates during off-peak hours (e.g., 3–5 AM) when guest Wi-Fi usage is minimal.
- **DHCP Lease Time Tuning:** Set appropriate DHCP lease times for the guest network — shorter leases (e.g., 2–4 hours) prevent pool exhaustion from disconnected devices holding leases.
- **PoE Switch Monitoring:** Monitor PoE switch port status as part of regular IT health checks.
- **Physical AP Inspection:** During preventive maintenance rounds, visually inspect APs for physical damage, loose cables, or indicator light anomalies.
- **Cable Management:** Ensure network cables to APs are routed securely and not in areas where they could be accidentally disturbed.
- **Spare AP:** Maintain at least one spare AP of the same model so a failed unit can be quickly replaced without waiting for a shore delivery.

---

## 9. Sample Incident Report

```
╔══════════════════════════════════════════════════════════════════╗
║               IT SUPPORT INCIDENT REPORT                         ║
╠══════════════════════════════════════════════════════════════════╣
║ Ticket Number   : INC-2024-0014                                   ║
║ Date Opened     : 2024-11-08                                      ║
║ Time Opened     : 14:35                                           ║
║ Priority        : P2 — High (Multiple guests affected)            ║
╠══════════════════════════════════════════════════════════════════╣
║ REQUESTER INFORMATION                                             ║
╠══════════════════════════════════════════════════════════════════╣
║ Name            : Guest Services Desk                             ║
║ Department      : Guest Services                                  ║
║ Location        : Reception — Deck 3                              ║
║ Contact         : Internal extension 3100                         ║
╠══════════════════════════════════════════════════════════════════╣
║ INCIDENT DESCRIPTION                                              ║
╠══════════════════════════════════════════════════════════════════╣
║ Multiple guests on Deck 7 reporting inability to connect to       ║
║ guest Wi-Fi. Estimated 6–8 cabins affected. Guests on Deck 8      ║
║ and public areas have full connectivity. Issue started at         ║
║ approximately 14:00.                                              ║
╠══════════════════════════════════════════════════════════════════╣
║ TROUBLESHOOTING STEPS TAKEN                                       ║
╠══════════════════════════════════════════════════════════════════╣
║ 14:35 — Received report from Guest Services                       ║
║ 14:36 — Checked Wi-Fi controller: Deck 7 AP shown as OFFLINE      ║
║          Last check-in: 14:02 (matches reported start time)       ║
║ 14:37 — Ping to 192.168.50.5 (Deck 7 AP): Request timed out       ║
║ 14:38 — Went to network closet Deck 7                             ║
║ 14:40 — Found PoE port for Deck 7 AP showing no link light        ║
║ 14:41 — Disconnected and reconnected patch cable at switch port   ║
║ 14:41 — PoE port link light came on after reconnection            ║
║ 14:43 — Ping to 192.168.50.5: Reply received                      ║
║ 14:44 — Wi-Fi controller: Deck 7 AP now shows ONLINE              ║
║ 14:45 — Guest Services confirmed guests can now connect on Deck 7  ║
╠══════════════════════════════════════════════════════════════════╣
║ ROOT CAUSE                                                        ║
╠══════════════════════════════════════════════════════════════════╣
║ Patch cable at the switch port for the Deck 7 AP had become       ║
║ partially dislodged, breaking the PoE connection and causing       ║
║ the AP to lose power. Likely caused by physical vibration.        ║
╠══════════════════════════════════════════════════════════════════╣
║ RESOLUTION                                                        ║
╠══════════════════════════════════════════════════════════════════╣
║ Re-seated patch cable at switch port. AP rebooted and came        ║
║ online. Guest SSID restored on Deck 7. Cable tie added to        ║
║ secure cable and prevent recurrence.                              ║
╠══════════════════════════════════════════════════════════════════╣
║ Time Resolved   : 14:45                                           ║
║ Total Duration  : 10 minutes                                      ║
║ Technician      : Anand D                                         ║
║ Status          : RESOLVED                                        ║
╚══════════════════════════════════════════════════════════════════╝
```
