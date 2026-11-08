# Practical Task: Initial Windows Server 2022 Configuration and Hardening

## 1. Objective
Perform post-installation baseline configuration on Windows Server 2022, including computer renaming to `SERVER01`, timezone synchronization, Remote Desktop configuration, and basic firewall rules.

## 2. Requirements
- Fresh installation of Windows Server 2022 Standard (Desktop Experience)
- Local Administrator credentials
- VirtualBox Host-Only or Internal network connection
- PowerShell 5.1+

## 3. Background
Before installing enterprise server roles such as Active Directory Domain Services or DNS, Windows Server must establish a predictable identity. Random machine names (e.g., `WIN-982FKLMS`) cause severe authentication and Kerberos ticket failures if renamed after domain promotion. Establishing precise time sync is also mandatory for Kerberos authentication (tolerance is within 5 minutes).

## 4. Step-by-Step Procedure
1. **Server Manager Review:** Log in as Administrator. Allow Server Manager to load. Inspect Local Server properties.
2. **Rename Server:** Rename the computer to `SERVER01` using PowerShell or System Properties.
3. **Configure Time Zone:** Set appropriate time zone (e.g., UTC or local ship operational time).
4. **Enable Remote Desktop:** Enable Remote Desktop with Network Level Authentication (NLA) for secure headless administration.
5. **Configure Windows Defender Firewall:** Ensure standard inbound management rules (ICMP Echo Request, WinRM, RDP) are authorized.
6. **Reboot Server:** Restart to commit the new NetBIOS name and configuration changes.

## 5. Commands Used

### Command 1: Computer Renaming & Restart
```powershell
Rename-Computer -NewName "SERVER01" -Force -Restart
```
- **What it does:** Updates the host and NetBIOS name in the local SAM database and reboots the server immediately.
- **Why it is used:** Required prior to domain controller promotion.

### Command 2: Setting Time Zone
```powershell
Set-TimeZone -Id "UTC"
Get-TimeZone
```
- **What it does:** Configures the server system clock to UTC.
- **Why it is used:** Maritime and enterprise server standard to prevent multi-time-zone synchronization errors.

### Command 3: Enabling Remote Desktop via Registry & Firewall
```powershell
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name "fDenyTSConnections" -Value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
```
- **What it does:** Enables RDP connections and permits port 3389 through Windows Defender Firewall.

## 6. Expected Result
The server restarts with the permanent hostname `SERVER01`, accurate time zone synchronization, and Remote Desktop enabled for administrative access.

## 7. Troubleshooting
- **Issue: Cannot connect via Remote Desktop after enabling:**
  - *Cause:* Network profile is set to Public, blocking RDP port 3389.
  - *Solution:* Set network connection to Private: `Set-NetConnectionProfile -InterfaceAlias "Ethernet" -NetworkCategory Private`.

## 8. Screenshots / Evidence
- `screenshots/02-local-server-properties.png` — *Pending lab execution: Capture Server Manager Local Server pane.*
- `screenshots/02-rename-computer-ps.png` — *Pending lab execution: Capture Rename-Computer PowerShell output.*

## 9. Practical Learning Outcome
Proficiency in preparing clean, standardized enterprise server baselines ready for critical infrastructure role deployment.

## 10. Completion Status
Documented
