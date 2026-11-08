# Scenario 01 — Crew Computer Login Issue

**Module:** 09 — Cruise Ship IT Support Scenarios  
**Difficulty:** Beginner  
**Status:** Documented  
**Department:** Housekeeping  
**Priority:** Medium (P3)

---

## 1. Scenario Description

A crew member in the Housekeeping department contacts IT support and reports that they are unable to log into their workstation. When they attempt to log in, they receive the following error message:

> *"The user name or password is incorrect."*

The crew member states they have been working without problems for several weeks and have not changed anything on their end. They are using the same username and password they always use.

**Key Facts:**
- Single user affected (not a widespread domain issue)
- Error appeared unexpectedly — no changes by the user
- Workstation appears to be powered on and showing the Windows login screen
- No other reports from Housekeeping at this time

---

## 2. Possible Causes

The following causes should be investigated in order of likelihood:

| # | Possible Cause | Likelihood |
|---|---|---|
| 1 | Account locked out due to too many failed login attempts | High |
| 2 | Caps Lock key is on (password is case-sensitive) | High |
| 3 | Wrong username format (not using `DOMAIN\username` or `username@domain.local`) | Medium |
| 4 | Password has expired and must be changed | Medium |
| 5 | Keyboard language has changed (special characters may type differently) | Medium |
| 6 | Account disabled by IT (administrative action) | Low |
| 7 | Time synchronisation issue between workstation and Domain Controller | Low |
| 8 | Domain Controller unreachable (network issue preventing authentication) | Low |

---

## 3. Initial Diagnosis

Before touching any system, ask the user the following questions to narrow down the cause:

- **"What error message do you see exactly?"** — Confirm it is "username or password incorrect" and not "domain unavailable" or "account disabled".
- **"Is Caps Lock on?"** — This is the most common and quickest fix.
- **"What username are you typing?"** — They may be typing only their first name instead of the correct format.
- **"Has your password been changed recently, or did you receive any notification about it expiring?"**
- **"Has anyone else used this computer recently?"**
- **"Are other computers in Housekeeping working normally?"** — Helps determine if this is account-specific or a broader issue.

**Quick visual check at the workstation:**
- Look at the keyboard — is Caps Lock illuminated?
- Check the bottom-left of the login screen — is the domain/workgroup name correct?
- Verify the network cable is connected and the link light on the PC or switch port is green.

---

## 4. Troubleshooting Procedure

### Step 1 — Check Caps Lock and Keyboard Language

Go to the workstation and visually check the Caps Lock key indicator light. Press **Caps Lock** to toggle it off if it is on. Ask the user to try again.

Also check the keyboard language (shown in the system tray at the bottom right of the screen if visible). If the keyboard is set to a different language, special characters in the password will produce different keystrokes.

```
Keyboard language can be verified at: Settings > Time & Language > Language & Region
```

> **Result:** If the user can now log in, document as "user error — Caps Lock". Advise user gently and close the ticket.

---

### Step 2 — Confirm Correct Username Format

Ensure the user is typing their username in the correct format for a domain-joined computer. The correct format depends on the domain configuration:

```
Correct formats:
  SHIP\crewuser01
  crewuser01@ship.local

Incorrect (will fail):
  crewuser01    (without domain prefix — might attempt local account)
  Crewuser01    (wrong capitalisation if domain is case-sensitive)
```

---

### Step 3 — Check the Account Status in Active Directory

From an IT admin workstation or server with Active Directory tools installed, open **PowerShell as Administrator** and run:

```powershell
# Check user account status — locked, enabled, password expired, bad logon count
Get-ADUser -Identity crewuser01 -Properties LockedOut, Enabled, PasswordExpired, BadLogonCount
```

**What to look for in the output:**

| Property | Concern |
|---|---|
| `LockedOut : True` | Account is locked — too many failed attempts |
| `Enabled : False` | Account has been disabled — requires authorised re-enabling |
| `PasswordExpired : True` | Password has expired — user must change it |
| `BadLogonCount : (high number)` | Suggests multiple failed attempts |

