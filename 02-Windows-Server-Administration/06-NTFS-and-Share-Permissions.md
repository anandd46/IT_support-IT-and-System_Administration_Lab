# Practical Task: NTFS vs. Share Permissions and Access Control

## 1. Objective
Demonstrate the fundamental interplay between NTFS file system permissions and SMB share permissions, configure Access Control Lists (ACLs), and resolve "Access Denied" permission conflicts.

## 2. Requirements
- Windows Server 2022 (`SERVER01`) with NTFS volume
- Active Directory test users (`User01` in IT, `User02` in HR)
- Administrator credentials

## 3. Background
Securing Windows file servers requires mastering two independent permission layers:
1. **Share Permissions:** Applied when connecting across the network via SMB (`\\SERVER01\Share`). Options: Read, Change, Full Control.
2. **NTFS Permissions:** Applied locally and across the network. Enforced by the NTFS file system driver. Options: Read, Read & Execute, List Folder Contents, Write, Modify, Full Control.

**The Golden Rule of Windows File Security:**
> **The Most Restrictive Permission Wins!**
> If Share Permission = Full Control, but NTFS Permission = Read, the effective permission over the network is **Read**.
> Best practice: Set Share Permission to `Authenticated Users - Change` (or Full Control), and manage granular departmental security strictly through NTFS ACLs.

## 4. Step-by-Step Procedure
1. **Open Folder Security:** Navigate to `C:\Shares\HR` > Properties > Security tab > Click Advanced.
2. **Disable Inheritance:** Click `Disable inheritance` > Select `Convert inherited permissions into explicit permissions on this object`.
3. **Remove Inappropriate Groups:** Remove `Users` (Domain Users) from write permissions.
4. **Assign Departmental Permissions:**
   - Add `HR-Users` security group with **Modify** permission (allows creating, editing, and deleting documents, but prevents taking ownership or altering permissions).
   - Add `Domain Admins` with **Full Control**.
   - Ensure permissions apply to: "This folder, subfolders and files".
5. **Verify Effective Access:** In Advanced Security Settings, click the `Effective Access` tab > Select `User02` (HR) > View permissions (Confirm Modify granted). Test `User01` (IT) > Confirm access denied.
6. **Live Verification:** Log in as User01 on CLIENT01 and attempt to create a file in `\\SERVER01\HR`. Verify error dialog.

## 5. Commands Used

### Command 1: Inspect Folder ACL via PowerShell
```powershell
Get-Acl "C:\Shares\HR" | Select-Object -ExpandProperty Access | Select-Object IdentityReference, FileSystemRights, AccessControlType
```
- **What it does:** Displays every Access Control Entry (ACE) within the folder's Discretionary Access Control List (DACL).

### Command 2: Apply NTFS Permissions via ICACLS
```cmd
icacls "C:\Shares\HR" /inheritance:d
icacls "C:\Shares\HR" /grant:r "lab\HR-Users":(OI)(CI)M
icacls "C:\Shares\HR" /remove "BUILTIN\Users"
```
- **What it does:** Disables inheritance (`/inheritance:d`), grants `Modify` rights to `HR-Users` with Object Inherit (`OI`) and Container Inherit (`CI`), and strips general Users access.

## 6. Expected Result
Only authorized members of `HR-Users` can read and modify files in the HR repository. All other users receive an immediate "Access Denied" notice.

## 7. Troubleshooting
- **Issue: User can open files over the network but cannot edit/save changes:**
  - *Cause:* User has NTFS Read & Execute, or Share permission is set to Read only.
  - *Solution:* Inspect both layers; elevate NTFS permission to Modify, and ensure Share permission is at least Change.

## 8. Screenshots / Evidence
- `screenshots/06-ntfs-advanced-security.png` — *Pending lab execution: Capture Advanced Security Settings dialog showing explicit ACLs.*
- `screenshots/06-effective-access-check.png` — *Pending lab execution: Capture Effective Access tab output.*

## 9. Practical Learning Outcome
Deep understanding of the Windows security model, differentiating share and NTFS permissions, and deploying zero-trust departmental file storage.

## 10. Completion Status
Documented
