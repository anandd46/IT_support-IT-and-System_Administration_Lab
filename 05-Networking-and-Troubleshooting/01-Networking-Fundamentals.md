# Practical Task: Networking Fundamentals, OSI Model, and Protocols

## 1. Objective
Establish theoretical and practical foundations of enterprise networking, compare OSI and TCP/IP models, examine common protocol architectures, and identify standard networking ports.

## 2. Requirements
- Command Prompt, PowerShell, or Linux terminal
- Network diagnostic utilities (`netstat`, `ss`, `curl`)

## 3. Background
All enterprise, desktop, and maritime IT systems depend on reliable data transmission across local and wide area networks:
- **LAN (Local Area Network):** High-speed interconnects within a single building, floor, or vessel.
- **WAN (Wide Area Network):** Geographically dispersed networks connected via leased lines or satellite links (VSAT).
- **WLAN (Wireless LAN):** Wi-Fi networks (IEEE 802.11a/b/g/n/ac/ax).

### The OSI 7-Layer Model Reference:
| Layer | Name | Function | Protocols / Devices |
|---|---|---|---|
| 7 | Application | User-facing network services | HTTP, HTTPS, DNS, DHCP, SSH, SMB |
| 6 | Presentation | Data formatting, encryption, compression | TLS/SSL, ASCII, JPEG |
| 5 | Session | Dialogue control, establishing connections | NetBIOS, RPC, Sockets |
| 4 | Transport | End-to-end transport, port numbers | TCP (reliable), UDP (fast) |
| 3 | Network | Logical addressing and routing | IPv4, IPv6, ICMP, Routers |
| 2 | Data Link | Physical addressing (MAC), framing | Ethernet, 802.11 Wi-Fi, Switches |
| 1 | Physical | Electrical signals, radio waves, light pulses | Cat6 copper, Fiber optic, Access Points |

### Standard Ports Every IT Support Specialist Must Know:
- **20/21:** FTP (File Transfer Protocol)
- **22:** SSH (Secure Shell) & SFTP
- **25:** SMTP (Simple Mail Transfer)
- **53:** DNS (Domain Name System)
- **67/68:** DHCP (Dynamic Host Configuration Protocol)
- **80:** HTTP (Hypertext Transfer Protocol)
- **110:** POP3 (Post Office Protocol v3)
- **143:** IMAP (Internet Message Access Protocol)
- **443:** HTTPS (HTTP Secure over TLS)
- **445:** SMB (Server Message Block - Windows File Sharing)
- **3389:** RDP (Remote Desktop Protocol)

## 4. Step-by-Step Procedure
1. **Inspect Active TCP Sockets:** Run `netstat -an` in Windows or `ss -tlnp` in Linux to view listening ports.
2. **Identify Established Sessions:** Filter for `ESTABLISHED` connections to identify remote web and cloud endpoints.
3. **Correlate Ports to Applications:** Run `netstat -b` (elevated) to observe the exact executable binding each local port.
4. **Compare TCP vs UDP:** Analyze why web browsing utilizes TCP (guaranteed delivery) while VoIP / video streaming utilizes UDP (low latency without retransmission).

## 5. Commands Used

### Command 1: Inspect Listening Ports & Process IDs (Windows)
```cmd
netstat -ano | findstr /i "LISTENING"
```
- **What it does:** Displays all ports currently listening for inbound connections along with the responsible Process ID (PID).

### Command 2: Linux Socket Statistics
```bash
ss -tulpn
```
- **What it does:** Displays listening TCP (`-t`) and UDP (`-u`) sockets with process names (`-p`) and numeric ports (`-n`).

## 6. Expected Result
The technician explains the OSI layer responsible for any given symptom, maps port numbers to network services, and queries active sockets across endpoints.

## 7. Troubleshooting
- **Issue: Port conflict error ("Address already in use"):**
  - *Cause:* Two applications are attempting to bind to the same IP and port (e.g., IIS and Apache both attempting Port 80).
  - *Solution:* Identify the conflicting PID using `netstat -ano` and reconfigure one application to an alternate port (e.g., 8080).

## 8. Screenshots / Evidence
- `screenshots/01-netstat-listening-ports.png` — *Pending lab execution: Capture netstat listening ports output.*

## 9. Practical Learning Outcome
Solid grasp of network layers, protocol functions, transport reliability differences, and port monitoring.

## 10. Completion Status
Documented
