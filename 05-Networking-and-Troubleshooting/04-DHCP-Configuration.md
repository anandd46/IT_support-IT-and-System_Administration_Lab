# Practical Task: Dynamic Host Configuration Protocol (DHCP) Troubleshooting

## 1. Objective
Analyze the DHCP 4-step lease process (DORA), identify DHCP scope exhaustion, resolve APIPA address assignments, and perform manual lease releases and renewals.

## 2. Requirements
- Client workstation (`CLIENT01`)
- DHCP Server (Router or Windows Server DHCP role)
- Command line utilities (`ipconfig`)

## 3. Background
DHCP automates network configuration, dynamically providing:
- IPv4 Address and Subnet Mask
- Default Gateway
- DNS Server addresses
- Domain search suffixes and lease durations

### The DHCP DORA Process:
1. **D**iscover: Client broadcasts `DHCPDISCOVER` to find available DHCP servers on the subnet.
2. **O**ffer: DHCP server unicasts/broadcasts `DHCPOFFER` proposing an available IP address.
3. **R**equest: Client broadcasts `DHCPREQUEST` formally requesting the proposed IP.
4. **A**cknowledge: DHCP server sends `DHCPACK` confirming lease and providing options.

### The APIPA Warning Sign (`169.254.0.0/16`):
If a Windows client sends a `DHCPDISCOVER` but receives zero responses after multiple attempts, Windows invokes **Automatic Private IP Addressing (APIPA)**, assigning an IP in `169.254.x.x`.
**An APIPA address is definitive proof of DHCP communication failure!**

## 4. Step-by-Step Procedure
1. **Inspect Active Lease:** Run `ipconfig /all`. Note Lease Obtained, Lease Expires, and DHCP Server IP.
2. **Simulate Lease Expiration:** Run `ipconfig /release` to send a DHCPRELEASE packet. Observe interface loses IP.
3. **Obtain Fresh Lease:** Run `ipconfig /renew` to initiate a new DORA handshake.
4. **Simulate DHCP Failure:** Disconnect network cable or disable DHCP server VM; run `ipconfig /renew`.
5. **Observe APIPA Assignment:** Note that Windows falls back to `169.254.x.x`.
6. **DHCP Reservation (Concept):** Document why network printers and servers should use DHCP MAC Reservations if not statically addressed.

## 5. Commands Used

### Command 1: Release Active DHCP Lease
```cmd
ipconfig /release
```
- **What it does:** Releases the IP address lease back to the DHCP server pool and resets interface IP to `0.0.0.0`.

### Command 2: Request New Lease
```cmd
ipconfig /renew
```
- **What it does:** Broadcasts a new DHCPDISCOVER request to acquire valid IP parameters.

### Command 3: Query DHCP Lease Information via PowerShell
```powershell
Get-CimInstance Win32_NetworkAdapterConfiguration -Filter "DHCPEnabled=True" | Select-Object Description, DHCPServer, DHCPAcquired, DHCPLeaseExpires
```

## 6. Expected Result
The technician understands the DORA lifecycle, successfully diagnoses APIPA failure states, and refreshes client leases.

## 7. Troubleshooting
- **Issue: Computer repeatedly receives APIPA `169.254.x.x`:**
  - *Cause:* Physical cable disconnected, switch port on wrong VLAN, DHCP scope out of available addresses, or rogue DHCP server.
  - *Solution:* Verify link LED on switch; check DHCP scope pool statistics on server; test with temporary static IP.

## 8. Screenshots / Evidence
- `screenshots/04-ipconfig-renew-success.png` — *Pending lab execution: Capture successful ipconfig /renew.*
- `screenshots/04-apipa-state-detected.png` — *Pending lab execution: Capture 169.254.x.x APIPA assignment.*

## 9. Practical Learning Outcome
Mastery in diagnosing dynamic addressing failures, interpreting lease metadata, and troubleshooting DHCP infrastructure.

## 10. Completion Status
Documented
