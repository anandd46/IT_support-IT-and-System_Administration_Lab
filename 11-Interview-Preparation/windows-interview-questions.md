# Technical Interview Preparation: Windows 11 & Windows Server

### Q1: What is the primary architectural difference between Windows 10 and Windows 11 regarding hardware requirements?
**A:** Windows 11 mandates strict hardware security requirements: a 64-bit multi-core processor (Intel 8th Gen+ / AMD Zen 2+), Trusted Platform Module (TPM) 2.0 for cryptographic key storage, UEFI firmware with Secure Boot enabled, 4 GB RAM, and 64 GB storage. These features allow Windows 11 to enforce hardware-enforced virtualization-based security (VBS) and hypervisor-protected code integrity (HVCI) out of the box.

### Q2: How would you troubleshoot a computer stuck in an automatic repair boot loop in Windows 11?
**A:** I would boot into the Windows Recovery Environment (WinRE), open Command Prompt, and inspect `C:\Windows\System32\Logfiles\Srt\SrtTrail.txt` to find the exact corrupt driver or file causing boot failure. Then, I would run `chkdsk C: /f /r` to fix file system corruption, followed by `sfc /scannow /offbootdir=C:\ /offwindir=C:\Windows` and DISM offline repair. If caused by a bad update, I would use `dism /image:C:\ /cleanup-image /revertpendingactions` or uninstall the latest quality update.

### Q3: What is the difference between Windows Server 2022 Standard and Datacenter editions?
**A:** Both editions share identical core server features, memory limits (48 TB), and socket capacities (up to 64 sockets). The primary difference is virtualization licensing rights: Standard edition includes licensing for only 2 Virtual Operating System Environments (VOSEs / VMs) or Hyper-V containers per licensed host, whereas Datacenter edition permits unlimited virtual machines, Shielded VMs, Storage Spaces Direct (S2D), and Software-Defined Networking (SDN).

### Q4: Explain the difference between NTFS permissions and Share permissions. If they conflict, which takes precedence?
**A:** Share permissions apply exclusively when accessing files over the network via SMB (`\\server\share`) and offer only Read, Change, and Full Control. NTFS permissions apply both across the network and to users logged in locally, offering granular rights (Read, Write, List, Modify, Full Control, and special permissions). When both are configured, the **most restrictive permission always wins**. Enterprise best practice is to set Share permissions to `Authenticated Users - Full Control` and enforce strict access boundaries using NTFS Access Control Lists (ACLs).

### Q5: What does Event ID 41 in the Windows System Event Log indicate?
**A:** Event ID 41 (Kernel-Power) indicates that the computer rebooted without cleanly shutting down first. It signifies that power was abruptly removed, the user held down the physical power button, or the kernel suffered a catastrophic bugcheck (BSOD). To isolate the cause, I inspect the BugcheckCode parameters in the event details and examine `%SystemRoot%\MEMORY.DMP` using WinDbg.

### Q6: How do you perform a complete manual reset of the Windows Update components?
**A:** Open an elevated command prompt and stop the four core update services: `net stop wuauserv`, `net stop cryptSvc`, `net stop bits`, and `net stop msiserver`. Next, rename the download cache and catalog directories: `ren C:\Windows\SoftwareDistribution SoftwareDistribution.old` and `ren C:\Windows\System32\catroot2 catroot2.old`. Finally, restart the four services. Windows recreates clean catalogs and resynchronizes fresh update manifests.

### Q7: What is the function of the DISM command and when should you run it relative to `sfc /scannow`?
**A:** `sfc /scannow` scans protected operating system files and replaces corrupt files using cached copies from the Windows Component Store (`WinSxS`). If the Component Store itself is corrupted, SFC will report that it found corrupted files but was unable to fix them. In that scenario, `dism /online /cleanup-image /restorehealth` must be executed to repair the WinSxS store by downloading pristine payload binaries from Windows Update or an install ISO, after which `sfc /scannow` is re-run successfully.

### Q8: What is the difference between Basic and Dynamic disks in Windows Disk Management?
**A:** Basic disks use standard partition tables (MBR or GPT) supporting primary partitions, extended partitions, and logical drives that can be accessed by all operating systems. Dynamic disks use a proprietary Logical Disk Manager (LDM) database supporting software-based multi-partition volumes across multiple physical drives, including Spanned, Striped (RAID 0), Mirrored (RAID 1), and RAID 5 volumes. Modern Windows administration deprecates Dynamic Disks in favor of Storage Spaces.

### Q9: How would you determine whether a system slowdown is caused by a CPU bottleneck, memory exhaustion, or storage I/O?
**A:** I launch Resource Monitor (`resmon`) or Task Manager. If CPU utilization is pinned at >90% or CPU Queue Length >2 per core, it is a compute bottleneck. If Memory Available is <500 MB and Hard Faults/sec is high, the system is exhausting physical RAM and thrashing swap. If Disk Active Time is pinned at 100% while Disk Queue Length is >2 and Disk Response Time exceeds 50ms, the storage drive is the primary bottleneck.

### Q10: How do you configure a persistent static IP and loopback DNS on Windows Server 2022 via PowerShell?
**A:** Run `New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress 192.168.100.10 -PrefixLength 24 -DefaultGateway 192.168.100.1`, followed by `Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses ("127.0.0.1")`.
