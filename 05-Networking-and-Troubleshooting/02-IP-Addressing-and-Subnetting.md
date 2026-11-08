# Practical Task: IPv4 Addressing, Subnetting, and CIDR Calculations

## 1. Objective
Calculate IPv4 subnets, determine network and broadcast boundaries, calculate usable host ranges, and master Classless Inter-Domain Routing (CIDR) notation.

## 2. Requirements
- Scratchpad / subnet calculator
- Workstation terminal

## 3. Background
An IPv4 address consists of 32 binary bits divided into 4 octets separated by dots (e.g., `192.168.1.50`). The **Subnet Mask** divides the address into a **Network ID** (identifying the wire) and a **Host ID** (identifying the specific device on that wire).

### Private RFC 1918 Address Spaces:
- **Class A:** `10.0.0.0` to `10.255.255.255` (`10.0.0.0/8`) — 16,777,216 addresses.
- **Class B:** `172.16.0.0` to `172.31.255.255` (`172.16.0.0/12`) — 1,048,576 addresses.
- **Class C:** `192.168.0.0` to `192.168.255.255` (`192.168.0.0/16`) — 65,536 addresses.

### Common Subnet Masks and Host Capacities:
| CIDR | Subnet Mask | Total IPs | Usable Hosts ($2^H - 2$) | Typical Use Case |
|---|---|---|---|---|
| `/24` | `255.255.255.0` | 256 | 254 | Standard department LAN / Office |
| `/25` | `255.255.255.128` | 128 | 126 | Split department |
| `/26` | `255.255.255.192` | 64 | 62 | Small department / Server subnet |
| `/27` | `255.255.255.224` | 32 | 30 | Management / DMZ |
| `/28` | `255.255.255.240` | 16 | 14 | Infrastructure cluster |
| `/30` | `255.255.255.252` | 4 | 2 | Point-to-point router links |

*Formula:* Usable hosts = $2^{(32 - \text{CIDR})} - 2$ (subtracting 2 for Network ID and Broadcast address).

## 4. Step-by-Step Procedure
1. **Analyze Lab Addressing:**
   - IP: `192.168.100.10/24`
   - Subnet Mask: `255.255.255.0`
   - Network Address: `192.168.100.0`
   - Usable Host Range: `192.168.100.1` through `192.168.100.254`
   - Broadcast Address: `192.168.100.255`
2. **Subnetting Scenario:** Divide `192.168.100.0/24` into two equal subnets for Crew and Guests:
   - **Subnet 1 (Crew):** `192.168.100.0/25` (Mask: `255.255.255.128`). Usable: `192.168.100.1` – `192.168.100.126`. Broadcast: `192.168.100.127`.
   - **Subnet 2 (Guest):** `192.168.100.128/25` (Mask: `255.255.255.128`). Usable: `192.168.100.129` – `192.168.100.254`. Broadcast: `192.168.100.255`.
3. **Verify Routing Boundary:** Observe why two hosts on different subnets require a Default Gateway (Layer 3 router) to communicate.

## 5. Commands Used

### Command 1: Inspect Subnet Mask & Gateway (Windows)
```cmd
ipconfig
```

### Command 2: PowerShell Subnet Mask Bit Calculation
```powershell
Get-NetIPAddress -InterfaceAlias "Ethernet" -AddressFamily IPv4 | Select-Object IPAddress, PrefixLength
```
- **What it does:** Displays the IPv4 address along with CIDR prefix length (e.g., `24`).

## 6. Expected Result
The technician calculates valid network ranges, identifies broadcast addresses, sizes subnets according to host counts, and troubleshoots incorrect subnet mask configurations.

## 7. Troubleshooting
- **Issue: Two computers on the same physical switch cannot ping each other:**
  - *Cause:* Subnet masks misconfigured (e.g., one set to `255.255.255.0` and the other to `255.255.255.128`, placing them in separate logical subnets).
  - *Solution:* Standardize subnet masks on both endpoints.

## 8. Screenshots / Evidence
- `screenshots/02-ipconfig-prefix-verify.png` — *Pending lab execution: Capture subnet configuration.*

## 9. Practical Learning Outcome
Mastery in enterprise IP address planning, binary subnet masking, and CIDR allocation.

## 10. Completion Status
Documented
