# Practical Task: Linux Process and Service Management (`systemd`, `ps`, `top`)

## 1. Objective
Monitor active processes, identify runaway compute tasks, terminate hung applications, and manage background system services using `systemd` (`systemctl`) in Ubuntu 22.04 LTS.

## 2. Requirements
- Ubuntu 22.04 LTS VM
- Sudo access
- Terminal tools: `ps`, `top`, `htop`, `kill`, `pkill`, `systemctl`

## 3. Background
In Linux:
- **Processes:** Running instances of programs, identified by a unique Process ID (PID).
- **Signals:** Communications sent to processes (e.g., `SIGTERM` / signal 15 asks gracefully to exit; `SIGKILL` / signal 9 forces kernel termination).
- **systemd:** The init system and service manager (PID 1). Controls daemons, service lifecycles, and system targets.

## 4. Step-by-Step Procedure
1. **Real-Time Process Inspection:** Launch `top` or `htop`. Inspect `%CPU`, `%MEM`, load averages (1, 5, 15 min), and task states (R, S, Z).
2. **Snapshot Process Tree:** Run `ps aux --sort=-%cpu | head -10` to view top 10 CPU consumers.
3. **Simulate Hung Process & Terminate:** Start a background sleep process (`sleep 1000 &`), query its PID with `pgrep`, and terminate it with `kill`.
4. **Service Administration with systemctl:**
   - Check SSH service status: `sudo systemctl status ssh`.
   - Test stopping, starting, and restarting services.
   - Enable service to start on boot: `sudo systemctl enable ssh`.
5. **Review Service Logs:** Use `journalctl -u ssh -n 20 --no-pager` to inspect service events.

## 5. Commands Used

### Command 1: Process Snapshot
```bash
ps aux | grep -i nginx
```
- **What it does:** Filters active process table for specific daemon instances, displaying user, PID, CPU, memory, and start time.

### Command 2: Terminating Processes
```bash
kill -15 <PID>    # Graceful SIGTERM
kill -9 <PID>     # Forceful SIGKILL (use only if SIGTERM ignored)
pkill -f sleep    # Terminate by process name pattern
```

### Command 3: Service Management via systemctl
```bash
sudo systemctl status ssh
sudo systemctl restart ssh
sudo systemctl enable ssh
```
- **What it does:** Displays service health, reloads daemon, and creates symbolic links to start the service at default multi-user runlevel.

## 6. Expected Result
The technician monitors system load, terminates runaway processes cleanly, administers systemd services, and extracts daemon error logs.

## 7. Troubleshooting
- **Issue: Service fails to start ("Unit entered failed state"):**
  - *Cause:* Configuration file syntax error or port collision.
  - *Solution:* Inspect recent systemd logs using `journalctl -xeu <servicename>`.

## 8. Screenshots / Evidence
- `screenshots/06-top-htop-terminal.png` — *Pending lab execution: Capture top or htop process telemetry.*
- `screenshots/06-systemctl-status-ssh.png` — *Pending lab execution: Capture clean systemctl status output.*

## 9. Practical Learning Outcome
Mastery in process lifecycle control, resource monitoring, signal delivery, and systemd service administration.

## 10. Completion Status
Documented
