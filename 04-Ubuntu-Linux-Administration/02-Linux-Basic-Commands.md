# 02 — Linux Basic Commands

**Status:** Documented  
**Environment:** Ubuntu 22.04 LTS terminal (bash)  
**Goal:** Learn essential Linux terminal commands for navigation, file management, and system information.

---

## Why the Terminal?

The Linux terminal (also called the command line, shell, or CLI) is the most powerful way to administer a Linux system. Many server tasks — especially on headless servers with no GUI — can only be done from the terminal. Learning the terminal is a fundamental skill for any IT support professional working with Linux.

> [!TIP]
> Open a terminal in Ubuntu with **Ctrl+Alt+T** or by right-clicking the desktop and selecting **Open Terminal**.

---

## Section 1 — Navigation Commands

Before working with files, you need to know how to move around the Linux filesystem.

### Understanding the Linux Filesystem Layout

| Directory | Purpose |
|---|---|
| `/` | Root — the top of the entire filesystem |
| `/home` | User home directories (e.g., `/home/labadmin`) |
| `/etc` | System configuration files |
| `/var` | Variable data: logs, mail, temp files |
| `/tmp` | Temporary files (cleared on reboot) |
| `/usr` | User programs and utilities |
| `/bin` | Essential command binaries |
| `/sbin` | System administration binaries |
| `/dev` | Device files (disks, terminals) |
| `/proc` | Virtual filesystem: running processes and kernel info |
| `/mnt` | Mount points for external drives |

---

### `pwd` — Print Working Directory

Displays the full path of the directory you are currently in.

```bash
pwd
```

Expected output:
```
/home/labadmin
```

---

### `ls` — List Directory Contents

```bash
ls
```

Expected output (example):
```
Desktop  Documents  Downloads  Music  Pictures  Videos
```

```bash
ls -l
```

Long format — shows permissions, owner, size, and modification date:
```
total 32
drwxr-xr-x 2 labadmin labadmin 4096 Nov  5 09:12 Desktop
drwxr-xr-x 2 labadmin labadmin 4096 Nov  5 09:12 Documents
drwxr-xr-x 2 labadmin labadmin 4096 Nov  5 09:12 Downloads
```

```bash
ls -la
```

Same as `-l` but also shows **hidden files** (files starting with a dot `.`):
```
drwxr-xr-x 15 labadmin labadmin 4096 Nov  5 09:30 .
drwxr-xr-x  3 root     root     4096 Nov  5 08:00 ..
-rw-------  1 labadmin labadmin  220 Nov  5 08:00 .bash_logout
-rw-r--r--  1 labadmin labadmin 3526 Nov  5 08:00 .bashrc
drwxr-xr-x  2 labadmin labadmin 4096 Nov  5 09:12 Desktop
```

```bash
ls -lh
```

Human-readable file sizes (KB, MB, GB instead of bytes).

```bash
ls /etc
```

List contents of a specific directory without navigating to it.

---

### `cd` — Change Directory

```bash
cd /home
```
Navigate to `/home`.

```bash
cd ..
```
Go up one directory level (to the parent directory).

```bash
cd ~
```
Go to your home directory (shortcut for `/home/labadmin`).

```bash
cd /
```
Go to the root directory.

```bash
cd -
```
Go back to the previous directory you were in.

---

## Section 2 — File Operations

### `touch` — Create an Empty File

```bash
touch file.txt
```

Creates `file.txt` in the current directory. If the file already exists, `touch` updates its timestamp without modifying content.

---

### `mkdir` — Create a Directory

```bash
mkdir newfolder
```

```bash
mkdir -p /tmp/lab/exercise1
```

The `-p` flag creates all parent directories as needed (no error if they already exist).

---

### `cp` — Copy Files and Directories

```bash
cp file.txt /tmp/
```
Copy `file.txt` to `/tmp/`.

```bash
cp file.txt backup-file.txt
```
Copy with a new name.

```bash
cp -r myfolder/ /tmp/
```
Recursively copy a directory and all its contents. The `-r` flag is required for directories.

