# Practical Task: Group Policy Object (GPO) Deployment and Enforcement

## 1. Objective
Create, configure, and link Group Policy Objects (GPOs) to departmental OUs, enforce automated workstation configurations, and test policy application using `gpupdate` and `gpresult`.

## 2. Requirements
- Domain Controller (`SERVER01.lab.local`)
- Domain-joined client machine (`CLIENT01`)
- Domain Administrator privileges
- Group Policy Management Console (`gpmc.msc`)

## 3. Background
Group Policy is the primary management engine for Windows domains. It enables administrators to push centralized registry settings, security constraints, software restrictions, and user configurations across thousands of computers simultaneously.

Policies Tested in Lab:
1. **Workstation Security Baseline:** Inactivity screen lock after 10 minutes; disable USB removable storage.
2. **Departmental Mapped Drives:** Automatically map departmental share (`\\SERVER01\<Dept>`) as drive `Z:`.

## 4. Step-by-Step Procedure
1. **Launch GPMC:** Press Win + R, type `gpmc.msc`, and press Enter.
2. **Create New GPO:** Expand `Forest: lab.local` > `Domains` > `lab.local` > Right-click `Group Policy Objects` > New > Name: `GPO_Workstation_Security_Baseline`.
3. **Configure Screen Lock Timeout:**
   - Right-click GPO > Edit.
   - Navigate to: User Configuration > Policies > Administrative Templates > Control Panel > Personalization.
   - Enable "Screen saver timeout" > Set to 600 seconds (10 minutes).
   - Enable "Password protect the screen saver".
4. **Link GPO to OU:** Right-click the `Workstations` OU > Link an Existing GPO > Select `GPO_Workstation_Security_Baseline`.
5. **Force Immediate Refresh on Client:** On `CLIENT01`, open Command Prompt and execute `gpupdate /force`.
6. **Generate Policy Result Report:** On `CLIENT01`, run `gpresult /r` and verify that the GPO is listed under Applied Group Policy Objects.

## 5. Commands Used

### Command 1: Force Group Policy Update on Client
```cmd
gpupdate /force
```
- **What it does:** Bypasses normal background refresh intervals (90 minutes) and immediately reapplies all computer and user policies from the DC.
- **Expected Output:**
```text
Updating policy...
Computer Policy update has completed successfully.
User Policy update has completed successfully.
```

### Command 2: Query Applied GPOs via CLI
```cmd
gpresult /r
```
- **What it does:** Displays an ASCII report of applied and filtered computer and user policies, security group memberships, and OS architecture.

### Command 3: Generate Detailed HTML Group Policy Report
```cmd
gpresult /h C:\Temp\GPReport.html
```
- **What it does:** Generates a comprehensive interactive HTML report detailing every applied registry key, preference, and GPO execution time.

## 6. Expected Result
The GPO is applied to the client workstation, enforcing automatic screen lockout and policy configuration without manual workstation tweaking.

## 7. Troubleshooting
- **Issue: GPO appears in gpresult as "Denied (Security Filtering)":**
  - *Cause:* Target computer or user is not a member of the security filtering scope (e.g., `Authenticated Users` was removed).
  - *Solution:* In GPMC, ensure `Authenticated Users` or `Domain Computers` has Read and "Apply group policy" permissions.

## 8. Screenshots / Evidence
- `screenshots/07-gpmc-console.png` — *Pending lab execution: Capture GPMC console showing linked GPOs.*
- `screenshots/07-gpresult-output.png` — *Pending lab execution: Capture Command Prompt gpresult /r output.*

## 9. Practical Learning Outcome
Mastery in enterprise configuration management, GPO authoring, OU linking, and policy diagnostic troubleshooting.

## 10. Completion Status
Documented
