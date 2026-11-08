# Practical Task: Event Viewer Diagnostics and Log Analysis

## 1. Objective
Analyze Windows Event Logs to identify system crashes, hardware failures, application errors, logon activity, and driver anomalies in Windows 11.

## 2. Requirements
- Windows 11 workstation
- Administrative credentials
- Tools: Event Viewer (`eventvwr.msc`), PowerShell `Get-WinEvent`

## 3. Background
Windows Event Viewer is the centralized logging subsystem for the Windows NT operating system family. It records security audits, system errors, service state transitions, and software crashes.

Core Windows Logs:
1. **Application:** Errors and notices logged by installed applications and third-party services.
2. **Security:** Auditing events (logon successes, failed logins, privilege use, policy changes).
3. **System:** Operating system kernel, device drivers, storage failures, and network stack events.

Key Event Severity Levels:
- **Information:** Normal operational milestones (e.g., service started, update completed).
- **Warning:** Non-critical condition that may lead to future failure (e.g., disk nearing capacity, DNS lookup timeout).
- **Error:** Significant failure impacting functionality (e.g., service terminated unexpectedly, driver failed to load).
- **Critical:** System-level failure causing crash or abrupt shutdown (e.g., Event ID 41 Kernel-Power).

## 4. Step-by-Step Procedure
1. **Launch Event Viewer:** Press Win + R, type `eventvwr.msc`, and press Enter.
2. **Navigate Windows Logs:** Expand Windows Logs > Click System.
3. **Filter Log by Severity:** In the right Actions pane, click `Filter Current Log...`. Check Critical, Warning, and Error. Filter by Last 24 hours.
4. **Inspect Common Critical Event IDs:**
   - **Event ID 41 (Kernel-Power):** System rebooted without cleanly shutting down.
   - **Event ID 6008:** Previous system shutdown was unexpected.
   - **Event ID 7000/7001:** Service failed to start.
   - **Event ID 4625 (Security Log):** Account failed to log on (invalid credentials).
5. **Create a Custom Diagnostic View:** Create a custom view capturing all Critical/Error events across Application and System logs.
6. **Save and Export Logs:** Export filtered logs to `.evtx` for escalation to Level 3 / Senior SysAdmin.
7. **Query Events via PowerShell:** Extract recent system errors using `Get-WinEvent`.

## 5. Commands Used

### Command 1: Launch Event Viewer
```cmd
eventvwr.msc
```
- **What it does:** Opens the Event Viewer console.
- **Why it is used:** Fast access to diagnostic logs.

### Command 2: PowerShell - Query Last 10 System Errors
```powershell
Get-WinEvent -FilterHashtable @{LogName='System'; Level=1,2} -MaxEvents 10 | Select-Object TimeCreated, Id, ProviderName, Message | Format-List
```
- **What it does:** Retrieves the 10 most recent Critical (Level 1) and Error (Level 2) events from the System log.
- **Why it is used:** Enables rapid CLI triage during remote support sessions without waiting for GUI tree rendering.

### Command 3: PowerShell - Inspect Failed Logon Attempts
```powershell
Get-WinEvent -FilterHashtable @{LogName='Security'; Id=4625} -MaxEvents 5 -ErrorAction SilentlyContinue | Select-Object TimeCreated, @{N='Account';E={$_.Properties[5].Value}}, @{N='FailureReason';E={$_.Properties[8].Value}}
```
- **What it does:** Queries the Security log for Event ID 4625 (Failed Logon).
- **Why it is used:** Essential for diagnosing user account lockouts, brute-force password guessing, or misconfigured service account credentials.

## 6. Expected Result
The technician navigates Event Viewer, filters logs by event severity and source, identifies the root cause of crashes or service terminations, and exports `.evtx` logs for incident reports.

## 7. Troubleshooting
- **Issue: Event Viewer shows error "The Event Log service is unavailable":**
  - *Cause:* `Windows Event Log` service (`eventlog`) stopped or disabled.
  - *Solution:* Open `services.msc`, set Windows Event Log startup type to Automatic, and start the service.
- **Issue: Security log does not record failed logon attempts (Event ID 4625 missing):**
  - *Cause:* Audit Logon Events policy not enabled in Local Security Policy.
  - *Solution:* Run `secpol.msc`, navigate to Security Settings > Local Policies > Audit Policy > Enable `Audit logon events` (Success and Failure).

## 8. Screenshots / Evidence
- `screenshots/07-eventvwr-filtered-system.png` — *Pending lab execution: Capture Event Viewer System log filtered by Error and Critical.*
- `screenshots/07-event-id-41-details.png` — *Pending lab execution: Capture Event ID 41 Kernel-Power event properties.*
- `screenshots/07-powershell-winevent.png` — *Pending lab execution: Capture PowerShell Get-WinEvent query results.*

## 9. Practical Learning Outcome
Mastery in reading, filtering, interpreting, and exporting enterprise Windows event logs to pinpoint system crashes, hardware failures, and security events.

## 10. Completion Status
Documented