---

### `mv` — Move or Rename Files

```bash
mv file.txt new.txt
```
Rename `file.txt` to `new.txt` (both in the same directory).

```bash
mv file.txt /tmp/
```
Move `file.txt` to `/tmp/`.

```bash
mv myfolder/ /home/labadmin/archive/
```
Move a directory.

---

### `rm` — Remove Files

> [!CAUTION]
> There is no Recycle Bin in the Linux terminal. Files deleted with `rm` are **permanently removed**. Always double-check the path before running `rm`.

```bash
rm file.txt
```
Remove a single file.

```bash
rm -i file.txt
```
Interactive mode — prompts for confirmation before deleting.

```bash
rm -rf folder/
```
Remove a directory and all its contents **recursively and forcefully**. This is one of the most dangerous commands in Linux — verify the path carefully.

---

### `cat` — Display File Contents

```bash
cat file.txt
```

Displays the entire file in the terminal. Best used for short files.

```bash
cat /etc/os-release
```

Expected output:
```
NAME="Ubuntu"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 22.04.3 LTS"
```

---

### `less` — View Large Files Page by Page

```bash
less /var/log/syslog
```

Controls inside `less`:
- **Space** — next page
- **b** — previous page
- **q** — quit
- **/searchterm** — search forward
- **n** — next match

---

### `nano` — Simple Text Editor

```bash
nano file.txt
```

Nano is beginner-friendly. Key shortcuts shown at the bottom of the screen:
- **Ctrl+O** — Write (save) the file
- **Ctrl+X** — Exit nano
- **Ctrl+K** — Cut current line
- **Ctrl+U** — Paste (uncut)
- **Ctrl+W** — Search

---

### `head` and `tail` — View First/Last Lines

```bash
head -n 10 file.txt
```
Show the first 10 lines.

```bash
tail -n 10 file.txt
```
Show the last 10 lines.

```bash
tail -f /var/log/syslog
```
**Follow** a log file in real time — new lines appear as they are written. Press **Ctrl+C** to stop.

---

### `grep` — Search for Text

```bash
grep "error" /var/log/syslog
```
Find all lines containing "error" in the syslog.

```bash
grep -i "error" /var/log/syslog
```
Case-insensitive search.

```bash
grep -r "labadmin" /etc/
```
Recursively search all files in `/etc/` for "labadmin".

```bash
ps aux | grep firefox
```
Pipe the output of `ps aux` into grep to filter for Firefox processes (see Section 4 on piping).

---

## Section 3 — System Information Commands

### `uname` — Kernel and OS Information

```bash
uname -a
```

Expected output:
```
Linux UBUNTU01 5.15.0-91-generic #101-Ubuntu SMP Tue Nov 14 13:30:08 UTC 2023 x86_64 x86_64 x86_64 GNU/Linux
```

Breakdown:
- `Linux` — OS name
- `UBUNTU01` — hostname
- `5.15.0-91-generic` — kernel version
- `x86_64` — architecture (64-bit)

---

### `hostname` — Display Computer Name

```bash
hostname
```

Expected output:
```
UBUNTU01
```

---

### `whoami` — Display Current User

```bash
whoami
```

Expected output:
```
labadmin
```

---

### `uptime` — System Uptime

```bash
uptime
```

Expected output:
```
 09:45:21 up  1:23,  1 user,  load average: 0.08, 0.12, 0.10
```

- `up 1:23` — system has been running for 1 hour 23 minutes
- `load average` — CPU load over the last 1, 5, and 15 minutes

---

### `date` — Current Date and Time

```bash
date
```

Expected output:
```
Sun Nov  5 09:45:21 UTC 2023
```

---

### `df -h` — Disk Space Usage

```bash
df -h
```

Expected output:
```
Filesystem      Size  Used Avail Use% Mounted on
tmpfs           392M  1.5M  390M   1% /run
/dev/sda1        25G  5.1G   18G  22% /
tmpfs           2.0G     0  2.0G   0% /dev/shm
```

