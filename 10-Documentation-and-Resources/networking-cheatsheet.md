# Enterprise Networking Quick Reference Cheatsheet

---

## 1. The OSI vs. TCP/IP Model

| OSI Layer # | OSI Layer Name | TCP/IP Layer | Data Unit (PDU) | Core Protocols / Devices |
|---|---|---|---|---|
| **Layer 7** | Application | Application | Data | HTTP, HTTPS, DNS, DHCP, SSH, SMB, RDP |
| **Layer 6** | Presentation | Application | Data | TLS, SSL, JPEG, ASCII |
| **Layer 5** | Session | Application | Data | NetBIOS, RPC, Sockets |
| **Layer 4** | Transport | Transport | Segment (TCP) / Datagram (UDP) | TCP (Reliable), UDP (Connectionless) |
| **Layer 3** | Network | Internet | Packet | IPv4, IPv6, ICMP, ARP, Routers |
| **Layer 2** | Data Link | Network Access | Frame | Ethernet, 802.11 Wi-Fi, MAC addresses, Switches |
| **Layer 1** | Physical | Network Access | Bit | Cat6 copper, Fiber optic, RJ45, Radio signals |

---

## 2. Standard Port Numbers

| Port | Protocol | Transport | Function & Purpose |
|---|---|---|---|
| **20/21** | FTP | TCP | File Transfer Protocol (Data/Control) |
| **22** | SSH / SFTP | TCP | Secure Shell encrypted remote administration |
| **23** | Telnet | TCP | Unencrypted legacy remote terminal (Insecure!) |
| **25** | SMTP | TCP | Simple Mail Transfer Protocol (Mail routing) |
| **53** | DNS | UDP / TCP | Domain Name System name resolution |
| **67/68** | DHCP | UDP | Dynamic Host Configuration (67 Server / 68 Client) |
| **80** | HTTP | TCP | Unencrypted World Wide Web traffic |
| **88** | Kerberos | TCP / UDP | Active Directory authentication protocol |
| **110** | POP3 | TCP | Post Office Protocol email retrieval |
| **123** | NTP | UDP | Network Time Protocol clock synchronization |
| **143** | IMAP | TCP | Internet Message Access Protocol email sync |
| **389** | LDAP | TCP / UDP | Lightweight Directory Access Protocol (Active Directory) |
| **443** | HTTPS | TCP | Encrypted HTTP over TLS/SSL |
| **445** | SMB | TCP | Server Message Block (Windows File Sharing) |
| **636** | LDAPS | TCP | Secure LDAP over TLS/SSL |
| **993** | IMAPS | TCP | Secure IMAP over TLS/SSL |
| **995** | POP3S | TCP | Secure POP3 over TLS/SSL |
| **3389** | RDP | TCP / UDP | Microsoft Remote Desktop Protocol |
| **9100** | JetDirect | TCP | Raw network laser printer data stream |

---

## 3. IPv4 Subnetting & CIDR Quick Reference

| CIDR Prefix | Subnet Mask | Usable Hosts ($2^H - 2$) | Total Addresses ($2^H$) |
|---|---|---|---|
| `/24` | `255.255.255.0` | **254** | 256 |
| `/25` | `255.255.255.128` | **126** | 128 |
| `/26` | `255.255.255.192` | **62** | 64 |
| `/27` | `255.255.255.224` | **30** | 32 |
| `/28` | `255.255.255.240` | **14** | 16 |
| `/29` | `255.255.255.248` | **6** | 8 |
| `/30` | `255.255.255.252` | **2** | 4 (Router Point-to-Point) |
| `/32` | `255.255.255.255` | **1** | 1 (Single Host Route) |

### Special IPv4 Address Ranges:
- **`127.0.0.1` (`127.0.0.0/8`):** Loopback / Localhost (tests local IP stack).
- **`169.254.0.0/16`:** Automatic Private IP Addressing (APIPA - indicates DHCP failure).
- **`0.0.0.0`:** Represents the default route / unassigned interface state.
- **`255.255.255.255`:** Local subnet broadcast address.

---

## 4. DNS Record Types Summary

| Record | Name | Function |
|---|---|---|
| **A** | Address | Maps FQDN to 32-bit IPv4 address (`server01.lab.local` -> `192.168.100.10`) |
| **AAAA** | IPv6 Address | Maps FQDN to 128-bit IPv6 address |
| **CNAME** | Canonical Name | Creates alias pointing to another A record (`ftp.lab.local` -> `server01.lab.local`) |
| **MX** | Mail Exchanger | Identifies SMTP mail servers handling domain email |
| **PTR** | Pointer | Reverse DNS mapping IP to FQDN (`10.100.168.192.in-addr.arpa` -> `server01`) |
| **SRV** | Service Locator | Identifies hostname and port for services (e.g., LDAP, Kerberos) |
| **SOA** | Start of Authority | Identifies authoritative primary DNS server and zone serial number |
| **TXT** | Text Record | Stores human/machine-readable text (SPF, DKIM, DMARC email security) |
