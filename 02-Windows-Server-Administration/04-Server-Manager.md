# Practical Task: Server Manager Overview and Role Deployment

## 1. Objective
Navigate Windows Server 2022 Server Manager, monitor server health indicators, perform Best Practices Analyzer (BPA) scans, and deploy core server roles.

## 2. Requirements
- Windows Server 2022 (`SERVER01`)
- Administrative access
- Server Manager MMC

## 3. Background
Server Manager is the centralized administration console for Windows Server. It allows systems administrators to manage local and remote servers, monitor role health, review events across the server fleet, and install or remove server roles and features without physical console access.

## 4. Step-by-Step Procedure
1. **Launch Server Manager:** Default startup or run `ServerManager.exe`.
2. **Dashboard Review:** Inspect Quick Start tiles (Configure local server, Add roles and features, Add other servers).
3. **Local Server Tile:** Review server properties, Windows Defender status, Windows Update status, and event aggregation.
4. **All Servers Tile:** Review consolidated event logs and service status across managed machines.
5. **Add Roles and Features Wizard:**
   - Select Role-based or feature-based installation.
   - Choose `SERVER01` from the server pool.
   - Expand File and Storage Services > File and iSCSI Services.
   - Confirm installation of `File Server`.
6. **Best Practices Analyzer:** Navigate to an installed role and click Tasks > Start BPA Scan.

## 5. Commands Used

### Command 1: Launch Server Manager
```cmd
ServerManager.exe
```

### Command 2: Query Available Roles via PowerShell
```powershell
Get-WindowsFeature | Where-Object InstallState -eq "Installed" | Select-Object Name, DisplayName
```
- **What it does:** Lists all server roles and features currently installed on the server.
- **Why it is used:** Fast auditing during compliance or migration checks.

### Command 3: Install Role via PowerShell
```powershell
Install-WindowsFeature -Name FS-FileServer -IncludeManagementTools
```
- **What it does:** Installs the File Server role and corresponding management tools silently.

## 6. Expected Result
The administrator successfully assesses server health, queries installed roles, and deploys new services using Server Manager and PowerShell.

## 7. Troubleshooting
- **Issue: Server Manager displays red flags in Services pane:**
  - *Cause:* Automatic services (e.g., Downloaded Maps Manager) failed to start.
  - *Solution:* Right-click service > Start Service, or adjust startup type to Automatic (Delayed Start).

## 8. Screenshots / Evidence
- `screenshots/04-server-manager-dashboard.png` — *Pending lab execution: Capture Server Manager Dashboard.*
- `screenshots/04-roles-features-wizard.png` — *Pending lab execution: Capture Add Roles and Features Wizard.*

## 9. Practical Learning Outcome
Mastery in enterprise server management, role deployment workflows, and fleet health monitoring.

## 10. Completion Status
Documented
