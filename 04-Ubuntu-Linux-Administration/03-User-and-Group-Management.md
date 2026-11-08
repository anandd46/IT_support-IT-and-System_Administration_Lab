# Practical Task: Linux User and Group Management

## 1. Objective
Demonstrate Linux user account creation, administrative `sudo` privilege assignment, secondary group creation, password expiration enforcement, and account deactivation in Ubuntu 22.04 LTS.

## 2. Requirements
- Ubuntu 22.04 LTS VM (`UBUNTU01`)
- Sudo administrative access
- Bash shell

## 3. Background
Linux enforces multi-user security through POSIX user accounts and groups. Identity metadata resides in core system files:
- `/etc/passwd`: User account names, User IDs (UID), primary Group IDs (GID), home directories, and default login shells.
- `/etc/shadow`: Cryptographically hashed passwords (SHA-512), account expiration dates, and password aging constraints.
- `/etc/group`: Group names, GIDs, and comma-separated secondary group member lists.

## 4. Step-by-Step Procedure
1. **Create User Account:** Use `adduser` to interactively create a new standard user `supporttech`.
2. **Assign Administrative Sudo Rights:** Add `supporttech` to the secondary `sudo` group.
3. **Create Departmental Group:** Create group `itops` using `groupadd`.
4. **Assign Secondary Group Membership:** Add user to `itops` using `usermod -aG`.
5. **Verify Identity:** Switch to the user account and verify active group memberships using `id` and `groups`.
6. **Account Lockout / Deactivation:** Demonstrate locking and unlocking a compromised or departed employee account using `passwd -l` and `passwd -u`.

## 5. Commands Used

### Command 1: Create New User with Home Directory
```bash
sudo adduser supporttech
```
- **What it does:** High-level Perl wrapper around `useradd`. Creates user home directory `/home/supporttech`, copies skeleton configuration from `/etc/skel`, and prompts for initial password.

### Command 2: Grant Sudo Privileges
```bash
sudo usermod -aG sudo supporttech
```
- **What it does:** Appends (`-a`) the secondary group (`-G`) `sudo` to the user account.
- **Why it is used:** Members of the `sudo` group are authorized in `/etc/sudoers` to execute commands as root.

### Command 3: Create Group & Assign Membership
```bash
sudo groupadd itops
sudo usermod -aG itops supporttech
id supporttech
```
- **Expected Output:**
```text
uid=1001(supporttech) gid=1001(supporttech) groups=1001(supporttech),27(sudo),1002(itops)
```

### Command 4: Lock / Disable Account
```bash
sudo passwd -l supporttech
```
- **What it does:** Prepend an exclamation mark (`!`) to the password hash in `/etc/shadow`, disabling password authentication immediately.

## 6. Expected Result
The technician provisions Linux users, manages group authorization, audits `/etc/passwd` and `/etc/group`, and enforces account lifecycle states.

## 7. Troubleshooting
- **Issue: "supporttech is not in the sudoers file. This incident will be reported":**
  - *Cause:* User was added without appending `-a`, or group membership has not refreshed.
  - *Solution:* Ensure `sudo usermod -aG sudo supporttech` was run; log out completely and log back in.

## 8. Screenshots / Evidence
- `screenshots/03-adduser-terminal.png` — *Pending lab execution: Capture interactive adduser session.*
- `screenshots/03-id-command-verify.png` — *Pending lab execution: Capture id command output.*

## 9. Practical Learning Outcome
Ability to administer POSIX user authentication, delegate sudo privileges, and secure account lifecycles.

## 10. Completion Status
Documented
