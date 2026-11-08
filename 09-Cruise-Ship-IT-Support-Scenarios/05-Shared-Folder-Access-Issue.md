# Scenario 05: Shared Folder "Access Denied" for Purser Desk Crew

## 1. Scenario Description
A newly embarked Assistant Purser reports they cannot open the financial voyage ledger shared folder (`\\SERVER01\Finance\VoyageReports`). Windows displays "Open Folder: \\SERVER01\Finance is not accessible. You might not have permission to use this network resource. Access is denied." Other purser staff have full access.

## 2. Possible Causes
1. User account was not added to the `Finance-Users` security group during onboarding.
2. User was recently added to the security group, but has not logged off (Kerberos token still reflects old group memberships).
3. NTFS folder permissions corrupted or lacking user's group.
4. Mapped drive credential cached with old local account credentials.

## 3. Initial Diagnosis
- Check user's Active Directory account properties on Domain Controller (`SERVER01`).
- Run `Get-ADUser -Identity "purser03" -Properties MemberOf`.
- **Finding:** The user is currently ONLY a member of `Domain Users`. The HR onboarding ticket specified financial access, but the group was never assigned.

## 4. Troubleshooting Procedure
1. **Assign Security Group:**
```powershell
Add-ADGroupMember -Identity "Finance-Users" -Members "purser03"
```
2. **Refresh Kerberos Ticket on Client:**
   - Option A: Have user log off and log back in.
   - Option B (Faster): In user's command prompt, execute:
```cmd
klist purge
```
3. **Map Network Drive:**
```cmd
net use Z: \\SERVER01\Finance /persistent:yes
```
4. **Live Verification:** User opens drive `Z:\VoyageReports`, creates a test file, and saves changes.

## 5. Commands and Tools Used
```powershell
Get-ADGroupMember -Identity "Finance-Users"
Add-ADGroupMember -Identity "Finance-Users" -Members "purser03"
klist purge
```

## 6. Resolution
Identified missing Active Directory security group membership; added user to `Finance-Users`; purged client Kerberos ticket cache; confirmed full read/modify access to shared folder.

## 7. When to Escalate
- If permissions changes require modifying sensitive company audit shares requiring Captain or Financial Director written sign-off.

## 8. Preventive Measures
Implement standardized role-based onboarding templates in Active Directory so new crew automatically receive group memberships matching their job role.

## 9. Sample Completed Incident Report
- **Incident ID:** INC-2024-0320
- **Priority:** P3 (Medium)
- **Time to Resolve:** 12 Minutes
- **Technician:** Anand D (IT Systems Assistant)

## 10. Completion Status
Documented