- `-h` = human-readable sizes (MB, GB)
- Use% = percentage of disk used
- Mounted on = the directory this filesystem is accessible at

---

### `free -h` — Memory Usage

```bash
free -h
```

Expected output:
```
               total        used        free      shared  buff/cache   available
Mem:           3.8Gi       1.2Gi       1.5Gi        50Mi       1.1Gi       2.4Gi
Swap:          2.0Gi          0B       2.0Gi
```

- **Mem** — physical RAM
- **Swap** — virtual memory on disk (slow; used when RAM is full)
- **available** — memory practically available for new programs

---

### `lscpu` — CPU Information

```bash
lscpu
```

Expected output (excerpt):
```
Architecture:            x86_64
CPU(s):                  2
Model name:              Intel(R) Core(TM) i7-10750H CPU @ 2.60GHz
Thread(s) per core:      1
Core(s) per socket:      2
```

---

### `lsblk` — List Block Devices

```bash
lsblk
```

Expected output:
```
NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sda      8:0    0   25G  0 disk
├─sda1   8:1    0 24.9G  0 part /
└─sda2   8:2    0  100M  0 part /boot/efi
sr0     11:0    1 1024M  0 rom
```

Shows disks (`sda`), partitions (`sda1`, `sda2`), and where they are mounted.

---

## Section 4 — Piping and Redirection

The pipe `|` sends the output of one command as the input to another.

```bash
ps aux | grep ssh
```
Show only processes whose name contains "ssh".

```bash
df -h | grep sda
```
Show disk usage for only the `sda` disk.

```bash
cat /etc/passwd | wc -l
```
Count the number of lines in `/etc/passwd` (i.e., number of user accounts).

Redirection operators:

```bash
ls -la > filelist.txt       # Save output to a file (overwrite)
ls -la >> filelist.txt      # Append output to a file
grep "error" syslog 2>/dev/null  # Discard error messages
```

---

## Section 5 — Useful Keyboard Shortcuts

| Shortcut | Action |
|---|---|
| **Tab** | Autocomplete command, filename, or directory name |
| **Tab Tab** | Show all possible completions if Tab is ambiguous |
| **↑ / ↓** | Scroll through command history |
| **Ctrl+C** | Cancel / interrupt the current running command |
| **Ctrl+Z** | Suspend (pause) the current command (send to background) |
| **Ctrl+D** | Log out of terminal / end input |
| **Ctrl+L** | Clear the terminal screen (same as typing `clear`) |
| **Ctrl+A** | Move cursor to beginning of line |
| **Ctrl+E** | Move cursor to end of line |
| **Ctrl+R** | Reverse search through command history |
| **!!** | Repeat the last command |
| **sudo !!** | Re-run the last command with sudo |

---

## Section 6 — Tips for New Linux Users

**1. Linux is case-sensitive.**  
`File.txt`, `file.txt`, and `FILE.TXT` are three different files. Commands must also be lowercase: `ls` works, `LS` does not.

**2. Use Tab autocomplete constantly.**  
Typing `cat /etc/net` then pressing Tab will auto-complete to `cat /etc/netplan/` — faster and no typos.

**3. The `man` command shows the manual.**  
```bash
man ls         # Manual for the ls command
man cp         # Manual for the cp command
```
Press `q` to quit.

**4. `sudo` is "do as administrator."**  
Many system tasks require elevated privileges. Prefix the command with `sudo`:
```bash
sudo apt update
sudo nano /etc/ssh/sshd_config
```
You will be prompted for your own password, not root's.

**5. Use `history` to review past commands.**  
```bash
history
history | grep apt
```

**6. Common beginner mistakes:**
- Forgetting `sudo` for privileged operations → "Permission denied"
- Using `rm -rf` without verifying the path
- Confusing `/` (root) with `/root` (root user's home directory)
- Forgetting the `-r` flag when copying directories with `cp`
- Closing the terminal instead of stopping a process with Ctrl+C

---

*Module: 04-Ubuntu-Linux-Administration | File: 02-Linux-Basic-Commands.md | Status: Documented*
