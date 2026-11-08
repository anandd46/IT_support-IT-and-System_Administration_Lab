# Practical Task: Network Routers and Switches Fundamentals

## 1. Objective
Understand the operational differences between Layer 2 Switches, Layer 3 Routers, and Wireless Access Points, inspect Address Resolution Protocol (ARP) tables, and analyze VLAN segmentation.

## 2. Requirements
- Client workstation connected to a switch/router
- CLI tools: `arp`, `route print`, `ip route`

## 3. Background
- **Network Switch (Layer 2):** Connects devices within the same local network segment. Maintains a **MAC Address Table (CAM Table)** mapping physical MAC addresses to specific switch ports. Traffic between ports does not leave the switch.
- **Network Router (Layer 3):** Connects different logical network subnets (e.g., connecting departmental LAN to corporate WAN or Internet). Operates using IP routing tables.
- **VLANs (Virtual Local Area Networks):** Partition a single physical switch into isolated logical broadcast domains (e.g., separating Guest Wi-Fi from Ship Operations). Devices on different VLANs cannot communicate without a router.
- **ARP (Address Resolution Protocol):** Resolves known Layer 3 IPv4 addresses into Layer 2 physical MAC addresses.

## 4. Step-by-Step Procedure
1. **Examine Local ARP Table:** Run `arp -a` in Windows or Linux to view cached IP-to-MAC address mappings.
2. **Ping a Neighboring PC:** Ping another lab device; re-run `arp -a` to observe newly learned dynamic ARP entries.
3. **Inspect Local Routing Table:** Run `route print` (Windows) or `ip route show` (Linux) to inspect how the OS routes packets to the default gateway (`0.0.0.0/0`).
4. **VLAN Port Modes (Concept):**
   - **Access Port:** Connects an end-user device (PC, printer) belonging to a single VLAN.
   - **Trunk Port:** Carries traffic for multiple VLANs across switches using IEEE 802.1Q VLAN tagging.

## 5. Commands Used

### Command 1: Inspect ARP Cache Table
```cmd
arp -a
```
- **What it does:** Displays current IP-to-MAC translation table cached in workstation memory.
- **Expected Output:**
```text
Interface: 192.168.100.20 --- 0x4
  Internet Address      Physical Address      Type
  192.168.100.1         00-50-56-c0-00-01     dynamic
  192.168.100.10        08-00-27-ba-56-12     dynamic
  192.168.100.255       ff-ff-ff-ff-ff-ff     static
```

### Command 2: Inspect Routing Table (Windows)
```cmd
route print -4
```
- **What it does:** Displays local IPv4 active route table, gateway metric, and interface binding.

## 6. Expected Result
The technician explains how switches forward frames by MAC address, how routers route packets across subnets, and audits ARP caches.

## 7. Troubleshooting
- **Issue: Duplicate IP address conflict on LAN:**
  - *Cause:* Static IP assigned to a workstation matches an IP already leased by DHCP.
  - *Solution:* Inspect `arp -a` to identify conflicting MAC address; configure device to use DHCP or assign unused static IP.

## 8. Screenshots / Evidence
- `screenshots/06-arp-cache-table.png` — *Pending lab execution: Capture arp -a output.*
- `screenshots/06-route-print-table.png` — *Pending lab execution: Capture route print output.*

## 9. Practical Learning Outcome
Mastery in understanding Layer 2/3 forwarding, ARP resolution, and routing table evaluation.

## 10. Completion Status
Documented
