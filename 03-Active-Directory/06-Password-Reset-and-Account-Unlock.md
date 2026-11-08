# Practical Task: Password Reset and Account Unlock Procedures

## 1. Objective
Perform the two highest-volume IT helpdesk operations: resetting expired/forgotten user passwords and unlocking locked Active Directory accounts.

## 2. Requirements
- Domain Controller (`SERVER01.lab.local`) or client with RSAT tools
- Helpdesk / Administrator credentials
- ADUC MMC or PowerShell

## 3. Background
Account lockouts protect the network from automated brute-force password guessing. After a predetermined number of consecutive bad password attempts (e.g., 5 attempts in 30 minutes), the domain controller sets the user account's `LockedOut` attribute to `True`.

Helpdesk technicians must:
1. Verify user identity.
2. Determine if the account is merely locked or if the password has expired.
3. Reset password and unlock account.
4. Investigate root cause (stale credentials stored in mobile device, Outlook, or mapped drive).

## 4. Step-by-Step Procedure
1. **Account Unlock via GUI:**
   - In ADUC, open the user's properties.
   - Click the Account tab.
   - Check the box "Unlock account. This account is currently locked out on this Active Directory Domain Controller" > Click Apply.
2. **Password Reset via GUI:**
   - Right-click user > Reset Password.
   - Enter temporary password (e.g., `TempReset#2024`).
   - Check "User must change password at next logon" > Click OK.
3. **PowerShell Investigation:** Use PowerShell to check lockout status, bad password count, and last bad logon timestamp.
4. **PowerShell Unlock & Reset:** Execute `Unlock-ADAccount` and `Set-ADAccountPassword`.

## 5. Commands Used

### Command 1: Inspect Account Lockout Telemetry
```powershell
Get-ADUser -Identity "user02" -Properties LockedOut, BadLogonCount, BadPasswordTime, PasswordLastSet | Select-Object Name, LockedOut, BadLogonCount, BadPasswordTime, PasswordLastSet
```
- **What it does:** Displays whether the user is locked, how many failed attempts occurred, and when the last failure was recorded.

### Command 2: Unlock Account via PowerShell
```powershell
Unlock-ADAccount -Identity "user02"
```
- **What it does:** Clears the locked lockout flag on the Domain Controller immediately.

### Command 3: Administrative Password Reset
```powershell
Set-ADAccountPassword -Identity "user02" -NewPassword (ConvertTo-SecureString "TempReset#2024" -AsPlainText -Force) -Reset
Set-ADUser -Identity "user02" -ChangePasswordAtLogon $true
```
- **What it does:** Resets the password and mandates a new password choice upon the user's next login.

### Command 4: Scan Entire Domain for All Locked Accounts
```powershell
Search-ADAccount -LockedOut | Select-Object Name, SamAccountName, LastLogonDate
```
- **What it does:** Audits the entire domain and lists all currently locked users.

## 6. Expected Result
Locked user accounts are unlocked, temporary passwords are provided, and users successfully log on and establish their own private passwords.

## 7. Troubleshooting
- **Issue: Account locks out again immediately after being unlocked:**
  - *Cause:* User has a secondary device (smartphone with Wi-Fi, tablet with Outlook, or cached network drive credential) repeatedly attempting authentication with old password.
  - *Solution:* Inspect Security Event Log (Event ID 4740 - A user account was locked out) to identify the caller computer name/IP generating bad attempts.

## 8. Screenshots / Evidence
- `screenshots/06-aduc-unlock-checkbox.png` — *Pending lab execution: Capture Account tab unlock checkbox.*
- `screenshots/06-powershell-lockout-audit.png` — *Pending lab execution: Capture Search-ADAccount output.*

## 9. Practical Learning Outcome
Ability to rapidly resolve logon incidents, safely reset credentials, audit domain lockouts, and trace recurring authentication failures.

## 10. Completion Status
Documented
