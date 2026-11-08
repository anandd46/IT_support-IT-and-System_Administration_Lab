# Practical Task: Windows Server 2022 Monitoring and Performance Baselines

## 1. Objective
Establish server performance baselines, monitor critical hardware counters (CPU, RAM, Disk, Network), configure Performance Monitor Data Collector Sets, and track server system metrics.

## 2. Requirements
- Windows Server 2022 (`SERVER01`)
- Administrative access
- Tools: Task Manager, Resource Monitor (`resmon`), Performance Monitor (`perfmon`)

## 3. Background
Server monitoring ensures infrastructure reliability and prevents unexpected downtime. Systems administrators must track four primary subsystems:
1. **Processor:** `\Processor(_Total)\% Processor Time` (>80% sustained indicates bottleneck).
2. **Memory:** `\Memory\Available MBytes` (<10% total RAM indicates memory exhaustion) and `\Memory\Pages/sec`.
3. **Storage:** `\LogicalDisk(_Total)\% Free Space` and `\PhysicalDisk(_Total)\Current Disk Queue Length` (>2 per spindle indicates disk saturation).
4. **Network:** `\Network Interface(*)\Bytes Total/sec`.

## 4. Step-by-Step Procedure
1. **Launch Performance Monitor:** Run `perfmon.msc`.
2. **Real-Time Graphing:** Expand Monitoring Tools > Performance Monitor.
3. **Add Counters:** Click the green plus (+) button. Add:
   - `Processor -> % Processor Time`
   - `Memory -> Available MBytes`
   - `PhysicalDisk -> % Disk Time`
4. **Create Data Collector Set:** Expand Data Collector Sets > User Defined > Right-click > New > Data Collector Set > Name: "Server_Baseline_24Hr".
5. **Set Schedule & Threshold Alerts:** Configure an alert to log an event if Available Memory drops below 500 MB.
6. **Query Performance via PowerShell:** Query live performance counters using `Get-Counter`.

## 5. Commands Used

### Command 1: Query Live Processor & Memory Counters
```powershell
Get-Counter -Counter "\Processor(_Total)\% Processor Time", "\Memory\Available MBytes" -SampleInterval 2 -MaxSamples 5
```
- **What it does:** Samples processor load and free memory every 2 seconds for 5 iterations.

### Command 2: Query Server Uptime and Last Boot
```powershell
Get-CimInstance Win32_OperatingSystem | Select-Object LastBootUpTime, @{N='Uptime (Days)';E={[math]::Round(((Get-Date) - $_.LastBootUpTime).TotalDays, 2)}}
```
- **What it does:** Displays exact time of last server restart and elapsed operational uptime in days.

## 6. Expected Result
A real-time performance baseline is captured, and continuous automated logging is configured via Performance Monitor.

## 7. Troubleshooting
- **Issue: High disk queue length and slow user access to file shares:**
  - *Cause:* Antivirus scan running during operational peak, backup job active, or failing storage drive.
  - *Solution:* Inspect Resource Monitor Disk tab to identify high-I/O processes; reschedule backups to off-peak hours.

## 8. Screenshots / Evidence
- `screenshots/07-perfmon-counters.png` — *Pending lab execution: Capture Performance Monitor line graph.*
- `screenshots/07-powershell-counter-output.png` — *Pending lab execution: Capture Get-Counter output.*

## 9. Practical Learning Outcome
Ability to capture operational baselines, detect capacity bottlenecks before they cause downtime, and establish automated server telemetry.

## 10. Completion Status
Documented
