# Practical Task: Organizational Unit (OU) Architecture and Design

## 1. Objective
Design and implement a structured Organizational Unit (OU) hierarchy in Active Directory for departmental separation (IT, HR, Finance, Operations, Computers) with accidental deletion protection.

## 2. Requirements
- Authoritative Domain Controller (`SERVER01.lab.local`)
- Domain Admin credentials
- Active Directory Users and Computers (`dsa.msc`)

## 3. Background
Organizational Units (OUs) are logical containers within an Active Directory domain used to organize objects (users, groups, computers) for administrative delegation and Group Policy application.

**OUs vs. Groups:**
- **OUs:** Used to link Group Policy Objects (GPOs) and delegate administrative rights. OUs cannot be granted permissions to file shares!
- **Groups:** Used to assign security permissions to resources (file shares, printers).

Designed OU Structure for `lab.local`:
```text
lab.local
├── IT
├── HR
├── Finance
├── Operations
└── Workstations
```

## 4. Step-by-Step Procedure
1. **Open ADUC:** Press Win + R, type `dsa.msc`, and press Enter.
2. **Create Departmental OUs:**
   - Right-click domain `lab.local` > New > Organizational Unit.
   - Name: `IT`. Ensure "Protect container from accidental deletion" is checked.
   - Repeat for `HR`, `Finance`, `Operations`, and `Workstations`.
3. **PowerShell Scripting:** Deploy OUs programmatically using `New-ADOrganizationalUnit`.
4. **Verify Accidental Deletion Protection:** Attempt to delete an OU in ADUC; observe refusal dialog.
5. **Delegation of Control (Concept):** Right-click `IT` OU > Delegate Control > Assign junior technician permission to reset passwords.

## 5. Commands Used

### Command 1: Scripted OU Provisioning
```powershell
$OUs = @("IT", "HR", "Finance", "Operations", "Workstations")
foreach ($ou in $OUs) {
    New-ADOrganizationalUnit -Name $ou -Path "DC=lab,DC=local" -ProtectedFromAccidentalDeletion $true -Description "$ou Departmental Container"
}
```
- **What it does:** Creates all 5 top-level OUs in the `lab.local` domain root with accidental deletion protection enabled.

### Command 2: Query All Domain OUs
```powershell
Get-ADOrganizationalUnit -Filter * | Select-Object Name, DistinguishedName
```
- **What it does:** Displays the Distinguished Names (DNs) of all OUs in the domain.

## 6. Expected Result
The domain structure displays clean, standardized departmental OUs ready for user provisioning and GPO linking.

## 7. Troubleshooting
- **Issue: Cannot delete a temporary test OU ("Access is denied"):**
  - *Cause:* "Protect container from accidental deletion" is active.
  - *Solution:* In ADUC, click View > Advanced Features > Right-click OU > Properties > Object tab > Uncheck "Protect object from accidental deletion", then delete.

## 8. Screenshots / Evidence
- `screenshots/03-aduc-ou-tree.png` — *Pending lab execution: Capture ADUC console displaying all created OUs.*
- `screenshots/03-powershell-ou-list.png` — *Pending lab execution: Capture Get-ADOrganizationalUnit output.*

## 9. Practical Learning Outcome
Mastery in enterprise directory architecture, container delegation, and safeguarding directory objects.

## 10. Completion Status
Documented
