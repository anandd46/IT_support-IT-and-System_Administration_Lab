# Practical Task: File and Folder Sharing Across Departments

## 1. Objective
Create, configure, and secure departmental network file shares (IT, HR, Finance, Operations) on Windows Server 2022 for client access.

## 2. Requirements
- Windows Server 2022 (`SERVER01`) with File Server role
- Client machine (`CLIENT01`)
- Administrative privileges

## 3. Background
Departmental file sharing is the backbone of business operations. In an enterprise or shipboard environment, departments require isolated network repositories accessible via Universal Naming Convention (UNC) paths (e.g., `\\SERVER01\IT`). Access must be restricted so that unauthorized personnel cannot view confidential data.

Lab Departmental Shares:
- `C:\Shares\IT` -> Shared as `IT$` or `IT`
- `C:\Shares\HR` -> Shared as `HR`
- `C:\Shares\Finance` -> Shared as `Finance`
- `C:\Shares\Operations` -> Shared as `Operations`

## 4. Step-by-Step Procedure
1. **Create Base Directory:** In volume C:, create folder `C:\Shares` and subfolders for each department.
2. **Configure SMB Share via GUI:** Right-click `C:\Shares\HR` > Properties > Sharing tab > Advanced Sharing > Check "Share this folder" > Share name: `HR`.
3. **Set Share Permissions:** Click Permissions > Remove `Everyone` > Add `Authenticated Users` with Read, and `HR-Users` / `Domain Admins` with Change/Full Control.
4. **Create Shares via PowerShell:** Use `New-SmbShare` to script creation of IT, Finance, and Operations shares.
5. **Test Access from Client:** From `CLIENT01`, press Win + R and enter `\\SERVER01\HR`.
6. **Map Network Drive:** Map drive letter `Z:` to `\\SERVER01\HR`.

## 5. Commands Used

### Command 1: Scripted SMB Share Creation
```powershell
New-Item -ItemType Directory -Path "C:\Shares\IT", "C:\Shares\HR", "C:\Shares\Finance", "C:\Shares\Operations" -Force

New-SmbShare -Name "IT" -Path "C:\Shares\IT" -FullAccess "Administrators" -Description "IT Department Share"
New-SmbShare -Name "HR" -Path "C:\Shares\HR" -FullAccess "Administrators" -ReadAccess "Everyone" -Description "HR Department Share"
New-SmbShare -Name "Finance" -Path "C:\Shares\Finance" -FullAccess "Administrators" -Description "Finance Share"
New-SmbShare -Name "Operations" -Path "C:\Shares\Operations" -FullAccess "Administrators" -Description "Operations Share"
```
- **What it does:** Creates folder paths and provisions SMB network shares with designated access lists.

### Command 2: Enumerate Active SMB Shares
```powershell
Get-SmbShare | Select-Object Name, Path, Description
```
- **What it does:** Lists all shares on the server including default administrative shares (`C$`, `ADMIN$`, `IPC$`).

### Command 3: Map Network Drive from Client (CMD)
```cmd
net use Z: \\SERVER01\HR /persistent:yes
```
- **What it does:** Maps share `\\SERVER01\HR` to drive letter `Z:`, persisting across user reboots.

## 6. Expected Result
Network shares are created, verified with `Get-SmbShare`, and successfully mapped as network drives on client workstations.

## 7. Troubleshooting
- **Issue: Client receives "Network path not found" (Error 0x80070035):**
  - *Cause:* File and Printer Sharing blocked on server firewall, or DNS unable to resolve `SERVER01`.
  - *Solution:* Verify server firewall rule: `Enable-NetFirewallRule -DisplayGroup "File and Printer Sharing"`; test accessing via IP `\\192.168.100.10\HR`.

## 8. Screenshots / Evidence
- `screenshots/05-smb-share-properties.png` — *Pending lab execution: Capture SMB share properties dialog.*
- `screenshots/05-client-mapped-drive.png` — *Pending lab execution: Capture mapped Z: drive in File Explorer.*

## 9. Practical Learning Outcome
Ability to configure enterprise SMB network storage, enforce share-level security, and provision mapped drives.

## 10. Completion Status
Documented
