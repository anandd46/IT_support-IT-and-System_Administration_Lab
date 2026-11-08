# Practical Task: User Account Management and Provisioning

## 1. Objective
Provision, modify, disable, and manage enterprise user accounts in Active Directory using GUI tools and PowerShell scripts with standardized attribute conventions.

## 2. Requirements
- Domain Controller (`SERVER01.lab.local`)
- Domain Administrator access
- ADUC MMC (`dsa.msc`)

## 3. Background
User accounts represent human identities accessing network resources. Enterprise user accounts require:
- **First / Last Name:** Real personal identity.
- **User Logon Name (sAMAccountName):** Legacy pre-Windows 2000 login (e.g., `user01`).
- **User Principal Name (UPN):** Modern internet-style email identity (e.g., `user01@lab.local`).
- **Security Attributes:** Department, Job Title, Office, Telephone.
- **Account Controls:** Password must be changed at next logon, password expiration policy.

Sample Lab Users:
- `user01` — IT Support Technician (IT OU)
- `user02` — HR Specialist (HR OU)
- `user03` — Finance Analyst (Finance OU)
- `user04` — Operations Coordinator (Operations OU)

## 4. Step-by-Step Procedure
1. **GUI Provisioning:** Open ADUC > Expand `lab.local` > Right-click `HR` OU > New > User.
2. **Enter Credentials:**
   - First Name: `User`, Last Name: `02`, Logon: `user02`.
   - Set temporary password (`LabUser@2024!`).
   - Check "User must change password at next logon".
3. **Populate Metadata:** Right-click user > Properties > Set Job Title, Department, Email.
4. **Automated Provisioning via Script:** Execute `create-users.ps1` to bulk-provision remaining department users.
5. **Account Disabling / De-provisioning Workflow:** Test right-clicking a user > "Disable Account" when offboarding staff.

## 5. Commands Used

### Command 1: Create User via PowerShell
```powershell
New-ADUser `
    -Name "User01" `
    -GivenName "User" `
    -Surname "01" `
    -SamAccountName "user01" `
    -UserPrincipalName "user01@lab.local" `
    -Path "OU=IT,DC=lab,DC=local" `
    -Department "IT" `
    -Title "IT Support Technician" `
    -AccountPassword (ConvertTo-SecureString "LabUser@2024!" -AsPlainText -Force) `
    -Enabled $true `
    -ChangePasswordAtLogon $true
```
- **What it does:** Creates an enabled user account with all standard corporate attributes and enforces password change upon first login.

### Command 2: Query User Attributes
```powershell
Get-ADUser -Identity "user01" -Properties Department, Title, UserPrincipalName, PasswordLastSet | Select-Object Name, SamAccountName, Department, Title, Enabled
```

## 6. Expected Result
Departmental user accounts are provisioned in their designated OUs with complete metadata and forced password resets.

## 7. Troubleshooting
- **Issue: "The password does not meet the length, complexity, or history requirements":**
  - *Cause:* Default Domain Policy enforces minimum 7 characters with complexity (upper, lower, digit, special).
  - *Solution:* Ensure temporary password meets complexity criteria (e.g., `LabUser@2024!`).

## 8. Screenshots / Evidence
- `screenshots/04-aduc-new-user-wizard.png` — *Pending lab execution: Capture New User dialog.*
- `screenshots/04-user-properties-window.png` — *Pending lab execution: Capture User Properties Organization tab.*

## 9. Practical Learning Outcome
Ability to efficiently onboard and offboard personnel, enforce password policies, and maintain directory metadata.

## 10. Completion Status
Documented
