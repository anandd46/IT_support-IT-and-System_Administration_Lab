# Practical Task: Domain Controller Promotion and Forest Creation (`lab.local`)

## 1. Objective
Promote Windows Server 2022 to the primary Domain Controller for a new Active Directory forest named `lab.local`, configure Active Directory-integrated DNS, and establish SYSVOL.

## 2. Requirements
- Windows Server 2022 (`SERVER01`) with AD DS role installed
- Strong Directory Services Restore Mode (DSRM) administrator password
- Administrator privileges

## 3. Background
Promoting a server to a Domain Controller runs `dcpromo` logic to:
1. Create the new forest root domain database (`ntds.dit`) in `%SystemRoot%\NTDS`.
2. Generate the Kerberos Key Distribution Center (KDC).
3. Establish the `SYSVOL` folder structure (`%SystemRoot%\SYSVOL`) for Group Policy script replication.
4. Install and configure an Active Directory-Integrated DNS Server zone.

## 4. Step-by-Step Procedure
1. **Launch Promotion Wizard:** In Server Manager, click the yellow warning flag > Select "Promote this server to a domain controller".
2. **Deployment Configuration:** Select "Add a new forest" > Root domain name: `lab.local`.
3. **Domain Controller Options:**
   - Forest & Domain Functional Level: Windows Server 2016.
   - Domain Name System (DNS) server: Checked.
   - Global Catalog (GC): Checked.
   - Enter and confirm strong DSRM Password.
4. **DNS Options:** Acknowledge delegation warning (normal for isolated root zone).
5. **Additional Options:** Confirm NetBIOS name: `LAB`.
6. **Paths:** Accept defaults for Database (`C:\Windows\NTDS`), Log files, and SYSVOL (`C:\Windows\SYSVOL`).
7. **Prerequisites Check & Install:** Click Install. The server will automatically reboot upon completion.
8. **Verify Domain Controller:** Log in as `LAB\Administrator` and verify domain state.

## 5. Commands Used

### Command 1: Scripted Forest Deployment
```powershell
Install-ADDSForest `
    -DomainName "lab.local" `
    -DomainNetBIOSName "LAB" `
    -InstallDns $true `
    -NoRebootOnCompletion $false `
    -Force $true
```
- **What it does:** Creates the `lab.local` forest and domain, installs integrated DNS, provisions SYSVOL, and initiates reboot.

### Command 2: Query Domain Controller Status
```powershell
Get-ADDomainController -Identity "SERVER01" | Select-Object Name, Domain, Forest, IPv4Address, IsGlobalCatalog, OperatingSystem
```
- **What it does:** Validates that `SERVER01` is operating as an authoritative Global Catalog DC.

## 6. Expected Result
The server restarts as the primary Domain Controller for `lab.local`. Technicians can log in using domain credentials (`LAB\Administrator`).

## 7. Troubleshooting
- **Issue: Prerequisite check fails with "Static IP not detected":**
  - *Cause:* Network adapter is still configured for DHCP.
  - *Solution:* Revisit Module 02 and configure static IP `192.168.100.10/24`.

## 8. Screenshots / Evidence
- `screenshots/02-forest-promotion-wizard.png` — *Pending lab execution: Capture Add New Forest wizard screen.*
- `screenshots/02-domain-controller-verify.png` — *Pending lab execution: Capture Get-ADDomainController PowerShell output.*

## 9. Practical Learning Outcome
Ability to deploy enterprise forest roots, configure integrated DNS, and commission primary domain controllers.

## 10. Completion Status
Documented
