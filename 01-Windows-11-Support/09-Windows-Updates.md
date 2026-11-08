# Practical Task: Windows Update Management and Component Reset

## 1. Objective
Administer Windows Update settings, configure update deferrals, diagnose update installation failures, and execute a complete Windows Update component reset in Windows 11.

## 2. Requirements
- Windows 11 workstation
- Administrator privileges
- Internet connectivity (or local WSUS / delivery optimization source)
- Tools: Settings app, Command Prompt, PowerShell

## 3. Background
Keeping operating systems patched against known vulnerabilities is a fundamental cybersecurity and IT administration mandate. Windows 11 updates are categorized as:
- **Quality Updates:** Monthly security fixes, cumulative patches, and servicing stack updates (B-release / Patch Tuesday).
- **Feature Updates:** Annual major operating system milestone updates providing new functionality (e.g., 22H2, 23H2).
- **Driver / Definition Updates:** Hardware drivers and Microsoft Defender signature updates.

Common failure symptoms include updates stuck at 0% or 100%, rollback loops, or specific hex error codes such as `0x80070002` (file not found), `0x80070422` (service disabled), or `0x80240034` (Windows Update service busy).

## 4. Step-by-Step Procedure
1. **Check for Updates via GUI:** Open Settings > Windows Update > Click Check for updates.
2. **Review Update History:** Click Update history. Note successfully installed Knowledge Base (KB) articles and failed updates.
3. **Uninstall a Problematic Update:** In Update history, scroll to Related settings > Uninstall updates > Select the problematic KB article > Click Uninstall.
4. **Pause Updates:** Test pausing updates for 1 to 5 weeks during critical business or ship operations.
5. **Run Built-in Troubleshooter:** Settings > System > Troubleshoot > Other troubleshooters > Run `Windows Update` troubleshooter.
6. **Execute Manual Reset Procedure:** If updates remain stuck, stop Windows Update services, rename `SoftwareDistribution` and `catroot2` folders, and restart services.

## 5. Commands Used

### Command 1: Query Installed Hotfixes via PowerShell
```powershell
Get-HotFix | Sort-Object InstalledOn -Descending | Select-Object -First 10 HotFixID, Description, InstalledOn, InstalledBy
```
- **What it does:** Lists the 10 most recently installed Windows patches and hotfixes.
- **Why it is used:** Verifies whether a specific security remediation patch (KB number) has been applied.

### Command 2: Complete Windows Update Component Reset
```cmd
net stop wuauserv
net stop cryptSvc
net stop bits
net stop msiserver

ren C:\Windows\SoftwareDistribution SoftwareDistribution.old
ren C:\Windows\System32\catroot2 catroot2.old

net start wuauserv
net start cryptSvc
net start bits
net start msiserver
```
- **What it does:** 
  1. Stops the Windows Update service (`wuauserv`), Cryptographic service (`cryptSvc`), Background Intelligent Transfer Service (`bits`), and Windows Installer (`msiserver`).
  2. Renames the download cache folder (`SoftwareDistribution`) and catalog database (`catroot2`), forcing Windows to recreate clean repositories.
  3. Restarts the services to re-synchronize clean update catalogs from Microsoft.
- **Why it is used:** The universal enterprise remediation procedure for stubborn Windows Update failures.

## 6. Expected Result
The technician successfully resolves update download failures, clears corrupted update caches, verifies patch deployment status via PowerShell, and ensures system security compliance.

## 7. Troubleshooting
- **Issue: "Access is denied" when renaming `SoftwareDistribution`:**
  - *Cause:* One of the dependent background services did not stop completely and is holding a file lock.
  - *Solution:* Verify services are fully stopped using `tasklist` or reboot computer into Safe Mode before renaming.
- **Issue: Update fails with error `0x800F0922`:**
  - *Cause:* Insufficient free space on the System Reserved / EFI partition, or VPN blocking Microsoft Update servers.
  - *Solution:* Check free space on EFI partition; disconnect VPN; verify internet connectivity.

## 8. Screenshots / Evidence
- `screenshots/09-windows-update-settings.png` — *Pending lab execution: Capture Windows Update settings page.*
- `screenshots/09-hotfix-powershell.png` — *Pending lab execution: Capture Get-HotFix PowerShell output.*
- `screenshots/09-component-reset-cli.png` — *Pending lab execution: Capture Command Prompt executing the service reset.*

## 9. Practical Learning Outcome
Ability to manage enterprise patch lifecycles, uninstall problematic cumulative updates causing blue screens, and restore broken Windows Update components using command line automation.

## 10. Completion Status
Documented
