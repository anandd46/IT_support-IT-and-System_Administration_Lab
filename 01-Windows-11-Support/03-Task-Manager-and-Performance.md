# Practical Task: Task Manager and System Performance Monitoring

## 1. Objective
Analyze CPU, Memory, Disk, and Network utilization in Windows 11, manage startup programs, identify runaway processes, and utilize Resource Monitor and Performance Monitor for performance baseline troubleshooting.

## 2. Requirements
- Windows 11 PC or Virtual Machine
- Administrative credentials for terminating system-level processes
- Native tools: Task Manager (`taskmgr`), Resource Monitor (`resmon`), Performance Monitor (`perfmon`)

## 3. Background
Unresponsive applications, system slowdowns, and thermal throttling are among the most frequent user complaints handled by IT Support. Task Manager provides real-time telemetry across five core resources:
1. **CPU:** Evaluates compute thread saturation and interrupt handling.
2. **Memory:** Differentiates In-Use, Committed, Cached, and Paged/Non-Paged pool leaks.
3. **Disk:** Monitors Active Time %, Read/Write transfer rates, and response times in milliseconds (response time > 50ms indicates I/O bottleneck).
4. **Network:** Tracks bandwidth consumption per adapter.
5. **GPU:** Monitors 3D engine, Video Decode, and dedicated GPU VRAM.

## 4. Step-by-Step Procedure
1. **Launch Task Manager:** Press Ctrl + Shift + Esc or right-click the Start button and select Task Manager.
2. **Processes Analysis:** Sort by CPU and Memory in descending order to identify top consumers.
3. **Performance Graphs:** Navigate to the Performance tab. Inspect CPU cores, memory composition, disk response time, and ethernet throughput.
4. **Manage Startup Applications:** Click the Startup Apps tab. Evaluate impact ratings (High, Medium, Low) and disable unauthorized or non-essential startup items.
5. **Resource Monitor Investigation:** Launch Resource Monitor from Performance tab or run `resmon`. Inspect Disk Queue Length and Network TCP Connections per executable.
6. **Graceful vs Forced Process Termination:** Test ending a hung process gracefully before invoking forced termination.

## 5. Commands Used

### Command 1: Opening Diagnostic Consoles
```cmd
taskmgr
resmon
perfmon /res
```
- **What it does:** Launches Task Manager, Resource Monitor, and Performance Monitor directly from run prompts or scripts.
- **Why it is used:** Bypasses GUI menu delays during severe UI sluggishness.

### Command 2: PowerShell Process Query by Resource Usage
```powershell
Get-Process | Sort-Object -Property WorkingSet64 -Descending | Select-Object -First 10 -Property Name, Id, @{N='Memory (MB)';E={[math]::Round($_.WorkingSet64 / 1MB, 2)}}, @{N='CPU (s)';E={$_.CPU}}
```
- **What it does:** Lists the top 10 memory-consuming processes formatted in megabytes with CPU seconds.
- **Why it is used:** Quickly pinpoints memory hogs during remote PowerShell sessions without an interactive desktop.

### Command 3: Terminating Hung Applications
```cmd
taskkill /IM processname.exe /F
```
- **What it does:** Forcefully terminates the specified process image and child threads.
- **Why it is used:** Terminates crashed background instances that refuse to exit via regular Task Manager closure.

## 6. Expected Result
The technician identifies processes creating bottlenecks, disables non-essential startup bloat, captures real-time utilization baselines, and resolves application hangs without unnecessary full system reboots.

## 7. Troubleshooting
- **Issue: High CPU usage attributed to `System Idle Process`:**
  - *Cause:* System Idle Process represents unused CPU capacity (e.g., 90% means 90% free).
  - *Solution:* Normal behavior; explain to user that this represents idle headroom, not load.
- **Issue: Disk usage locked at 100% with low transfer speeds:**
  - *Cause:* Failing mechanical HDD, Windows Search indexing loop, or aggressive telemetry logging.
  - *Solution:* Inspect Resource Monitor Disk Response Time; check SMART health; consider SSD upgrade or service tuning.

## 8. Screenshots / Evidence
- `screenshots/03-taskmanager-processes.png` — *Pending lab execution: Capture Processes tab sorted by CPU.*
- `screenshots/03-taskmanager-performance.png` — *Pending lab execution: Capture Performance tab memory breakdown.*
- `screenshots/03-resmon-disk-tab.png` — *Pending lab execution: Capture Resource Monitor Disk response time.*

## 9. Practical Learning Outcome
Mastery of real-time resource diagnostics, identifying resource bottlenecks, managing system startup overhead, and executing structured performance optimization.

## 10. Completion Status
Documented
