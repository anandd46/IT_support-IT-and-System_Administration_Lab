# 01 — Ubuntu 22.04 LTS Installation in VirtualBox

**Status:** Documented  
**Environment:** Oracle VirtualBox 7.x on Windows host  
**Goal:** Install Ubuntu 22.04 LTS in a virtual machine for use as a Linux administration lab environment.

---

## Section 1 — Download Ubuntu 22.04 LTS ISO

Ubuntu 22.04 LTS (Long Term Support) is the recommended version for lab and production use. It is supported with security updates until April 2027 (standard) and April 2032 (extended).

### Steps

1. Open a web browser and navigate to: **https://ubuntu.com/download/desktop**
2. Click **Download 22.04.x LTS** (the LTS release, not the latest non-LTS).
3. Save the `.iso` file to a known location, e.g. `C:\ISOs\ubuntu-22.04.x-desktop-amd64.iso`.
4. Verify the file size (approximately 4–5 GB). If the download is significantly smaller, it may be corrupt — re-download.

> [!TIP]
> You can also download the **server ISO** from https://ubuntu.com/download/server for a headless (no-GUI) Ubuntu install, which uses fewer resources. For this lab the **desktop ISO** is used to provide a GUI for learning.

---

## Section 2 — Create the Virtual Machine in VirtualBox

### Minimum and Recommended VM Specifications

| Setting | Minimum | Recommended |
|---|---|---|
| RAM | 2 GB (2048 MB) | 4 GB (4096 MB) |
| CPUs | 1 | 2 |
| Disk | 20 GB | 25 GB |
| Video Memory | 64 MB | 128 MB |
| Network | NAT | NAT (or Bridged for LAN access) |

### Steps

1. Open **Oracle VirtualBox**.
2. Click **New**.
3. Enter the following:
   - **Name:** `UBUNTU01`
   - **Folder:** your preferred VM storage location
   - **ISO Image:** select the downloaded Ubuntu ISO
   - **Type:** Linux
   - **Version:** Ubuntu (64-bit)
4. Click **Next**.
5. Set **Base Memory** to `4096 MB` (4 GB) if your host has 16 GB RAM. Use 2048 MB if RAM is limited.
6. Set **Processors** to `2`.
7. Click **Next**.
8. Select **Create a Virtual Hard Disk Now**.
9. Set disk size to `25 GB`.
10. Click **Next**, then **Finish**.

### Network Adapter

1. With the VM selected, click **Settings → Network**.
2. Adapter 1 should be set to **NAT** (default). This allows the VM to access the internet through your host.
3. For lab scenarios that require the VM to be reachable from other VMs or the host, use **Host-Only Adapter** as a second adapter.

### Video Settings

1. Go to **Settings → Display**.
2. Set **Video Memory** to `128 MB`.
3. Enable **3D Acceleration** if available.

---

## Section 3 — Mount the ISO and Start the VM

1. In VirtualBox, go to **Settings → Storage**.
2. Under the **Controller: IDE** section, click the empty disc icon.
3. On the right, click the disc icon next to **Optical Drive** and choose **Choose a disk file…**
4. Browse to and select your Ubuntu ISO.
5. Click **OK**.
6. Click the **Start** (green arrow) button to boot the VM.

> [!NOTE]
> The first time you boot, the VM will start from the ISO rather than the (empty) virtual hard disk. This is correct — you will install Ubuntu onto the virtual disk during setup.

---

## Section 4 — Ubuntu Installation Wizard

After the VM boots from the ISO, Ubuntu loads its live environment. You will see the following screens:

### Try or Install Ubuntu

- Select **Install Ubuntu** to proceed directly to installation.
- Optionally select **Try Ubuntu** to explore the live environment without installing — no changes are made to the disk.

### Language Selection

- Select your preferred language (e.g., **English**) and click **Continue**.

### Keyboard Layout

- Select your keyboard layout (e.g., **English (UK)** or **English (US)**).
- Use the **Detect Keyboard Layout** button if unsure.
- Click **Continue**.

### Wireless / Network (optional)

- If a wired network is available through NAT, it will connect automatically.
- Skip Wi-Fi (not applicable in a VM with NAT).

### Updates and Other Software

- Select **Normal installation** (includes browser and utilities) or **Minimal installation** (bare minimum).
- Tick **Download updates while installing Ubuntu** if you have an internet connection.
- Click **Continue**.

---

## Section 5 — Installation Type

> [!IMPORTANT]
> You are installing inside a virtual machine. The "disk" that Ubuntu sees is the virtual hard disk VirtualBox created — it is completely isolated from your physical host drive. It is **safe** to erase and use the entire virtual disk.

1. On the **Installation type** screen, select **Erase disk and install Ubuntu**.
2. Click **Install Now**.
3. A confirmation dialog appears: *"Write the changes to disks?"* — click **Continue**.

