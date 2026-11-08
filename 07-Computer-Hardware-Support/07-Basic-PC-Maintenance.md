# Practical Task: Preventive Hardware Maintenance and Cleaning Procedures

## 1. Objective
Execute professional preventive maintenance (PM) routines on desktop workstations, servers, and peripherals, including physical dust extraction, cable dressing, thermal audits, and maintenance logging.

## 2. Requirements
- Workstation PC and monitor
- Oil-free compressed air can or anti-static electric air blower
- 99% isopropyl alcohol, microfibre cloths, cotton swabs
- ESD wrist strap, maintenance logbook

## 3. Background
In enterprise offices and shipboard environments, dust, salt air, humidity, and vibration are silent hardware killers. Dust acts as a thermal blanket, clogging heatsinks and fans. This causes components to run hotter, increasing fan speeds, noise, and power consumption, leading to thermal throttling and premature capacitor failure.

Routine preventive maintenance scheduled every 3-6 months increases hardware lifespans by up to 50% and slashes unpredicted hardware failures.

## 4. Step-by-Step Procedure
1. **Pre-Maintenance Audit:** Check Event Viewer for existing errors. Record baseline idle CPU/GPU temperatures.
2. **Physical Disconnection:** Power down workstation. Label and disconnect power, network, monitor, and peripheral cables. Move chassis to a dedicated maintenance area.
3. **Chassis Dust Removal:**
   - Open side panel.
   - **CRITICAL:** When using compressed air on case and CPU fans, always hold the fan blades with a finger or pencil! Forcing fans to spin with high-pressure air acts as a generator, feeding reverse voltage back into the motherboard fan header and destroying circuitry!
   - Blow dust out of power supply vents, CPU heatsink fins, GPU fans, and chassis intake filters.
4. **Peripheral Sanitization:** Clean keyboard keycaps using compressed air and alcohol wipes. Wipe monitor screens with dry microfibre cloth (never spray liquids directly on screens).
5. **Cable Management & Reconnection:** Reinstall chassis cover. Neatly dress external cables using velcro ties to prevent tension and accidental trip hazards.
6. **Post-Maintenance Test:** Reconnect cables, power on, and verify quiet fan operation and reduced operating temperatures. Log work in maintenance checklist.

## 5. Preventive Maintenance Checklist Table
| Task | Frequency | Priority |
|---|---|---|
| Clean chassis dust filters | Monthly | High |
| Internal heatsink/fan dust blow-out | Quarterly | Critical |
| Verify fan rotation & bearings (no whining) | Quarterly | High |
| Thermal paste repasting | Bi-annually | Medium |
| External peripheral sanitization | Monthly | Medium |
| Tighten internal mounting screws & PCIe brackets | Annually | Low |

## 6. Expected Result
Workstation operates noticeably cooler, fans run quietly at lower RPMs, air channels are clear, and equipment records are documented.

## 7. Safety Precautions
- Never use a domestic household vacuum cleaner inside a PC chassis. Plastic vacuum nozzles generate thousands of volts of static electricity through friction!
- Wear safety glasses or dust mask when blowing out heavily clogged industrial or shipboard PCs.

## 8. Screenshots / Evidence
- `screenshots/07-cleaned-chassis-fans.png` — *Pending lab execution: Capture clean heatsink and fan assembly.*

## 9. Practical Learning Outcome
Mastery in enterprise preventive maintenance protocols, equipment preservation, and safe physical servicing.

## 10. Completion Status
Documented
