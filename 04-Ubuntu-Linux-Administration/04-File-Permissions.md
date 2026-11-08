# Practical Task: Linux File Permissions and Ownership (`chmod` and `chown`)

## 1. Objective
Master POSIX file system permissions, symbolic and octal modes, group ownership delegation (`chown`), and special permissions in Ubuntu Linux.

## 2. Requirements
- Ubuntu 22.04 LTS VM
- Standard user and administrative `sudo` access
- Bash shell

## 3. Background
Every file and directory in Linux has an owner user, an owner group, and three sets of permissions:
```text
- rwx r-x r--
| --- --- ---
|  |   |   |-> Others (world) permissions: read only (4)
|  |   |-----> Group permissions: read and execute (5)
|  |---------> Owner permissions: read, write, execute (7)
|------------> File type (- = regular file, d = directory)
```

Octal Numerical Values:
- `r` (Read) = 4
- `w` (Write) = 2
- `x` (Execute) = 1
- `-` (None) = 0

Directory Permission Meanings:
- `r`: Can list contents (`ls`).
- `w`: Can create, rename, or delete files inside directory.
- `x`: Can enter directory (`cd`) or access files inside.

## 4. Step-by-Step Procedure
1. **Create Test File and Directory:** Create `/opt/itdocs` and test file `script.sh`.
2. **Inspect Initial Permissions:** Run `ls -la` to review default permissions governed by `umask`.
3. **Change Ownership:** Use `chown` to assign owner `supporttech` and group `itops`.
4. **Modify Permissions (Octal Mode):** Set permissions to `750` (`rwxr-x---`) on directories and `640` (`rw-r-----`) on data files.
5. **Make Script Executable (Symbolic Mode):** Run `chmod u+x script.sh`.
6. **Test Boundary Security:** Switch to an unauthorized user and verify that reading `/opt/itdocs` produces "Permission denied".

## 5. Commands Used

### Command 1: Ownership Delegation
```bash
sudo chown -R supporttech:itops /opt/itdocs
```
- **What it does:** Recursively sets user `supporttech` as file owner and `itops` as group owner for `/opt/itdocs` and child files.

### Command 2: Apply Octal Permissions
```bash
chmod 750 /opt/itdocs
chmod 640 /opt/itdocs/inventory.txt
chmod +x /opt/itdocs/backup.sh
ls -ld /opt/itdocs
```
- **Expected Output:**
```text
drwxr-x--- 2 supporttech itops 4096 Nov 8 08:00 /opt/itdocs
```

## 6. Expected Result
Files and directories are secured according to the principle of least privilege. Only authorized users and group members can access departmental directories.

## 7. Troubleshooting
- **Issue: User can read files in directory but cannot `cd` into it:**
  - *Cause:* Directory is missing the Execute (`x`) permission for the user or group.
  - *Solution:* Run `chmod g+x directory_name`.

## 8. Screenshots / Evidence
- `screenshots/04-ls-la-permissions.png` — *Pending lab execution: Capture ls -la permission breakdown.*
- `screenshots/04-chmod-chown-terminal.png` — *Pending lab execution: Capture chmod and chown execution.*

## 9. Practical Learning Outcome
Mastery in calculating octal/symbolic permissions, enforcing directory security boundaries, and managing Linux file ownership.

## 10. Completion Status
Documented
