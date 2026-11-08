# Practical Task: Active Directory Domain Services (AD DS) Role Installation

## 1. Objective
Install the Active Directory Domain Services (AD DS) role and administrative Remote Server Administration Tools (RSAT) on Windows Server 2022 using Server Manager and PowerShell.

## 2. Requirements
- Windows Server 2022 (`SERVER01`) with persistent static IP (`192.168.100.10`)
- Local Administrator credentials
- System drive with at least 10 GB free space for database/sysvol

## 3. Background
Active Directory Domain Services (AD DS) is the central identity store, directory service, and authentication authority for enterprise Windows networks. Installing the AD DS role prepares the binary libraries, schema tools, and management consoles required before promoting the server to an active Domain Controller (DC).

## 4. Step-by-Step Procedure
1. **Server Manager:** Open Server Manager > Click Manage > Add Roles and Features.
2. **Installation Type:** Choose Role-based or feature-based installation.
3. **Server Selection:** Select `SERVER01`.
4. **Server Roles:** Check `Active Directory Domain Services`. Click "Add Features" to include RSAT management tools.
5. **Confirmation:** Review selected components and click Install.
6. **Verify Installation:** Verify successful installation in the Notification flag.

## 5. Commands Used

### Command 1: Install AD DS via PowerShell
```powershell
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools
```
- **What it does:** Installs the AD DS role binaries, Active Directory Administrative Center, ADUC MMC snap-ins, and the `ActiveDirectory` PowerShell module.
- **Why it is used:** Fast, automated deployment without navigating wizard screens.

### Command 2: Query Feature Status
```powershell
Get-WindowsFeature -Name *AD-Domain*
```
- **What it does:** Validates that `Install State` displays as `Installed`.

## 6. Expected Result
The AD DS role is installed. Server Manager displays a post-deployment configuration notification prompting promotion to a domain controller.

## 7. Troubleshooting
- **Issue: Installation fails with "The system cannot find the path specified":**
  - *Cause:* Corrupted Windows Component Store (WinSxS).
  - *Solution:* Run `dism /online /cleanup-image /restorehealth` and retry installation.

## 8. Screenshots / Evidence
- `screenshots/01-ad-ds-install-wizard.png` — *Pending lab execution: Capture Add Roles wizard with AD DS selected.*
- `screenshots/01-powershell-install-success.png` — *Pending lab execution: Capture PowerShell Install-WindowsFeature success.*

## 9. Practical Learning Outcome
Ability to install enterprise directory services infrastructure and RSAT tooling.

## 10. Completion Status
Documented