---

### Step 4 — Unlock the Account (If Locked)

If `LockedOut : True` was returned, unlock the account using:

```powershell
# Unlock the locked Active Directory account
Unlock-ADAccount -Identity crewuser01
```

After unlocking, go back to the workstation and ask the user to try logging in again with their existing password.

> **If the user has also forgotten their password**, proceed to Step 5 to reset it. Do not reset the password unless necessary — only unlocking may be sufficient.

---

### Step 5 — Reset the Password (If Required)

If the user has forgotten their password, or if the password has expired and they cannot remember it, reset it to a temporary password:

```powershell
# Reset the user's password to a known temporary value
Set-ADAccountPassword -Identity crewuser01 -Reset -NewPassword (ConvertTo-SecureString "TempPass@2024!" -AsPlainText -Force)

# Force the user to change password on next login
Set-ADUser -Identity crewuser01 -ChangePasswordAtLogon $true
```

> **Security Note:** Always use a temporary password that meets the domain complexity requirements (uppercase, lowercase, number, special character, minimum length). Communicate the temporary password to the user securely — not via unencrypted email or radio if avoidable. Tell the user to change it immediately on first login.

---

### Step 6 — Verify Domain Time Synchronisation

Active Directory Kerberos authentication requires that the workstation's clock be within **5 minutes** of the Domain Controller's clock. A larger time difference will cause authentication to fail even with the correct credentials.

**Check the workstation's time:**
```cmd
time /t
date /t
```

**Check synchronisation status:**
```cmd
w32tm /query /status
```

**Force synchronisation with the domain:**
```cmd
w32tm /resync /force
```

**Expected output after successful sync:**
```
The command completed successfully.
```

If the workstation clock is significantly different from the server, this indicates a deeper issue (CMOS battery failure, NTP configuration problem) that should be documented.

---

### Step 7 — Test Login

After performing the relevant fixes, ask the user to attempt login at the workstation with their credentials. Watch for:
- Successful login → proceed to verify everything works (shared drives, applications)
- Continuing error → proceed to escalation

---

## 5. Commands and Tools Used

| Command / Tool | Purpose |
|---|---|
| `Get-ADUser -Identity ... -Properties LockedOut, Enabled, PasswordExpired, BadLogonCount` | View account status in Active Directory |
| `Unlock-ADAccount -Identity ...` | Unlock a locked AD account |
| `Set-ADAccountPassword -Identity ... -Reset -NewPassword (...)` | Reset account password |
| `Set-ADUser -Identity ... -ChangePasswordAtLogon $true` | Force password change at next login |
| `w32tm /query /status` | Check time synchronisation status |
| `w32tm /resync /force` | Force time synchronisation with domain |
| `time /t`, `date /t` | View current workstation time |
| Active Directory Users and Computers (ADUC) GUI | Alternative GUI method for account management |

---

## 6. Resolution

**Most Common Resolution:** The account was locked out due to multiple failed login attempts (possibly caused by a remembered password being typed incorrectly after a previous password change). The account was unlocked using `Unlock-ADAccount` and the user was able to log in with their existing password.

**Secondary Resolution:** If Caps Lock was on, the user was advised and able to log in immediately.

**Password Reset Resolution:** If the password was expired or forgotten, a temporary password was set via `Set-ADAccountPassword`, the user was required to change it at first login via `Set-ADUser -ChangePasswordAtLogon $true`, and the user was informed of the new temporary password securely.

---

## 7. When to Escalate

Escalate to the IT Officer or senior IT staff if:

- The account is disabled (`Enabled : False`) — re-enabling requires authorisation and investigation into why it was disabled
- Multiple accounts are locked out simultaneously — this could indicate a brute-force attack or a misconfigured service account repeatedly authenticating with an old password
- The Domain Controller is unreachable — this affects the entire ship's domain authentication and is a P1 incident
- The workstation cannot join the domain or throws a "trust relationship failed" error
- The user's account has been compromised (suspected unauthorised access)
- Time synchronisation issues persist after a manual resync

