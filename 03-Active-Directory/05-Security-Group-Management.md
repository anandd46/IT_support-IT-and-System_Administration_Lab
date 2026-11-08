# Practical Task: Security Group Architecture and RBAC Administration

## 1. Objective
Implement Role-Based Access Control (RBAC) using Active Directory Global Security Groups and assign users to functional access groups.

## 2. Requirements
- Domain Controller (`SERVER01.lab.local`)
- Domain Admin credentials
- ADUC MMC

## 3. Background
In enterprise administration, permissions to files, folders, and network services should **NEVER** be assigned directly to individual user accounts. Instead, organizations use the **AGDLP** best practice:
- **A**ccounts are placed into...
- **G**lobal Security Groups (representing job roles, e.g., `HR-Users`), which are placed into...
- **D**omain **L**ocal Groups (representing resource permissions, e.g., `DL-HRShare-Modify`), which are granted...
- **P**ermissions on the target resource.

Core Security Groups for Lab:
- `IT-Admins` (Members: `user01`, `Administrator`)
- `HR-Users` (Members: `user02`)
- `Finance-Users` (Members: `user03`)
- `Operations-Users` (Members: `user04`)
- `All-Staff` (Members: All users)

## 4. Step-by-Step Procedure
1. **Create Security Groups:** In ADUC, navigate to each departmental OU > New > Group.
   - Group Type: Security.
   - Group Scope: Global.
2. **Add Members via GUI:** Open group properties > Members tab > Click Add > Enter `user01` > Check Names > Click OK.
3. **Automate via PowerShell:** Run `create-groups.ps1` to build groups and assign membership.
4. **Audit Group Membership:** Query group members using `Get-ADGroupMember`.

## 5. Commands Used

### Command 1: Create Global Security Group
```powershell
New-ADGroup -Name "HR-Users" -GroupScope Global -GroupCategory Security -Path "OU=HR,DC=lab,DC=local" -Description "HR Department Personnel"
```

### Command 2: Add User to Group
```powershell
Add-ADGroupMember -Identity "HR-Users" -Members "user02"
```

### Command 3: Query Group Members
```powershell
Get-ADGroupMember -Identity "HR-Users" | Select-Object Name, SamAccountName, ObjectClass
```

## 6. Expected Result
Global security groups are created within their respective OUs, populated with departmental users, and ready to secure file shares.

## 7. Troubleshooting
- **Issue: User added to a group still receives "Access Denied" on a shared folder:**
  - *Cause:* Kerberos access token is generated only at logon time. Group membership changes do not take effect immediately on active sessions!
  - *Solution:* Have user log off and log back in, or execute `klist purge` to refresh Kerberos tickets.

## 8. Screenshots / Evidence
- `screenshots/05-aduc-group-membership.png` — *Pending lab execution: Capture Group Properties Members list.*
- `screenshots/05-powershell-group-members.png` — *Pending lab execution: Capture Get-ADGroupMember output.*

## 9. Practical Learning Outcome
Mastery in enterprise Role-Based Access Control (RBAC), implementing AGDLP, and administering security groups.

## 10. Completion Status
Documented
