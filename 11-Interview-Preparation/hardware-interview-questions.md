# Technical Interview Preparation: Computer Hardware and Peripherals

### Q1: What are the primary diagnostic steps when a desktop computer powers on, fans spin at 100%, but no video appears on the monitor?
**A:**
1. **Check Video Connection:** Verify monitor cable is plugged into the dedicated GPU port (lower chassis), not the motherboard I/O port.
2. **Inspect Motherboard Diagnostic Indicators:** Check the 4 debug LEDs (CPU, DRAM, VGA, BOOT) or listen for POST beep codes.
3. **Reseat RAM:** An unseated or faulty RAM stick is the #1 cause of black-screen fan-spin POST hangs. Remove all sticks, clean contacts, and test one stick in slot 2 (A2).
4. **Clear CMOS:** Remove the CR2032 battery and short CLRTC pins for 10 seconds to reset corrupted BIOS memory to factory defaults.
5. **Inspect Power Connections:** Verify that the 8-pin CPU power lead (EPS12V) and 24-pin ATX power connectors are firmly latched.

### Q2: How do you distinguish between a mechanical hard drive failure and a solid-state drive (SSD) failure?
**A:**
- **Mechanical HDD Failure:** Often presents physical and audible symptoms: rhythmic clicking ("click of death") caused by read/write heads scraping or seeking track 0, grinding noises, severe read/write slowdowns, CRC errors, and S.M.A.R.T. warnings showing high `Reallocated Sector Counts` or `Spin Retry Counts`.
- **SSD Failure:** Completely silent. Solid-state drives fail when their NAND flash controllers lock up or when write endurance (TBW) is exhausted. Symptoms include the drive suddenly dropping into permanent read-only mode, files disappearing, Blue Screens (`CRITICAL_PROCESS_DIED`), or the drive completely vanishing from UEFI/BIOS device lists without warning.

### Q3: Explain why thermal paste must be replaced on processors and what happens when it dries out.
**A:** Microscopic imperfections on the surface of the CPU integrated heat spreader (IHS) and heatsink base trap air pockets, which are poor thermal conductors. Thermal Interface Material (TIM) fills these microscopic voids to enable rapid heat conduction into the heatsink fins. Over 2 to 4 years, thermal paste dries out, hardens, and cracks. This causes CPU temperatures to spike rapidly above 90°C under load, prompting the CPU to engage thermal throttling (lowering clock frequencies down to ~800 MHz to protect silicon), causing severe lag, fan screaming, and abrupt thermal safety shutdowns.

### Q4: What is S.M.A.R.T. and how do you check it on Windows and Linux?
**A:** S.M.A.R.T. (Self-Monitoring, Analysis, and Reporting Technology) is a firmware monitoring subsystem built into HDDs and SSDs that tracks health indicators like temperature, reallocated bad sectors, power-on hours, read error rates, and remaining flash wear life.
- In Windows: Use CrystalDiskInfo for a GUI view, or run `Get-PhysicalDisk | Select-Object FriendlyName, HealthStatus, OperationalStatus` in PowerShell.
- In Linux: Install `smartmontools` and run `sudo smartctl -a /dev/sda`.

### Q5: What safety precautions must an IT technician observe before opening a computer case?
**A:**
1. **Power Disconnection:** Disconnect the AC power cord from the wall outlet or PSU.
2. **Capacitor Discharge:** Press and hold the power button for 10 seconds to drain residual charge from motherboard and power supply capacitors.
3. **Electrostatic Discharge (ESD) Protection:** Wear an ESD wrist strap connected to unpainted chassis metal or touch a grounded metallic surface before touching internal components.
4. **PSU Safety Warning:** **NEVER open the metal casing of a Power Supply Unit**. Internal capacitors retain lethal voltage charges for hours.
5. **Fan Caution:** Never spin internal fans at high speed with compressed air; hold blades stationary to prevent generating reverse electrical currents back into motherboard fan headers.

### Q6: What does the CMOS battery do and what are the symptoms of a dead CMOS battery?
**A:** The CMOS battery (typically a CR2032 3-volt lithium coin cell) powers the Real-Time Clock (RTC) chip and complementary metal-oxide-semiconductor (CMOS) memory when the computer is unplugged from AC power. Symptoms of a dead battery include: the computer clock resetting to midnight or year 2015/2000 every time AC power is lost; BIOS settings reverting to factory defaults; "CMOS Checksum Error" displaying at boot; and TLS/SSL certificate errors appearing in web browsers due to mismatched system dates.

### Q7: How would you troubleshoot a network laser printer that is printing faded, washed-out, or streaky pages?
**A:**
1. **Toner Level & Distribution:** Check toner percentage on LCD. If low, remove cartridge and gently rock it horizontally 5-6 times to redistribute settled powder.
2. **Imaging Drum Wear:** If streaking occurs at regular repeating intervals (e.g., every 75mm), inspect the cylindrical imaging drum for scratches, toner buildup, or light damage.
3. **Transfer Roller:** Check the foam transfer roller beneath the paper path for toner dust contamination.
4. **Fuser Assembly:** If toner smudges off the page when touched with a finger, the fuser unit is not reaching its required 180°C - 200°C melting temperature and must be replaced.
5. **Print Density Settings:** Check printer driver properties to ensure "Draft Mode" or "Toner Save Mode" is disabled.

### Q8: What does the command `mdsched.exe` do?
**A:** `mdsched.exe` launches the Windows Memory Diagnostic utility. It prompts the user to reboot the computer into a dedicated pre-boot diagnostic environment that executes rigorous read/write test patterns across physical RAM sticks to detect memory cell degradation, bit flips, and memory corruption.

### Q9: What is the difference between DisplayPort and HDMI cables?
**A:** Both carry digital high-definition video and audio. DisplayPort is a royalty-free VESA standard designed primarily for computer monitors and professional workstations; it supports higher bandwidth, higher refresh rates, screw/latch retention connectors, and multi-stream transport (MST) for daisy-chaining multiple monitors from a single port. HDMI is a consumer electronics standard designed for televisions and home theater equipment; it supports Consumer Electronics Control (CEC) and Audio Return Channel (ARC/eARC).

### Q10: How do you identify whether an unknown hardware peripheral has a missing driver, and how do you find the right driver?
**A:** Open Device Manager (`devmgmt.msc`). The device will display a yellow exclamation mark badge. Right-click the device > Properties > Details tab > Select `Hardware Ids` from the dropdown. Note the 4-digit hexadecimal **Vendor ID (`VEN_xxxx`)** and **Device ID (`DEV_xxxx`)**. Search these IDs on hardware database registries (e.g., `devicehunt.com` or `pci-ids.ucw.cz`) to pinpoint the exact chipset manufacturer and model, then download the official OEM driver directly from the manufacturer's support site.