---

## 8. Preventive Measures

- **User Education:** Train crew members to log out properly rather than leaving workstations idle, which can lead to screen-lock confusion and repeated incorrect attempts.
- **Account Lockout Policy:** Ensure the AD account lockout threshold is set appropriately (e.g., 5–10 attempts) — not so low that accidental lockouts are frequent.
- **Password Expiry Notifications:** Configure AD to notify users several days before their password expires so they can change it proactively.
- **NTP Configuration:** Ensure all workstations are configured to synchronise time with the Domain Controller to prevent Kerberos authentication failures.
- **CMOS Battery Monitoring:** Include CMOS battery checks in preventive maintenance schedules — a dead CMOS battery causes the clock to reset to a default date after power loss.
- **Screen Lock Awareness:** Educate users that pressing `Windows + L` locks the screen and requires the same domain password to unlock.

---

## 9. Sample Incident Report

```
╔══════════════════════════════════════════════════════════════════╗
║               IT SUPPORT INCIDENT REPORT                         ║
╠══════════════════════════════════════════════════════════════════╣
║ Ticket Number   : INC-2024-0001                                   ║
║ Date Opened     : 2024-11-08                                      ║
║ Time Opened     : 09:14                                           ║
║ Priority        : P3 — Medium                                     ║
╠══════════════════════════════════════════════════════════════════╣
║ REQUESTER INFORMATION                                             ║
╠══════════════════════════════════════════════════════════════════╣
║ Name            : Maria Santos                                    ║
║ Department      : Housekeeping                                    ║
║ Location        : Deck 4 — Housekeeping Office                    ║
║ Contact         : Internal extension 4201                         ║
╠══════════════════════════════════════════════════════════════════╣
║ INCIDENT DESCRIPTION                                              ║
╠══════════════════════════════════════════════════════════════════╣
║ User reported: "I cannot log into my computer. It says my        ║
║ username or password is incorrect but I haven't changed           ║
║ anything."                                                        ║
║                                                                   ║
║ Affected Asset  : ASSET-021 (Housekeeping Office PC)              ║
║ Username        : crewuser01 (SHIP\crewuser01)                    ║
║ Error Displayed : "The user name or password is incorrect"        ║
╠══════════════════════════════════════════════════════════════════╣
║ TROUBLESHOOTING STEPS TAKEN                                       ║
╠══════════════════════════════════════════════════════════════════╣
║ 09:14 — Called user, confirmed error message and username used    ║
║ 09:16 — Verified Caps Lock was OFF. Not the cause.                ║
║ 09:18 — Checked AD account via PowerShell:                        ║
║          Get-ADUser crewuser01 -Properties LockedOut,...          ║
║          Result: LockedOut = True, BadLogonCount = 7              ║
║ 09:19 — Unlocked account: Unlock-ADAccount -Identity crewuser01   ║
║ 09:20 — Advised user to try again                                 ║
║ 09:21 — User confirmed successful login                           ║
╠══════════════════════════════════════════════════════════════════╣
║ ROOT CAUSE                                                        ║
╠══════════════════════════════════════════════════════════════════╣
║ Account locked out after 7 failed login attempts. User had        ║
║ recently changed their password and was using the old password    ║
║ from muscle memory. Account lockout policy triggered at 5         ║
║ attempts.                                                         ║
╠══════════════════════════════════════════════════════════════════╣
║ RESOLUTION                                                        ║
╠══════════════════════════════════════════════════════════════════╣
║ Account unlocked via Unlock-ADAccount PowerShell command.         ║
║ User confirmed login successful. User was reminded to use the     ║
║ new password and advised about the lockout policy.                ║
╠══════════════════════════════════════════════════════════════════╣
║ Time Resolved   : 09:21                                           ║
║ Total Duration  : 7 minutes                                       ║
║ Technician      : Anand D                                         ║
║ Status          : RESOLVED                                        ║
╚══════════════════════════════════════════════════════════════════╝
```
