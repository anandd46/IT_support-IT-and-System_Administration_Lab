# Practical Task: Windows 11 Network Diagnostics and Connectivity Troubleshooting

## 1. Objective
Diagnose and resolve common local area network, IP configuration, DNS resolution, and gateway connectivity issues in Windows 11 using standard command-line tools.

## 2. Requirements
- Windows 11 workstation connected to LAN or Wi-Fi
- Access to Command Prompt and PowerShell
- Basic network infrastructure (router/switch or virtual network)

## 3. Background
Network connectivity issues account for significant helpdesk volume. A structured bottom-up diagnostic methodology (Layer 1 Physical to Layer 7 Application) eliminates guesswork:
1. **Physical / Link Layer:** Cable plugged in, link LED illuminated, Wi-Fi connected.
2. **Network Layer (IP):** Valid IP address, subnet mask, default gateway assigned via DHCP or static.
3. **Transport Layer:** TCP/UDP port reachable, socket established.
4. **Name Resolution (DNS):** Hostname successfully resolves to IP.
5. **Application Layer:** Target service responds.

Special attention is required for **APIPA (169.254.x.x)** addresses, which indicate that the client enabled DHCP but received no response from a DHCP server.

## 4. Step-by-Step Procedure
1. **Check Physical Interface:** Verify cable connection or Wi-Fi SSID association.
2. **Review IP Configuration:** Execute `ipconfig /all`. Inspect IPv4 Address, Subnet Mask, Gateway, DHCP Server, and DNS Servers.
3. **Loopback Test:** Ping `127.0.0.1` to confirm local TCP/IP protocol stack functionality.
4. **Default Gateway Ping:** Ping the local router/gateway IP to verify local LAN segment communication.
5. **External IP Ping:** Ping a known internet IP (e.g., `8.8.8.8` or `1.1.1.1`) to confirm WAN routing.
6. **DNS Resolution Test:** Execute `nslookup google.com` or ping a domain name to verify DNS operation.
7. **Trace Routing:** Run `tracert` to pinpoint which network hop drops packets.
8. **Renew DHCP Lease:** Execute `ipconfig /release` followed by `ipconfig /renew`.
9. **Flush DNS Cache:** Execute `ipconfig /flushdns` to clear stale or poisoned resolver entries.
10. **Winsock & IP Stack Reset:** Execute network reset commands if network stack is corrupted.

## 5. Commands Used

### Command 1: Full Adapter Inspection
```cmd
ipconfig /all
```
- **What it does:** Displays comprehensive network configuration for all physical and virtual adapters.
- **Why it is used:** Identifies whether adapter received an IP from DHCP or defaulted to APIPA (169.254.x.x).

### Command 2: DHCP Lease Renewal & DNS Flush
```cmd
ipconfig /release
ipconfig /renew
ipconfig /flushdns
```
- **What it does:** Releases the active DHCP lease, requests a fresh IP lease from the DHCP server, and purges the local DNS resolver cache.
- **Why it is used:** Resolves IP conflicts, lease expirations, and stale DNS mappings in seconds.

### Command 3: Name Resolution Diagnostic
```cmd
nslookup intranet.lab.local
```
- **What it does:** Directly queries the configured DNS server for an A record.
- **Why it is used:** Isolates DNS failures from broader network connection issues.

### Command 4: PowerShell Port Connectivity Check
```powershell
Test-NetConnection -ComputerName 192.168.100.10 -Port 445
```
- **What it does:** Tests TCP three-way handshake against a specific remote IP and port (e.g., Port 445 SMB File Sharing).
- **Why it is used:** Modern replacement for Telnet to determine if host firewalls are blocking service ports.

### Command 5: Network Stack Reset
```cmd
netsh winsock reset
netsh int ip reset
```
- **What it does:** Resets the Windows Sockets catalog to clean state and resets TCP/IP stack registry keys.
- **Why it is used:** Fixes persistent connectivity failure after malware removal, VPN uninstallation, or driver corruption.

## 6. Expected Result
The technician systematically isolates the layer of failure, restores valid IP configuration, clears DNS anomalies, and re-establishes end-to-end network connectivity.

## 7. Troubleshooting
- **Issue: Client IP is 169.254.120.45 (APIPA):**
  - *Cause:* DHCP server unreachable, cable unplugged, switch port disabled, or DHCP pool exhausted.
  - *Solution:* Check physical cabling and link lights; verify DHCP server service is active; test with temporary static IP.
- **Issue: Can ping IP addresses but cannot open websites by domain name:**
  - *Cause:* DNS failure (invalid DNS server configured, DNS server offline, or DNS cache corrupted).
  - *Solution:* Run `ipconfig /flushdns`; verify DNS server IP in adapter properties; test with public DNS (`8.8.8.8`).

## 8. Screenshots / Evidence
- `screenshots/08-ipconfig-all-output.png` — *Pending lab execution: Capture ipconfig /all output.*
- `screenshots/08-ping-tests.png` — *Pending lab execution: Capture gateway and external ping tests.*
- `screenshots/08-test-netconnection.png` — *Pending lab execution: Capture PowerShell Test-NetConnection port check.*

## 9. Practical Learning Outcome
Expertise in structured OSI Layer 1-7 network troubleshooting, interpreting IP addressing states, resolving DNS bottlenecks, and testing TCP service connectivity.

## 10. Completion Status
Documented
