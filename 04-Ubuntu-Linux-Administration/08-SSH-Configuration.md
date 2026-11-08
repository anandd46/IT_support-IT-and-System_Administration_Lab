# Practical Task: Secure Shell (SSH) Server Configuration and Hardening

## 1. Objective
Install, configure, test, and harden the OpenSSH Server (`sshd`) on Ubuntu 22.04 LTS, generate asymmetric RSA/Ed25519 key pairs, and enforce key-based remote authentication.

## 2. Requirements
- Ubuntu 22.04 LTS VM (`UBUNTU01` at `192.168.100.30`)
- Client computer with SSH client (Windows 11 or second Linux host)
- OpenSSH Server package (`openssh-server`)

## 3. Background
Secure Shell (SSH) is the ubiquitous protocol for encrypted remote administration of Linux servers. By default, SSH operates on TCP Port 22. Enterprise security baselines mandate:
- Disabling direct root login (`PermitRootLogin no`).
- Utilizing public-key cryptography instead of passwords (`PasswordAuthentication no`).
- Restricting listening interfaces and managing brute-force protection.

## 4. Step-by-Step Procedure
1. **Install OpenSSH Server:** Run `sudo apt install -y openssh-server`.
2. **Verify Daemon Status:** Check `sudo systemctl status ssh` and verify port listening (`ss -tlnp | grep 22`).
3. **Generate SSH Key Pair on Client:** On Windows 11 client, execute `ssh-keygen -t ed25519 -C "anand@itlab"`.
4. **Copy Public Key to Linux Server:** Transfer public key to `~/.ssh/authorized_keys` on Ubuntu.
5. **Test Key-Based Authentication:** Connect from client: `ssh supporttech@192.168.100.30`. Confirm instant login without password prompt.
6. **Harden SSH Daemon Configuration:**
   - Edit `/etc/ssh/sshd_config`.
   - Set `PermitRootLogin no`.
   - Set `PasswordAuthentication no` (after verifying key login).
   - Reload SSH: `sudo systemctl restart ssh`.

## 5. Commands Used

### Command 1: Generate Client Key Pair (Ed25519)
```bash
ssh-keygen -t ed25519 -C "admin_key"
```
- **What it does:** Generates private key `id_ed25519` and public key `id_ed25519.pub`.

### Command 2: Install Public Key onto Server
```bash
ssh-copy-id -i ~/.ssh/id_ed25519.pub supporttech@192.168.100.30
```
- **What it does:** Appends public key into `/home/supporttech/.ssh/authorized_keys` on remote server with proper permissions (`600` on file, `700` on folder).

### Command 3: Test Remote Session
```bash
ssh supporttech@192.168.100.30
```

## 6. Expected Result
The administrator connects remotely over encrypted SSH sessions authenticated via high-security asymmetric keys with direct root login disabled.

## 7. Troubleshooting
- **Issue: "Permission denied (publickey)":**
  - *Cause:* Permissions on `~/.ssh` or `~/.ssh/authorized_keys` are too loose (SSH rejects world-writable key files).
  - *Solution:* On server, run: `chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys`.

## 8. Screenshots / Evidence
- `screenshots/08-ssh-status-terminal.png` — *Pending lab execution: Capture systemctl status ssh.*
- `screenshots/08-ssh-key-login-client.png` — *Pending lab execution: Capture successful key-based login.*

## 9. Practical Learning Outcome
Mastery in enterprise remote access administration, SSH cryptographic key deployment, and server daemon hardening.

## 10. Completion Status
Documented
