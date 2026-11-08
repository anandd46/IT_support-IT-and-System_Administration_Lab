# Module 03 — Active Directory Domain Services (AD DS)

This module details the complete configuration, administration, security management, and troubleshooting of Active Directory Domain Services on Windows Server 2022.

## Lab Environment

| Component | Setting |
|---|---|
| Active Directory Domain | `lab.local` |
| NetBIOS Domain Name | `LAB` |
| Primary Domain Controller | `SERVER01` (`192.168.100.10`) |
| Domain Functional Level | Windows Server 2016 |
| Forest Functional Level | Windows Server 2016 |
| Integrated DNS Server | `SERVER01` (`127.0.0.1`) |
| Client Workstation | `CLIENT01` (`192.168.100.20`) |

## Module Contents

| File | Topic |
|---|---|
| [01-AD-DS-Installation.md](01-AD-DS-Installation.md) | Installing AD DS Role on Windows Server 2022 |
| [02-Domain-Controller-Configuration.md](02-Domain-Controller-Configuration.md) | Promoting Server to Domain Controller (`lab.local`) |
| [03-Organizational-Units.md](03-Organizational-Units.md) | Designing and creating Departmental OU Hierarchy |
| [04-User-Account-Management.md](04-User-Account-Management.md) | User provisioning, UPNs, and attributes |
| [05-Security-Group-Management.md](05-Security-Group-Management.md) | Role-Based Access Control and Global Security Groups |
| [06-Password-Reset-and-Account-Unlock.md](06-Password-Reset-and-Account-Unlock.md) | Account unlocking, password resets, lockout analysis |
| [07-Group-Policy-Management.md](07-Group-Policy-Management.md) | GPO creation, linking, and troubleshooting (`gpupdate`) |
| [08-Join-Windows-Client-to-Domain.md](08-Join-Windows-Client-to-Domain.md) | Joining Windows 11 client to `lab.local` |
| [09-Active-Directory-Troubleshooting.md](09-Active-Directory-Troubleshooting.md) | Resolving replication, trust, DNS, and Kerberos faults |

## Automation Scripts

| Script | Purpose |
|---|---|
| [create-users.ps1](scripts/create-users.ps1) | Automated provisioning of department users |
| [create-groups.ps1](scripts/create-groups.ps1) | Automated provisioning of global security groups |
| [get-ad-users.ps1](scripts/get-ad-users.ps1) | Audit user status (locked, disabled, expired) |

## Module Status
- [x] Documentation created
- [ ] AD DS Role installed on SERVER01
- [ ] Domain Controller promoted
- [ ] Client joined to domain
- [ ] Scripts verified
- [ ] Screenshots captured
