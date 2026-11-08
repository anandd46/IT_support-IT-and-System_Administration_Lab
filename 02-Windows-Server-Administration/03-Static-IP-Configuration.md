# Practical Task: Static IP Configuration on Windows Server 2022

## 1. Objective
Assign a persistent static IPv4 address, subnet mask, default gateway, and loopback DNS resolver to Windows Server 2022 using GUI and PowerShell.

## 2. Requirements
- Windows Server 2022 (`SERVER01`)
- Isolated lab network / VirtualBox Host-Only adapter (`192.168.100.0/24`)
- Administrator privileges

## 3. Background
Servers providing enterprise directory services, file repositories, and name resolution cannot use dynamic DHCP addresses. If a domain controller's IP changes, client workstations immediately lose authentication, shared folders disconnect, and Group Policy updates fail.

Planned Lab Addressing Scheme:
- **Server Name:** `SERVER01`
- **IPv4 Address:** `192.168.100.10`
- **Subnet Mask:** `255.255.255.0` (`/24`)
- **Default Gateway:** `192.168.100.1` (virtual lab router)
- **Preferred DNS:** `127.0.0.1` (loopback pointing to its future local DNS server)

## 4. Step-by-Step Procedure
1. **Network Connections:** Press Win + R, type `ncpa.cpl`, and press Enter.
2. **Adapter Properties:** Right-click Ethernet adapter > Properties > Double-click `Internet Protocol Version 4 (TCP/IPv4)`.
3. **Manual Entry:** Select "Use the following IP address" and enter:
   - IP address: `192.168.100.10`
   - Subnet mask: `255.255.255.0`
   - Default gateway: `192.168.100.1`
   - Preferred DNS server: `127.0.0.1`
4. **PowerShell Configuration:** Alternatively, configure via `New-NetIPAddress` and `Set-DnsClientServerAddress`.
5. **Verify Configuration:** Execute `ipconfig /all` and verify that DHCP is listed as disabled.

## 5. Commands Used

### Command 1: Assign Static IP Address
```powershell
Get-NetAdapter | Where-Object Status -eq "Up" | New-NetIPAddress -IPAddress 192.168.100.10 -PrefixLength 24 -DefaultGateway 192.168.100.1
```
- **What it does:** Binds IP `192.168.100.10` with `/24` subnet and gateway `192.168.100.1` to the active network interface.

### Command 2: Set DNS to Loopback
```powershell
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses ("127.0.0.1")
```
- **What it does:** Configures the network adapter to resolve DNS queries through local DNS service.

### Command 3: Verification
```cmd
ipconfig /all
```
- **What it does:** Displays full interface configuration. Confirms `DHCP Enabled . . . . . . . . . . . : No`.

## 6. Expected Result
The server retains a static IPv4 address `192.168.100.10/24` with zero reliance on DHCP.

## 7. Troubleshooting
- **Issue: "The default gateway does not belong to one of the configured subnets":**
  - *Cause:* Typo in gateway IP or incorrect subnet mask prefix length.
  - *Solution:* Verify both server and gateway share the first 24 bits (`192.168.100.x`).

## 8. Screenshots / Evidence
- `screenshots/03-static-ip-gui.png` — *Pending lab execution: Capture IPv4 properties dialog.*
- `screenshots/03-ipconfig-verify.png` — *Pending lab execution: Capture ipconfig /all output.*

## 9. Practical Learning Outcome
Ability to correctly plan, calculate, and implement static IP configurations required for servers.

## 10. Completion Status
Documented
