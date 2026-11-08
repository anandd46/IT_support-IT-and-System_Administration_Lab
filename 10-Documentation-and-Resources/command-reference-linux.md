# Complete Ubuntu Linux Command Reference

This master reference provides syntax and practical usage examples for Ubuntu Linux administration from the terminal.

---

## 1. File Navigation, Search, and File Operations

| Command | Practical Syntax | Description |
|---|---|---|
| `ls` | `ls -la` | Lists all files including hidden dotfiles with permissions, ownership, size, and timestamp. |
| `cd` | `cd /var/log` | Changes current working directory to specified path (`cd ~` returns home, `cd ..` goes up). |
| `pwd` | `pwd` | Prints the absolute path of the current working directory. |
| `cp` | `cp -r /source /destination` | Copies files or directories recursively (`-r`). |
| `mv` | `mv oldname newname` | Moves or renames files and directories. |
| `rm` | `rm -i file.txt` | Removes file with confirmation prompt (`rm -rf` forcefully deletes directory tree; use with extreme caution). |
| `cat` | `cat /etc/os-release` | Concatenates and prints entire file content to terminal screen. |
| `less` | `less /var/log/syslog` | Interactive pager allowing forward/backward scrolling through large files (press `q` to exit). |
| `grep` | `grep -rn "error" /var/log/` | Recursively searches directories for specific text strings with line numbers (`-n`). |
| `find` | `find / -type f -size +100M` | Scans filesystem and prints files larger than 100 megabytes. |
| `tar` | `tar -czvf backup.tar.gz /data` | Creates a compressed gzip tarball archive (`-c` create, `-z` gzip, `-v` verbose, `-f` file). |
| `tar` | `tar -xzvf backup.tar.gz -C /opt` | Extracts compressed gzip archive into target directory. |

---

## 2. User Accounts, Groups, and Permissions

| Command | Practical Syntax | Description |
|---|---|---|
| `adduser` | `sudo adduser techuser` | Interactively creates new user, provisions `/home/techuser`, and sets password. |
| `usermod` | `sudo usermod -aG sudo techuser` | Appends user to secondary administrative `sudo` group. |
| `passwd` | `sudo passwd -l techuser` | Locks user account password in `/etc/shadow` (disables password logon). |
| `id` | `id techuser` | Displays user UID, primary GID, and all secondary group memberships. |
| `chmod` | `chmod 755 script.sh` | Sets octal permissions: Owner (`rwx`), Group (`r-x`), Others (`r-x`). |
| `chmod` | `chmod +x script.sh` | Adds execute permission to file using symbolic syntax. |
| `chown` | `sudo chown -R user:group /opt/app` | Recursively assigns user and group ownership on target directory. |

---

## 3. Processes, Services, and System Monitoring

| Command | Practical Syntax | Description |
|---|---|---|
| `ps` | `ps aux | grep nginx` | Displays snapshot of running processes filtered by name. |
| `top` | `top` | Real-time interactive process viewer showing CPU/memory utilization and system load. |
| `htop` | `htop` | Enhanced interactive color process manager with mouse support and tree views. |
| `kill` | `kill -15 <PID>` | Sends graceful `SIGTERM` signal asking process to terminate cleanly. |
| `kill` | `kill -9 <PID>` | Sends forceful `SIGKILL` kernel signal terminating hung process immediately. |
| `systemctl` | `sudo systemctl status ssh` | Queries operational health, PID, and recent logs for systemd service unit. |
| `systemctl` | `sudo systemctl restart nginx` | Restarts systemd daemon service. |
| `systemctl` | `sudo systemctl enable --now ufw` | Enables firewall to start at boot and starts it immediately. |
| `journalctl`| `journalctl -u ssh -n 50 --no-pager` | Displays last 50 log events recorded by systemd journal for SSH service. |
| `df` | `df -h` | Displays disk space usage across mounted filesystems in human-readable gigabytes. |
| `du` | `du -sh /var/* 2>/dev/null | sort -h` | Calculates size of each directory under `/var` sorted by size. |
| `free` | `free -h` | Displays total, used, free, and available physical RAM and swap space. |
| `uptime` | `uptime` | Displays system running time and 1, 5, and 15-minute load averages. |

---

## 4. Linux Networking

| Command | Practical Syntax | Description |
|---|---|---|
| `ip addr` | `ip -brief address show` | Displays active network interfaces, operational state (UP/DOWN), and IPv4/IPv6 addresses. |
| `ip route`| `ip route show` | Displays kernel routing table and default gateway IP. |
| `ss` | `ss -tulpn` | Socket statistics; displays listening TCP and UDP ports with process names. |
| `ping` | `ping -c 4 8.8.8.8` | Sends 4 ICMP echo requests to evaluate network latency. |
| `traceroute`| `traceroute 8.8.8.8` | Traces network path hops to remote IP. |
| `nslookup`| `nslookup domain.com` | Queries DNS servers for host A/AAAA records. |
| `dig` | `dig domain.com ANY` | Advanced DNS query returning full zone record headers. |
| `netplan` | `sudo netplan apply` | Compiles YAML network files in `/etc/netplan/` and applies settings to interfaces. |
