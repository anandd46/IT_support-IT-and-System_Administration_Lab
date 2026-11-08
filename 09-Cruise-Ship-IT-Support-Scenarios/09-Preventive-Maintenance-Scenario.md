# Scenario 09: Shipboard Scheduled Preventive Maintenance Window

## 1. Scenario Description
During a scheduled 4-hour port turnaround window in Barcelona while passengers are ashore, the IT department executes preventive maintenance on 12 administrative workstations in Hotel Operations and Guest Services.

## 2. Objectives
- Perform physical dust and lint extraction.
- Deploy approved monthly Windows cumulative updates.
- Verify S.M.A.R.T. health of all storage drives.
- Purge temporary files and audit available disk space.
- Verify peripheral connections and cable dressing.

## 3. Preparation & Change Control
1. **Advance Notice:** Issued notice to Hotel Director 48 hours prior.
2. **Tool Kit Prepared:** Anti-static air blower, microfibre cloths, isopropyl alcohol, diagnostic USB drives, asset checklist forms.
3. **Backup Completed:** Verified all user documents are synchronized to `SERVER01`.

## 4. Step-by-Step Execution per Workstation
1. **Hardware Inspection:** Power off PC. Blow out intake fans and power supply vents. Hold fan blades to prevent reverse voltage.
2. **Cable Dressing:** Re-seat power, network, and video cables. Secure with velcro ties away from passenger walkways.
3. **Operating System Maintenance:**
   - Boot PC. Run Windows Update service. Install approved cumulative update.
   - Run disk cleanup: `cleanmgr /sagerun:1`.
   - Run S.M.A.R.T. audit via PowerShell: `Get-PhysicalDisk`.
4. **Network & Peripheral Test:**
   - Test network speed and ping latency to `SERVER01`.
   - Print test page to local receipt/ticket printer.
5. **Documentation:** Sign maintenance checklist; attach asset status.

## 5. Summary Report
- Workstations serviced: 12 of 12.
- Failed components identified: 1 noisy chassis exhaust fan replaced; 1 frayed Cat6 patch cord replaced.
- Total updates applied: 12 cumulative patches.
- Operational readiness: 100% ready prior to passenger embarkation.

## 6. Completion Status
Documented
