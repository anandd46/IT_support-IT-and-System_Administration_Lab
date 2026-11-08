# 01 — Windows 11 System Installation

## Objective

Learn how to perform a clean installation of Windows 11, including understanding system requirements, creating bootable installation media, configuring BIOS/UEFI settings, and completing the Windows 11 setup wizard.

---

## Requirements

| Item | Detail |
|---|---|
| Hardware | A PC or virtual machine meeting Windows 11 minimum requirements |
| USB Drive | 8 GB or larger (all data will be erased) |
| Software | Rufus (free, open source) — [rufus.ie](https://rufus.ie) |
| ISO File | Windows 11 ISO from [microsoft.com/software-download/windows11](https://www.microsoft.com/software-download/windows11) |
| Internet | Required to download ISO and Rufus |
| Time | Approximately 30–60 minutes |

---

## Background

Windows 11 was released in October 2021 and introduced new hardware security requirements compared to Windows 10. The two most important requirements are **TPM 2.0** (Trusted Platform Module) and **Secure Boot**. These are firmware-level security features that protect the boot process from malware and rootkits.

A clean installation involves:
1. Downloading the official Windows 11 ISO image.
2. Writing (flashing) that ISO to a USB drive using a tool like Rufus.
3. Booting the target computer from the USB drive.
4. Following the Windows 11 setup wizard to install the OS.

A clean install wipes the target drive. Always back up data first.

---

## Windows 11 System Requirements

Before installing Windows 11, verify that the target hardware meets all minimum requirements. Installing on non-compliant hardware is unsupported and may prevent future updates.

| Requirement | Minimum Specification |
|---|---|
| **Processor** | 1 GHz or faster, 64-bit, 2 or more cores, on a compatible 64-bit processor |
| **RAM** | 4 GB minimum |
| **Storage** | 64 GB or more |
| **System Firmware** | UEFI, Secure Boot capable |
| **TPM** | Trusted Platform Module (TPM) version 2.0 |
| **Graphics Card** | DirectX 12 compatible, WDDM 2.0 driver |
| **Display** | 720p or higher, 9" or larger diagonal, 8 bits per colour channel |
| **Internet** | Required for Windows 11 Home initial setup (Microsoft account) |

### Checking TPM and Secure Boot Before Installation

Before starting, confirm the target machine supports TPM 2.0 and Secure Boot:

**Check TPM status (on existing Windows installation):**

```
Win + R → tpm.msc
```

This opens the TPM Management console. If TPM 2.0 is present and enabled, it will show "The TPM is ready for use" and display the specification version as 2.0.

**Check Secure Boot status:**

```powershell
Confirm-SecureBootUEFI
```

Returns `True` if Secure Boot is enabled.

**Using System Information:**

```
Win + R → msinfo32
```

Look for:
- **BIOS Mode**: Should read `UEFI` (not Legacy)
- **Secure Boot State**: Should read `On`
- **PCR7 Configuration**: Indicates TPM binding

---

## Step-by-Step Procedure

### Step 1 — Download the Windows 11 ISO

1. Navigate to the official Microsoft download page:
   `https://www.microsoft.com/software-download/windows11`
2. Under **Download Windows 11 Disk Image (ISO)**, select **Windows 11 (multi-edition ISO)**.
3. Choose your language and click **Confirm**.
4. Click **64-bit Download** to download the ISO file.
5. The file is approximately 5–6 GB. Wait for the download to complete.

> [!IMPORTANT]
> Only download Windows 11 from Microsoft's official website. Third-party ISOs may contain malware or be modified.

---

### Step 2 — Download and Install Rufus

1. Navigate to `https://rufus.ie`.
2. Download the latest version of **Rufus** (portable version does not require installation).
3. Double-click the downloaded `.exe` file to launch Rufus.
4. If prompted by User Account Control, click **Yes**.

---

### Step 3 — Create Bootable USB with Rufus

1. Insert your USB drive (8 GB minimum). **All data on the USB will be erased.**
2. In Rufus:
   - **Device**: Select your USB drive from the dropdown.
   - **Boot selection**: Click **SELECT** and browse to the Windows 11 ISO file you downloaded.
   - **Image option**: Select **Standard Windows installation**.
   - **Partition scheme**: Select **GPT** (required for UEFI systems with Windows 11).
   - **Target system**: Select **UEFI (non-CSM)**.
   - **File system**: NTFS is selected automatically.
   - **Volume label**: Can be left as default or renamed (e.g., `WIN11_INSTALL`).
3. Click **START**.
4. If prompted about Windows User Experience customisations, review options and click **OK**.
5. Confirm the warning that all data on the USB will be destroyed. Click **OK**.
6. Wait for Rufus to complete (progress bar turns green and shows "READY").
7. Click **CLOSE** when finished.

> [!NOTE]
> GPT partition scheme is required for Windows 11 on UEFI systems. MBR is for older Legacy BIOS systems. Using GPT with UEFI is the modern and correct choice.

---

### Step 4 — Configure BIOS/UEFI for Boot Order

1. Shut down the target computer.
2. Insert the bootable USB drive.
3. Power on the computer and immediately press the BIOS/UEFI entry key repeatedly.

   Common BIOS entry keys by manufacturer:

   | Manufacturer | Key |
   |---|---|
   | Dell | F2 or F12 |
   | HP | F10 or Esc |
   | Lenovo | F1 or F2 |
   | ASUS | Del or F2 |
   | Acer | Del or F2 |
   | MSI | Del |

4. Inside BIOS/UEFI:
   - Navigate to the **Boot** menu or **Boot Order** section.
   - Set **USB Drive** or **Removable Device** as the first boot device.
   - Ensure **Secure Boot** is **Enabled** (usually under Security or Boot tab).
   - Ensure **Boot Mode** is set to **UEFI** (not Legacy or CSM).
   - Ensure **TPM** is **Enabled** (usually under Security tab; may appear as PTT on Intel systems or fTPM on AMD systems).
5. Press **F10** (or the Save & Exit option shown on screen) to save settings and reboot.

> [!IMPORTANT]
> If you must use Legacy/CSM mode (older hardware), Windows 11 will not meet its official requirements. This guide assumes a modern UEFI system.

---

### Step 5 — Boot from USB and Start Installation

1. The computer restarts and should boot from the USB drive.
2. If prompted with "Press any key to boot from USB...", press any key quickly.
3. The Windows 11 setup screen appears with a Windows logo and loading spinner.
4. After loading, the **Windows Setup** screen appears.

---

### Step 6 — Windows 11 Installation Wizard

**Language and Region:**
1. Select your **Language to install** (e.g., English (United Kingdom)).
2. Select your **Time and currency format**.
3. Select your **Keyboard or input method**.
4. Click **Next**.
5. Click **Install Now**.

**Product Key:**
1. If you have a product key, enter it. Otherwise click **I don't have a product key** to continue (activation can be done later).

**Choose Windows Edition:**
1. Select the edition you are licensed for (e.g., Windows 11 Home, Windows 11 Pro).
2. Click **Next**.
3. Accept the licence terms checkbox. Click **Next**.

**Installation Type:**
1. Select **Custom: Install Windows only (advanced)** for a clean installation.
   - Do NOT select "Upgrade" if performing a fresh clean install.

**Partition Selection:**
1. The installer shows all available disks and partitions.
2. If installing on a new blank drive: select the unallocated space and click **Next** — the installer will automatically create the required partitions (EFI System Partition, Microsoft Reserved, and Windows partition).
3. If installing on an existing drive: delete all existing partitions on the target drive (select each and click Delete), then select the resulting unallocated space and click **Next**.

> [!CAUTION]
> Deleting partitions permanently removes all data on those partitions. Ensure the correct disk is selected, especially in systems with multiple drives.

**Installation Progress:**
1. Windows copies files, installs features, installs updates, and completes setup.
2. The computer will restart several times. Leave the USB drive inserted until after the first restart into Windows setup (the out-of-box experience), then remove it when prompted, or leave it — the system will detect the Windows installation on the HDD and boot from it.

---

### Step 7 — Out-of-Box Experience (OOBE) Setup

After installation completes, Windows 11 runs the OOBE setup wizard.

**Country/Region:**
- Select your country and click **Yes**.

**Keyboard Layout:**
- Select your keyboard layout. Click **Yes**. Add a second layout if needed, or skip.

**Network Connection:**
- Connect to Wi-Fi or Ethernet. Windows 11 Home requires internet for initial setup (to sign in to a Microsoft account).
- For offline setup on Windows 11 Pro: press **Shift + F10** to open Command Prompt and type:
  ```
  oobe\bypassnro
  ```
  The system will restart and offer a "I don't have internet" option.

**Microsoft Account:**
- Sign in with a Microsoft account (recommended) or set up a local account (Windows 11 Pro/Education allows this directly; Home requires the bypass above).

**PIN Setup:**
- Set a Windows Hello PIN for fast and secure sign-in.

**Privacy Settings:**
- Review each setting carefully:
  - **Location**: Enable if needed for location-aware apps, disable for maximum privacy.
  - **Find my device**: Enable if on a laptop that may be lost.
  - **Diagnostic data**: Basic (Required) sends minimal telemetry. Full (Optional) sends more.
  - **Tailored experiences**: Disable to prevent ads based on diagnostic data.
  - **Advertising ID**: Disable to prevent per-app targeted advertising.
- Click **Accept** after reviewing all settings.

**Customisation Questions:**
- Windows may ask how you plan to use the device (personal, work, gaming, creativity). Your selection pre-installs related apps. Choose as appropriate or skip.

**OneDrive:**
- Choose whether to back up files to OneDrive automatically. For a lab environment, this can be skipped.

**Setup Complete:**
- Windows 11 completes personalisation and loads the desktop for the first time.

---

## Commands Used

| Command | Purpose |
|---|---|
| `tpm.msc` | Opens TPM Management console |
| `msinfo32` | Opens System Information tool |
| `Confirm-SecureBootUEFI` | PowerShell cmdlet to check Secure Boot state |
| `oobe\bypassnro` | Bypasses network requirement during OOBE (Windows 11 Pro) |

---

## Expected Result

After completing all steps:
- Windows 11 is installed cleanly on the target drive.
- The system boots directly into Windows 11 desktop.
- The partition style is GPT.
- Secure Boot is active.
- TPM 2.0 is confirmed as active.
- The system passes Windows 11 compatibility check.

---

## Troubleshooting

### Error: "This PC can't run Windows 11" — TPM Not Found

**Cause:** TPM 2.0 is disabled in BIOS or not present.

**Solution:**
1. Restart and enter BIOS/UEFI.
2. Navigate to Security settings.
3. Enable **TPM**, **PTT** (Intel Platform Trust Technology), or **fTPM** (AMD Firmware TPM).
4. Save and retry installation.

---

### Error: "This PC can't run Windows 11" — Secure Boot Disabled

**Cause:** Secure Boot is turned off in BIOS/UEFI.

**Solution:**
1. Enter BIOS/UEFI.
2. Navigate to Boot settings.
3. Enable **Secure Boot**.
4. If the option is greyed out, ensure the system is in **UEFI mode** (not Legacy/CSM mode).
5. Save changes and retry.

---

### Error: "This PC can't run Windows 11" — CPU Not Compatible

**Cause:** The processor is not on Microsoft's supported CPU list (e.g., older Intel 7th-gen or early AMD Ryzen).

**Solution:**
- Check the Microsoft supported CPU list at:
  `https://learn.microsoft.com/windows-hardware/design/minimum/supported/windows-11-supported-intel-processors`
- If the CPU is not supported, the PC cannot officially run Windows 11. Consider upgrading hardware or remaining on Windows 10 (supported until October 2025).

---

### USB Drive Not Detected as Bootable

**Cause:** USB was created with wrong partition scheme (MBR instead of GPT), or Secure Boot prevents booting unsigned media.

**Solution:**
1. Recreate the USB with Rufus using **GPT** partition scheme and **UEFI (non-CSM)** target.
2. If Secure Boot causes issues with the USB, temporarily disable it, install Windows, then re-enable it. (Windows 11 itself supports Secure Boot after installation.)

---

### Setup Freezes During Installation

**Cause:** Corrupted ISO file, bad USB drive, or hardware incompatibility.

**Solution:**
1. Verify the ISO file integrity (SHA-256 checksum available on Microsoft's download page).
2. Try a different USB drive.
3. Try a different USB port (prefer USB 2.0 ports for compatibility during setup).
4. Check RAM with Windows Memory Diagnostic (`mdsched.exe`) if crashes persist.

---

## Screenshots / Evidence

> 📷 **Capture these screenshots to document your work:**

| # | Screenshot to Capture | Filename |
|---|---|---|
| 1 | Rufus configuration before clicking START | `rufus-config.png` |
| 2 | BIOS/UEFI boot order screen | `bios-boot-order.png` |
| 3 | Windows Setup — Language selection screen | `setup-language.png` |
| 4 | Partition selection screen (showing GPT partitions or unallocated space) | `setup-partition.png` |
| 5 | Installation progress screen | `setup-progress.png` |
| 6 | Windows 11 desktop after first login | `win11-first-desktop.png` |
| 7 | msinfo32 showing BIOS Mode: UEFI and Secure Boot: On | `msinfo32-secure-boot.png` |
| 8 | tpm.msc showing TPM 2.0 is ready | `tpm-ready.png` |

Save all screenshots to the `screenshots/` folder in this module.

---

## Learning Outcome

After completing this exercise, you will be able to:
- Explain the hardware security requirements unique to Windows 11.
- Create a bootable Windows 11 USB drive using Rufus.
- Configure BIOS/UEFI settings for a UEFI boot with Secure Boot enabled.
- Perform a clean Windows 11 installation with correct partition setup.
- Complete the OOBE setup and configure privacy settings appropriately.
- Diagnose and resolve common installation errors related to TPM and Secure Boot.

---

## Completion Status

| Task | Status |
|---|---|
| Documentation written | ✅ Documented |
| Lab exercise performed | ⬜ Pending |
| Screenshots captured | ⬜ Pending |
| Skills demonstrated | ⬜ Pending |
