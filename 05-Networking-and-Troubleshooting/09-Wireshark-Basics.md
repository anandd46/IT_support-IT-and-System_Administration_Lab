# Practical Task: Wireshark Packet Capture and Traffic Analysis

## 1. Objective
Capture network frames using Wireshark, apply display filters (DNS, DHCP, ICMP, TCP), inspect three-way TCP handshakes, and isolate network anomalies at the packet layer.

## 2. Requirements
- Wireshark installed on Windows or Linux (`tshark`)
- Network adapter with administrative packet capture privileges

## 3. Background
When standard CLI utilities cannot explain an issue, packet sniffing reveals the raw truth on the wire. Wireshark captures frames entering and exiting the network interface card.

Core Filter Syntaxes:
- **DHCP Traffic:** `bootp` or `dhcp` (UDP ports 67 and 68).
- **DNS Lookups:** `dns` (UDP port 53).
- **Ping Traffic:** `icmp` (Echo Request type 8, Echo Reply type 0).
- **Specific IP:** `ip.addr == 192.168.100.10`.
- **Specific Port:** `tcp.port == 443` or `tcp.port == 80`.

## 4. Step-by-Step Procedure
1. **Launch Wireshark:** Select active Ethernet interface and click blue start shark fin.
2. **Capture Ping Sequence:** In Command Prompt, run `ping 8.8.8.8`. In Wireshark, apply display filter `icmp`.
3. **Inspect ICMP Packets:** Observe Type 8 (Echo Request) sent from client IP, followed by Type 0 (Echo Reply) from 8.8.8.8.
4. **Capture DNS Resolution:** Filter for `dns`. Run `nslookup google.com`. Inspect DNS Standard Query and Standard Query Response containing the A record.
5. **Inspect TCP 3-Way Handshake:** Filter for `tcp.port == 443`. Open a website. Observe:
   - Client sends `[SYN]` (Synchronize)
   - Server responds `[SYN, ACK]` (Synchronize-Acknowledge)
   - Client responds `[ACK]` (Acknowledge)
6. **Save Packet Capture:** Save file as `lab_network_capture.pcapng` for forensic documentation.

## 5. Commands Used

### Command 1: Wireshark Display Filters
```text
icmp
dns
bootp
ip.addr == 192.168.100.10 and tcp.port == 445
```

### Command 2: CLI Packet Capture using TShark (Linux alternative)
```bash
sudo tshark -i eth0 -f "icmp" -c 5
```
- **What it does:** Captures 5 ICMP packets directly in the terminal without a GUI.

## 6. Expected Result
The technician captures network conversations, decodes frame protocol layers, and verifies packet delivery.

## 7. Troubleshooting
- **Issue: Wireshark displays "No interfaces found" or fails to start capture:**
  - *Cause:* Npcap driver not installed or user lacking administrator privileges.
  - *Solution:* Reinstall Npcap with "Install Npcap in WinPcap API-compatible Mode" and launch Wireshark as Administrator.

## 8. Screenshots / Evidence
- `screenshots/09-wireshark-icmp-capture.png` — *Pending lab execution: Capture Wireshark displaying ICMP Request/Reply.*
- `screenshots/09-tcp-handshake-syn-ack.png` — *Pending lab execution: Capture TCP 3-way handshake packet sequence.*

## 9. Practical Learning Outcome
Ability to capture, filter, analyze, and diagnose raw network packets and identify connection resets or packet drops.

## 10. Completion Status
Documented