> [!CAUTION]
> Never select "Erase disk" on a physical machine unless you intend to wipe it. Inside a VirtualBox VM this is safe — but always confirm you are in the VM window, not on the host.

---

## Section 6 — Region and Timezone

1. The map will show your detected location.
2. Click your region on the map, or type your city in the box (e.g., **London**, **New York**, **Sydney**).
3. Click **Continue**.

---

## Section 7 — Creating the User Account

Ubuntu requires you to create an initial user account during installation.

| Field | Example Value | Notes |
|---|---|---|
| Your name | Lab Admin | Display name only |
| Computer's name | UBUNTU01 | Hostname |
| Username | labadmin | Used to log in — example only |
| Password | (choose a strong password) | Do not use real credentials |
| Confirm password | (repeat) | Must match |

> [!CAUTION]
> Do not use real or production passwords in lab documentation. The username `labadmin` is a placeholder example. Choose a password you will remember for the VM but that is not reused elsewhere.

Options:
- Select **Log in automatically** for lab convenience.
- Select **Require my password to log in** for a more realistic security posture.

Click **Continue**.

---

## Section 8 — Completing Installation

1. Ubuntu will now copy files and install. This typically takes 10–20 minutes depending on host hardware.
2. When installation is complete, click **Restart Now**.
3. When prompted, press **Enter** to eject the ISO (VirtualBox usually detaches it automatically).
4. The VM will reboot into the installed Ubuntu system.
5. Log in with the username and password you created.

---

## Section 9 — Installing VirtualBox Guest Additions

Guest Additions improve the VM experience significantly:
- Shared clipboard between host and VM
- Automatic screen resizing
- Shared folders between host and VM
- Smoother mouse integration

### Steps

1. Boot into Ubuntu and log in.
2. Open a terminal: press **Ctrl+Alt+T**.
3. Update package lists and install prerequisites:

```bash
sudo apt update
sudo apt install -y build-essential dkms linux-headers-$(uname -r)
```

4. In the VirtualBox menu bar: **Devices → Insert Guest Additions CD image…**
5. Ubuntu will mount the CD. If a dialog appears asking to run the software, click **Run**.
6. If not, run manually from the terminal:

```bash
sudo /media/$USER/VBox_GAs_*/VBoxLinuxAdditions.run
```

7. After installation, reboot:

```bash
sudo reboot
```

8. After rebooting, test:
   - Try resizing the VM window — the resolution should automatically adjust.
   - Try copying text from the host and pasting into the VM (requires enabling: **Devices → Shared Clipboard → Bidirectional**).

---

## Section 10 — Take a VirtualBox Snapshot

After completing the clean installation, take a snapshot so you can restore to this state if something goes wrong during lab exercises.

### Steps

1. In VirtualBox with the VM running (or powered off for a cleaner snapshot):
2. Go to **Machine → Take Snapshot…** in the menu bar.
3. Enter:
   - **Snapshot Name:** `Clean Install - Ubuntu 22.04`
   - **Description:** `Fresh Ubuntu 22.04 LTS install with Guest Additions. No lab changes yet.`
4. Click **OK**.

> [!TIP]
> Take a new snapshot before each major lab exercise. If a misconfiguration breaks the VM, restore the snapshot instead of reinstalling from scratch. Right-click a snapshot and choose **Restore** to roll back.

---

## Common Issues and Fixes

### VM Screen Is Too Small / Resolution Does Not Change

- Ensure VirtualBox Guest Additions are installed (Section 9).
- In the VM: **Settings → Display → Screen** — make sure **Video Memory** is 128 MB.
- In VirtualBox: **View → Virtual Screen 1 → Scale to 150%** as a workaround.

### Copy and Paste Not Working Between Host and VM

- **Devices → Shared Clipboard → Bidirectional**
- **Devices → Drag and Drop → Bidirectional**
- If still not working, reinstall Guest Additions.

### Network Not Working Inside the VM

- Verify the network adapter is set to **NAT** in VM Settings → Network.
- Inside Ubuntu, open Terminal and run:
  ```bash
  ip addr show
  ping -c 4 8.8.8.8
  ```
- If no IP is shown, try: `sudo dhclient` to request an IP from VirtualBox's internal DHCP.

### Ubuntu Installer Freezes or Crashes

- Increase RAM to 4096 MB.
- Disable 3D acceleration in VM display settings.
- Try re-downloading the ISO and verifying the checksum.

### "Boot device not found" After Installation

- The VM booted from the ISO again instead of the virtual hard disk.
- In VirtualBox: **Settings → Storage** — remove the ISO from the optical drive, then reboot.

---

*Module: 04-Ubuntu-Linux-Administration | File: 01-Ubuntu-Installation.md | Status: Documented*
