# Practical Task: Domain Name System (DNS) Troubleshooting and Configuration

## 1. Objective
Diagnose DNS resolution failures, query authoritative name servers using `nslookup` and `dig`, inspect local resolver caches, and clear DNS cache anomalies.

## 2. Requirements
- Windows 11 client or Linux host
- DNS query tools (`nslookup`, `dig`, `Resolve-DnsName`)
- Access to enterprise DNS (`SERVER01`) or public DNS (`8.8.8.8`)

## 3. Background
DNS is the phonebook of the internet, translating human-friendly Fully Qualified Domain Names (FQDNs, e.g., `server01.lab.local`) into routable IP addresses (`192.168.100.10`).

Core DNS Record Types:
- **A Record:** Resolves hostname to IPv4 address.
- **AAAA Record:** Resolves hostname to IPv6 address.
- **CNAME (Canonical Name):** Alias pointing one hostname to another.
- **MX (Mail Exchange):** Points email traffic to designated mail servers.
- **PTR (Pointer):** Reverse lookup (IP address to hostname).
- **SRV (Service):** Locates network services (critical for Active Directory LDAP/Kerberos).

## 4. Step-by-Step Procedure
1. **Standard Forward Lookup:** Run `nslookup lab.local` to verify domain controller lookup.
2. **Targeted Server Query:** Query a specific external DNS server (`nslookup google.com 8.8.8.8`) to bypass local DNS servers during triage.
3. **Reverse Lookup:** Query IP address to find associated hostname: `nslookup 192.168.100.10`.
4. **Inspect Windows DNS Cache:** View cached entries using `ipconfig /displaydns`.
5. **Flush DNS Cache:** Flush local cache using `ipconfig /flushdns` (or `sudo systemd-resolve --flush-caches` on Linux).
6. **Local Hosts File Inspection:** Inspect `C:\Windows\System32\drivers\etc\hosts` (takes precedence over DNS).

## 5. Commands Used

### Command 1: Interactive NSLookup
```cmd
nslookup
server 192.168.100.10
set type=A
SERVER01.lab.local
set type=SRV
_ldap._tcp.dc._msdcs.lab.local
exit
```
- **What it does:** Enters interactive DNS diagnostic mode, targets the lab domain controller, and queries both standard A records and Active Directory domain controller locator SRV records.

### Command 2: PowerShell DNS Query
```powershell
Resolve-DnsName -Name "SERVER01.lab.local" -Type A
```
- **What it does:** Modern structured cmdlet returning IP addresses, TTL, and authoritative answer flags.

### Command 3: Flushing Resolver Cache
```cmd
ipconfig /flushdns
```
- **What it does:** Purges the local client DNS resolver cache, eliminating poisoned, stale, or expired records.

## 6. Expected Result
The technician rapidly isolates whether an application outage is caused by routing/firewall failures or DNS resolution breakdown.

## 7. Troubleshooting
- **Issue: User can connect to shared folders by IP (`\\192.168.100.10`) but NOT by name (`\\SERVER01`):**
  - *Cause:* Classic DNS resolution failure. The client machine cannot resolve the server hostname.
  - *Solution:* Verify client adapter DNS server points to `192.168.100.10`; run `ipconfig /flushdns`.

## 8. Screenshots / Evidence
- `screenshots/03-nslookup-forward-lookup.png` — *Pending lab execution: Capture nslookup query output.*
- `screenshots/03-flushdns-output.png` — *Pending lab execution: Capture successful ipconfig /flushdns output.*

## 9. Practical Learning Outcome
Ability to trace and resolve name resolution failures, query individual record types, and maintain DNS client health.

## 10. Completion Status
Documented
