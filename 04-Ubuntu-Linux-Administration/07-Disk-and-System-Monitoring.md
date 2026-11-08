# Practical Task: Linux Disk and System Resource Monitoring

## 1. Objective
Analyze filesystem utilization (`df`), measure directory space consumption (`du`), monitor block storage partitions (`lsblk`), review memory allocation (`free`), and inspect system uptime in Ubuntu 22.04 LTS.

## 2. Requirements
- Ubuntu 22.04 LTS VM
- Standard and administrative command prompt
- Tools: `df`, `du`, `lsblk`, `free`, `uptime`, `smartctl`

## 3. Background
Preventing server crashes requires proactive monitoring of disk partitions and RAM. When the root filesystem (`/`) reaches 100% capacity, Linux services immediately begin failing: logs cannot write, databases corrupt transactions, and users cannot log in due to failed temporary session file creation in `/tmp`.

## 4. Step-by-Step Procedure
1. **Analyze Filesystem Capacity:** Run `df -h` to examine disk usage across mounted partitions in human-readable gigabytes/megabytes.
2. **Find Large Directory Consumers:** Use `du -sh /* 2>/dev/null | sort -h` to pinpoint which root directory is consuming excess storage.
3. **Find Large Files:** Search for files larger than 100 MB using `find / -type f -size +100M`.
4. **Block Device Hierarchy:** Run `lsblk` to display disks, partitions, and LVM logical volume mount points.
5. **Memory & Swap Inspection:** Run `free -m` or `free -h` to evaluate physical RAM in use, buffers, cached memory, and swap space.
6. **System Uptime & Load:** Run `uptime` to evaluate whether the system is CPU-bound.

## 5. Commands Used

### Command 1: Filesystem Free Space
```bash
df -h --output=source,fstype,size,used,avail,pcent,target
```
- **What it does:** Summarizes total capacity, used gigabytes, and percentage used per mounted filesystem.

### Command 2: Top Space Consumers
```bash
sudo du -ah /var/log 2>/dev/null | sort -rh | head -n 10
```
- **What it does:** Scans `/var/log` and lists the 10 largest individual log files consuming server storage.

### Command 3: Memory Inspection
```bash
free -h
```
- **Expected Output:**
```text
               total        used        free      shared  buff/cache   available
Mem:           3.8Gi       850Mi       1.8Gi        15Mi       1.1Gi       2.7Gi
Swap:          2.0Gi          0B       2.0Gi
```
*Note: Available memory represents memory that can be immediately assigned to applications without swapping.*

## 6. Expected Result
The technician identifies partition capacities, pinpoints bloated log directories, evaluates RAM availability, and takes preventive cleanup measures before disk exhaustion occurs.

## 7. Troubleshooting
- **Issue: `df -h` shows partition is 100% full, but `du` cannot find large files:**
  - *Cause:* A deleted file is still held open by a running process (e.g., deleted Apache or application log).
  - *Solution:* Run `sudo lsof +L1` to find deleted unlinked files held in memory; restart the responsible service.

## 8. Screenshots / Evidence
- `screenshots/07-df-h-filesystem.png` — *Pending lab execution: Capture df -h output.*
- `screenshots/07-free-memory-terminal.png` — *Pending lab execution: Capture free -h memory table.*

## 9. Practical Learning Outcome
Ability to monitor disk space, resolve storage exhaustion incidents, track RAM allocation, and prevent server lockups.

## 10. Completion Status
Documented
