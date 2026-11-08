# Practical Task: Network Diagnostic Commands Reference (Windows vs. Linux)

## 1. Objective
Provide a unified, side-by-side practical reference and syntax guide for all core network diagnostic tools across Windows and Linux.

## 2. Requirements
- Windows 11 / Windows Server command prompt & PowerShell
- Ubuntu Linux Bash shell

## 3. Background
Support engineers working in heterogeneous enterprise environments must effortlessly transition between Windows and Linux command-line diagnostic utilities.

---

## 4. Command Comparison Matrix

| Diagnostic Purpose | Windows Command (CMD / PowerShell) | Linux Command (Bash) |
|---|---|---|
| View IP Configuration | `ipconfig /all` | `ip addr show` / `ip -br a` |
| Release DHCP Lease | `ipconfig /release` | `sudo dhclient -r` |
| Renew DHCP Lease | `ipconfig /renew` | `sudo dhclient` |
| Flush DNS Resolver Cache | `ipconfig /flushdns` | `sudo systemd-resolve --flush-caches` |
| Test Connectivity | `ping -n 4 <target>` | `ping -c 4 <target>` |
| Continuous Ping | `ping -t <target>` | `ping <target>` (default is continuous) |
| Trace Route | `tracert <target>` | `traceroute <target>` / `tracepath` |
| DNS Name Query | `nslookup <name>` | `nslookup <name>` / `dig <name>` |
| Query Reverse DNS | `nslookup <ip>` | `dig -x <ip>` |
| View ARP Table | `arp -a` | `ip neigh` / `arp -n` |
| View Routing Table | `route print` | `ip route show` |
| Inspect Active Sockets | `netstat -ano` | `ss -tulpn` |
| Test TCP Port Reachability | `Test-NetConnection <ip> -Port <p>` | `nc -zv <ip> <p>` / `curl -v telnet://<ip>:<p>` |
| Network Adapter Status | `Get-NetAdapter` | `ip link show` |

---

## 5. Practical CLI Demonstrations

### Windows PowerShell TCP Handshake Check
```powershell
Test-NetConnection -ComputerName 8.8.8.8 -Port 53
```
- **Expected Output:**
```text
ComputerName     : 8.8.8.8
RemoteAddress    : 8.8.8.8
RemotePort       : 53
TcpTestSucceeded : True
```

### Linux Netcat Port Reachability Check
```bash
nc -zv 192.168.100.10 445
```
- **Expected Output:**
```text
Connection to 192.168.100.10 445 port [tcp/microsoft-ds] succeeded!
```

## 6. Expected Result
The technician fluidly applies equivalent commands across both Windows and Linux operating systems to troubleshoot identical network symptoms.

## 7. Troubleshooting
- **Issue: `traceroute` command not found on Ubuntu:**
  - *Cause:* Package not installed by default in minimal server installs.
  - *Solution:* Install via `sudo apt install traceroute` or use built-in `tracepath`.

## 8. Screenshots / Evidence
- `screenshots/08-test-netconnection-port.png` — *Pending lab execution: Capture Test-NetConnection output.*

## 9. Practical Learning Outcome
Bilingual CLI proficiency across Windows and Linux network administration stacks.

## 10. Completion Status
Documented
