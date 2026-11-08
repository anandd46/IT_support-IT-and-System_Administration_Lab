# Complete Windows Command-Line and PowerShell Reference

This master cheatsheet provides an index of the most essential Windows command-line (`cmd.exe`) and PowerShell commands utilized in IT support and system administration.

---

## 1. Network Diagnostics & Configuration

| Utility | Syntax | Purpose & Description |
|---|---|---|
| `ipconfig` | `ipconfig /all` | Displays complete network adapter details, MAC addresses, DHCP lease times, and DNS servers. |
| `ipconfig` | `ipconfig /release` | Drops current DHCP lease on all adapters; sets IP to `0.0.0.0`. |
| `ipconfig` | `ipconfig /renew` | Broadcasts DHCP discover request to acquire fresh IP address and subnet configuration. |
| `ipconfig` | `ipconfig /flushdns` | Purges the local client DNS resolver cache, clearing poisoned or stale domain records. |
| `ping` | `ping -n 10 192.168.100.1` | Sends 10 ICMP echo requests to evaluate packet loss and round-trip latency to default gateway. |
| `ping` | `ping -t 8.8.8.8` | Sends continuous ICMP pings until interrupted with Ctrl + C to detect network drops. |
| `tracert` | `tracert 8.8.8.8` | Traces route to target using TTL expiration to identify which intermediate router drops packets. |
| `pathping` | `pathping 8.8.8.8` | Combines ping and traceroute over a 2-minute test to compute packet loss per router hop. |
| `nslookup` | `nslookup SERVER01.lab.local` | Queries configured DNS server directly for forward A records or reverse PTR records. |
| `netstat` | `netstat -ano` | Displays all active TCP/UDP connections, listening ports, and corresponding Process IDs (PIDs). |
| `arp` | `arp -a` | Displays the local Address Resolution Protocol table mapping IPv4 addresses to physical MAC addresses. |
| `route` | `route print` | Displays the local IPv4/IPv6 routing table, default gateways, and network interface metrics. |
| `netsh` | `netsh winsock reset` | Resets the Windows Sockets API catalog to clean state; fixes broken TCP/IP stacks. |
| `netsh` | `netsh int ip reset` | Resets TCP/IP stack registry keys to default values; requires computer reboot. |
| `Test-NetConnection` | `Test-NetConnection -ComputerName 192.168.100.10 -Port 445` | (PowerShell) Modern telnet replacement; validates TCP 3-way handshake against remote server ports. |

---

## 2. Operating System, Performance & File System Diagnostics

| Utility | Syntax | Purpose & Description |
|---|---|---|
| `systeminfo` | `systeminfo` | Outputs detailed OS build, BIOS version, total RAM, hotfix list, and network card hardware. |
| `sfc` | `sfc /scannow` | System File Checker; scans protected Windows DLLs and repairs corrupted files from WinSxS cache. |
| `dism` | `dism /online /cleanup-image /restorehealth` | Deployment Image Servicing and Management; repairs corrupted Windows Component Store from Windows Update. |
| `chkdsk` | `chkdsk C: /f /r` | Checks disk volume for file system errors (`/f`) and locates bad sectors recovering readable data (`/r`). |
| `diskpart` | `diskpart` | Scriptable disk partitioning utility; inspects physical disks, creates partitions, and assigns letters. |
| `tasklist` | `tasklist /v` | Lists all active processes with user sessions, memory usage, and CPU times. |
| `taskkill` | `taskkill /IM app.exe /F` | Forcefully terminates the specified executable process and child threads. |
| `shutdown` | `shutdown /r /t 60 /c "Scheduled reboot"` | Schedules a controlled server restart in 60 seconds with an audit log reason. |
| `slmgr` | `slmgr.vbs /dli` | Software License Manager; displays Windows activation status, license type, and KMS host info. |
| `gpupdate` | `gpupdate /force` | Forces immediate background refresh of all Active Directory Computer and User Group Policies. |
| `gpresult` | `gpresult /r` | Generates summary of applied Group Policy Objects (GPOs) and security group memberships. |
| `w32tm` | `w32tm /resync /force` | Forces immediate clock synchronization with the authoritative domain controller time server. |

---

## 3. Core PowerShell Administration Cmdlets

```powershell
# Get Deep Computer & BIOS Information
Get-CimInstance Win32_OperatingSystem | Select-Object Caption, Version, LastBootUpTime
Get-CimInstance Win32_Bios | Select-Object Manufacturer, SerialNumber, SMBIOSBIOSVersion

# Query Top 5 Memory Consuming Processes
Get-Process | Sort-Object WorkingSet64 -Descending | Select-Object -First 5 ProcessName, Id, @{N='Memory(MB)';E={[math]::Round($_.WorkingSet64/1MB,2)}}

# Query Stopped Automatic Windows Services
Get-Service | Where-Object { $_.StartType -eq 'Automatic' -and $_.Status -ne 'Running' }

# Network Adapter Telemetry
Get-NetAdapter | Select-Object Name, InterfaceDescription, Status, LinkSpeed, MacAddress
Get-NetIPAddress -AddressFamily IPv4 | Select-Object InterfaceAlias, IPAddress, PrefixLength
```
