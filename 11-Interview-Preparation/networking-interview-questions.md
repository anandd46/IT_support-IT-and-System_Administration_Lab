# Technical Interview Preparation: Networking, DNS, and DHCP

### Q1: What is the difference between a Layer 2 Switch and a Layer 3 Router?
**A:** A Layer 2 switch operates at the Data Link layer, inspecting physical MAC addresses to forward Ethernet frames between devices within the same local broadcast domain (LAN). It maintains a MAC address table mapping ports to hardware addresses. A Layer 3 router operates at the Network layer, inspecting logical IPv4/IPv6 addresses to route packets between different subnets, networks, or across the Wide Area Network (WAN). Routers break up broadcast domains; standard switches do not.

### Q2: What happens step-by-step when a client computer attempts to acquire an IP address via DHCP?
**A:** The client executes the 4-step **DORA** process over UDP ports 67 (server) and 68 (client):
1. **Discover:** The client broadcasts a `DHCPDISCOVER` packet searching for any available DHCP server.
2. **Offer:** One or more DHCP servers respond with a `DHCPOFFER` proposing an available IP address, subnet mask, gateway, and lease time.
3. **Request:** The client broadcasts a `DHCPREQUEST` formally accepting one proposed offer and alerting other servers that their offers were not chosen.
4. **Acknowledge:** The chosen DHCP server sends a unicast/broadcast `DHCPACK` confirming the binding, finalizing lease parameters, and marking the IP as leased.

### Q3: What is an APIPA address? What does seeing `169.254.45.12` on a workstation immediately tell you?
**A:** APIPA stands for Automatic Private IP Addressing (`169.254.0.0/16`). It is an automated failover feature in Windows. When a network adapter configured for DHCP broadcasts `DHCPDISCOVER` packets but receives no response from any DHCP server, Windows automatically assigns an address in the `169.254.x.x` range. Seeing an APIPA address immediately proves that the workstation's physical link is active, but Layer 2/3 communication with the DHCP server has completely failed (e.g., disconnected uplink, wrong switch port VLAN, or exhausted DHCP pool).

### Q4: Explain the difference between TCP and UDP. Provide examples of when each is preferred.
**A:** TCP (Transmission Control Protocol) is connection-oriented, establishing a 3-way handshake (`SYN`, `SYN-ACK`, `ACK`). It guarantees packet delivery, error-checking, sequencing, and retransmission of lost packets, making it ideal for web browsing (HTTPS), file transfer (SMB/FTP), and email. UDP (User Datagram Protocol) is connectionless and lightweight; it sends packets without handshakes, acknowledgments, or retransmissions, prioritizing low latency and speed over reliability. UDP is preferred for live video streaming, voice over IP (VoIP), online gaming, and quick query protocols like DNS and DHCP.

### Q5: How would you troubleshoot a client that can ping an external IP address (e.g., `8.8.8.8`) but cannot load websites like `www.google.com`?
**A:** Being able to ping `8.8.8.8` proves that Layer 1 cabling, Layer 2 switching, Layer 3 IP addressing, subnet masking, Default Gateway routing, and external WAN connectivity are all 100% functional. The failure to open websites by name points directly to Layer 7 **Domain Name System (DNS) failure**. Troubleshooting steps:
1. Run `nslookup google.com` to check if the configured DNS server responds.
2. Verify adapter DNS settings with `ipconfig /all`.
3. Flush client DNS resolver cache: `ipconfig /flushdns`.
4. Test querying public DNS directly: `nslookup google.com 8.8.8.8`. If this works, the local DNS server is offline or misconfigured.

### Q6: What is a VLAN and why are VLANs essential in enterprise and maritime networks?
**A:** A Virtual Local Area Network (VLAN) is a logical partition of a physical Layer 2 switch into distinct broadcast domains using IEEE 802.1Q tagging. VLANs are essential for:
- **Security:** Isolating sensitive networks (e.g., separating guest Wi-Fi from administrative finance systems or ship navigation).
- **Traffic Management & Performance:** Restricting broadcast traffic to local groups rather than flooding the entire switch infrastructure.
- **Cost Efficiency:** Multiple independent departments can share the same physical enterprise switch and cabling while maintaining total logical isolation.

### Q7: What is Address Resolution Protocol (ARP) and what command displays the local ARP table?
**A:** ARP resolves known Layer 3 IP addresses into physical Layer 2 MAC addresses so data frames can be encapsulated and transmitted across Ethernet. When a PC needs to send a packet to `192.168.100.10`, it broadcasts an ARP request: *"Who has 192.168.100.10? Tell 192.168.100.20"*. The target machine replies with its MAC address, which the PC caches in its ARP table. The command to inspect this cache is `arp -a` in Windows or `ip neigh` in Linux.

### Q8: What does the command `tracert` (or `traceroute`) do and how does it determine each hop?
**A:** `tracert` maps the path packets take to reach a destination host. It works by sending ICMP echo requests with incrementing Time-To-Live (TTL) values starting at TTL=1. The first router decrements TTL to 0, drops the packet, and sends back an `ICMP Time Exceeded` packet, revealing that router's IP and response time. The utility repeats this with TTL=2, TTL=3, and so on until the target host responds, pinpointing exactly which router hop experiences latency or packet drops.

### Q9: Calculate the usable host range and broadcast address for `192.168.10.64/26`.
**A:** A `/26` subnet mask has 26 network bits and 6 host bits ($32 - 26 = 6$).
- Subnet Mask: `255.255.255.192`.
- Total addresses per block: $2^6 = 64$.
- Block range: `192.168.10.64` to `192.168.10.127`.
- **Network ID:** `192.168.10.64`.
- **Usable Host Range:** `192.168.10.65` through `192.168.10.126` (62 usable hosts).
- **Broadcast Address:** `192.168.10.127`.

### Q10: How do you test if a specific remote TCP port (e.g., Port 3389 RDP) is open from the command line without installing third-party tools?
**A:** In PowerShell:
```powershell
Test-NetConnection -ComputerName 192.168.100.10 -Port 3389
```
If `TcpTestSucceeded : True` is returned, the port is open and reachable. On Linux, run `nc -zv 192.168.100.10 3389` or `curl -v telnet://192.168.100.10:3389`.
