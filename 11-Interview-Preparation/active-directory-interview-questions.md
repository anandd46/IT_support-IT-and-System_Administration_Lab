# Technical Interview Preparation: Active Directory Domain Services

### Q1: What is Active Directory Domain Services (AD DS) and why do enterprises use it?
**A:** AD DS is Microsoft's distributed directory service and identity management infrastructure. It provides centralized authentication, authorization, and accounting (AAA) across an entire organization. Instead of managing local user accounts independently on hundreds of individual computers, AD DS stores all identities, security groups, computer accounts, and security policies in a centralized, replicated database (`ntds.dit`). This allows users to log into any authorized workstation on the domain with a single set of credentials and ensures standardized security enforcement.

### Q2: What is the difference between an Organizational Unit (OU) and a Security Group?
**A:** This is a classic interview question:
- **Organizational Units (OUs):** Logical containers used to organize directory objects (users, computers, groups) strictly for administrative delegation and applying Group Policy Objects (GPOs). **You cannot grant permissions to a file share using an OU!**
- **Security Groups:** Security principals with a unique Security Identifier (SID). They are used to grant access permissions to resources like shared folders, printers, and SharePoint sites, or to assign user rights.

### Q3: Explain the AGDLP best practice for assigning permissions in Active Directory.
**A:** AGDLP is Microsoft's role-based access control standard:
- **A**ccounts (User identities) are placed into...
- **G**lobal Groups (Representing business roles, e.g., `HR-Specialists`), which are placed into...
- **D**omain **L**ocal Groups (Representing specific resource permissions, e.g., `DL-HRShare-Modify`), which are granted...
- **P**ermissions on the target file share or NTFS resource.
This decouples user identity management from file permission management, ensuring permissions never need to be altered when personnel join or leave departments.

### Q4: How do you unlock a locked user account and reset their password using PowerShell?
**A:**
```powershell
Unlock-ADAccount -Identity "user01"
Set-ADAccountPassword -Identity "user01" -NewPassword (ConvertTo-SecureString "TempPass#2024" -AsPlainText -Force) -Reset
Set-ADUser -Identity "user01" -ChangePasswordAtLogon $true
```

### Q5: What is Group Policy and what is the difference between Computer Configuration and User Configuration?
**A:** Group Policy is an administration framework that pushes centralized operating system and software configurations to domain-joined endpoints. In a Group Policy Object (GPO):
- **Computer Configuration:** Applies when the operating system boots up before any user logs in. Controls machine-level settings such as Windows Defender policies, network security, firewall rules, and startup scripts.
- **User Configuration:** Applies when an individual user logs into a machine. Controls user-level desktop environments, wallpaper, mapped network drives, desktop shortcuts, and application preferences.

### Q6: A user reports that a newly linked Group Policy is not applying to their workstation. How would you troubleshoot this?
**A:**
1. Run `gpupdate /force` on the client to trigger immediate policy synchronization.
2. Run `gpresult /r` (or `gpresult /h report.html`) to inspect applied GPOs and check the "Denied GPOs" section.
3. Verify that the client computer or user account physically resides inside the OU to which the GPO is linked.
4. Verify Security Filtering in the Group Policy Management Console to confirm that the user or `Authenticated Users` has "Read" and "Apply Group Policy" permissions.
5. Check whether a higher-level GPO has "Block Inheritance" enabled or if a competing GPO has "Enforced" status.

### Q7: Why must client workstation clocks match the Domain Controller clock within 5 minutes?
**A:** Active Directory uses the Kerberos v5 authentication protocol. Kerberos generates cryptographic tickets stamped with the client's local system time to prevent replay attacks (where an attacker intercepts an encrypted ticket and retransmits it later to impersonate a user). If the client clock drifts more than the maximum tolerance (default: 300 seconds / 5 minutes) from the Domain Controller's clock, the DC rejects the Kerberos ticket with error `KRB_AP_ERR_SKEW`, preventing the user from logging in.

### Q8: What does the command `dcdiag` do?
**A:** `dcdiag` (Domain Controller Diagnostic) is Microsoft's primary command-line tool for analyzing the overall health of a domain controller. It executes automated test suites evaluating DNS registration, inter-site replication, SYSVOL advertising, trust relationships, machine accounts, and critical services, outputting passed or failed test summaries.

### Q9: What happens when you run `klist purge` on a Windows workstation?
**A:** `klist purge` flushes all cached Kerberos Ticket-Granting Tickets (TGTs) and service tickets stored in the user's active session memory. This forces the workstation to immediately contact the Domain Controller and request a fresh Kerberos token containing updated security group memberships without requiring the user to log off or reboot.

### Q10: How do you join a Windows 11 client to an Active Directory domain via PowerShell?
**A:**
```powershell
Add-Computer -DomainName "lab.local" -Credential (Get-Credential) -Restart
```
*Prerequisite: The client's network adapter must have its Primary DNS server configured to point to the Domain Controller's IP address (`192.168.100.10`).*
