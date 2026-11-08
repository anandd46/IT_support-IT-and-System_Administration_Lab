# 01 — Windows Server 2022 Installation in VirtualBox

## 1. Objective

Install Windows Server 2022 (Standard — Desktop Experience) inside an Oracle VirtualBox virtual machine. This VM will become the primary domain controller (SERVER01) for the IT Support Lab.

---

## 2. Requirements

| Requirement | Detail |
|---|---|
| Host Machine RAM | 16 GB recommended (minimum 8 GB) |
| VirtualBox Version | 7.x or later |
| OS ISO | Windows Server 2022 Evaluation (from Microsoft) |
| VM RAM | 4 GB minimum (8 GB recommended) |
| VM Storage | 60 GB dynamically allocated VHD |
| VM CPUs | 2 vCPUs minimum |
| Network Adapters | Adapter 1: NAT (internet access) · Adapter 2: Host-Only (lab network) |

---

## 3. Background

Windows Server 2022 is Microsoft's current server operating system. It supports roles such as Active Directory Domain Services (AD DS), DNS Server, DHCP Server, and File and Storage Services — all of which are configured later in this lab.

Installing in VirtualBox allows full lab practice without dedicated server hardware. The VirtualBox **Host-Only** network adapter creates an isolated network that the server and client VMs can use to communicate with each other, independent of the host machine's internet connection.

> [!NOTE]
> The **Evaluation Edition** of Windows Server 2022 is free for 180 days from Microsoft. No license key is required during installation. It is fully functional for lab purposes.

---

## 4. Step-by-Step Procedure

### Step 1 — Download Windows Server 2022 Evaluation ISO

1. Open a browser and navigate to:
   ```
   https://www.microsoft.com/en-us/evalcenter/evaluate-windows-server-2022
   ```
2. Click **Download the ISO** and complete the registration form.
3. Select the **64-bit edition** ISO and download it (~5 GB).
4. Store the ISO in a known location (e.g. `D:\ISOs\WinServer2022.iso`).

---

### Step 2 — Create the VirtualBox VM

1. Open **Oracle VirtualBox Manager** and click **New**.
2. Configure the VM with the following settings:

   **Name and Operating System**
   | Field | Value |
   |---|---|
   | Name | SERVER01 |
   | Folder | (your preferred VM storage path) |
   | ISO Image | (skip for now — attach later) |
   | Type | Microsoft Windows |
   | Version | Windows 2022 (64-bit) |

3. Click **Next**.

   **Hardware**
   | Setting | Value |
   |---|---|
   | Base Memory | 4096 MB (4 GB) |
   | Processors | 2 CPUs |

4. Click **Next**.

   **Virtual Hard Disk**
   | Setting | Value |
   |---|---|
   | Disk Size | 60 GB |
   | Pre-allocate Full Size | No (dynamically allocated) |

5. Click **Finish**.

---

### Step 3 — Configure VM Settings

After the VM is created, open **Settings** for SERVER01 and apply the following:

**General > Advanced**
- Shared Clipboard: Bidirectional
- Drag'n'Drop: Bidirectional

**System > Motherboard**
- Boot Order: Optical first, then Hard Disk

**Display > Screen**
- Video Memory: 128 MB

**Network**
- Adapter 1: Enable — Attached to: **NAT** (for internet access during setup)
- Adapter 2: Enable — Attached to: **Host-Only Adapter** — select the VirtualBox Host-Only network (e.g. `vboxnet0`)

**Storage**
- Under the IDE Controller or SATA Controller, click the empty optical drive.
- Click the disc icon on the right → **Choose a disk file…**
- Browse to and select the Windows Server 2022 ISO file.

Click **OK** to save settings.

---

### Step 4 — Start the VM and Boot from ISO

1. Select SERVER01 in VirtualBox and click **Start**.
2. The VM will boot from the ISO. If it doesn't, verify the ISO is attached in Storage settings and that Optical Drive is first in the boot order.
3. The Windows Setup screen appears.

---

### Step 5 — Windows Server 2022 Setup Wizard

**Language, Time, and Keyboard**
- Language to install: English (United States)
- Time and currency format: (match your region)
- Keyboard: US

Click **Next**, then click **Install now**.

**Activate Windows**
- Click **I don't have a product key** (Evaluation edition requires no key).

**Select the Operating System**

> [!IMPORTANT]
> Select **Windows Server 2022 Standard Evaluation (Desktop Experience)**. The Desktop Experience option includes the full graphical interface (GUI). Without it, you get Server Core — command-line only, which is not suitable for this introductory lab.

| Option | Includes GUI? |
|---|---|
| Windows Server 2022 Standard Evaluation | No (Server Core) |
| **Windows Server 2022 Standard Evaluation (Desktop Experience)** | **Yes — select this** |
| Windows Server 2022 Datacenter Evaluation | No (Server Core) |
| Windows Server 2022 Datacenter Evaluation (Desktop Experience) | Yes |

Select **Windows Server 2022 Standard Evaluation (Desktop Experience)** and click **Next**.

**License Terms**
- Accept the license agreement and click **Next**.

**Installation Type**
- Select **Custom: Install Microsoft Server Operating System only (advanced)**.

> [!NOTE]
> "Upgrade" requires an existing Windows installation to upgrade from. Since this is a fresh VM, choose Custom.

---

### Step 6 — Partitioning the Virtual Disk

1. The unallocated virtual disk space is shown (approximately 60 GB).
2. Click **New** to create a new partition (or simply click **Next** to let Setup use the full disk automatically).
3. Setup creates the required system partition and the main OS partition automatically.
4. Select the largest partition (the main drive) and click **Next**.

Installation begins. The VM will copy files, expand them, install features, and restart automatically. This takes approximately 10–20 minutes depending on host hardware.

---

### Step 7 — Set the Administrator Password

After the first restart, Windows Server displays the **Customize settings** screen asking for the built-in Administrator password.

> [!CAUTION]
> Never use real or guessable passwords even in lab environments. Use a strong placeholder password that you document only in your secure lab notes — never in this repository. Example format only: `P@ssword2024!` — replace with your own strong password.

- Enter a password meeting complexity requirements (uppercase, lowercase, number, symbol, 8+ characters).
- Confirm the password.
- Click **Finish**.

---

### Step 8 — First Login

1. The lock screen appears. Press **Ctrl+Alt+Del** — in VirtualBox, use the **Input menu → Insert Ctrl+Alt+Del** option from the VirtualBox menu bar.
2. Log in as `Administrator` with the password set in Step 7.
3. The Windows Server 2022 desktop loads.
4. **Server Manager** opens automatically — this is expected and normal.

---

### Step 9 — Install VirtualBox Guest Additions

Guest Additions improve the VM experience: better screen resolution, shared clipboard, drag-and-drop, and improved mouse integration.

1. From the VirtualBox menu bar of the SERVER01 window, click **Devices → Insert Guest Additions CD image…**
2. Inside the VM, open **File Explorer**. The Guest Additions CD appears as a drive (usually D: or E:).
3. Double-click the drive, then double-click **VBoxWindowsAdditions-amd64.exe**.
4. Follow the installation wizard (accept all defaults).
5. When prompted, restart the VM.
6. After restart, the display will auto-resize and clipboard sharing will work.

---

### Step 10 — Take a VirtualBox Snapshot

Before making any further changes, take a snapshot of the clean installation. This provides a restore point.

1. In VirtualBox Manager, right-click **SERVER01** → **Snapshots** (or click the menu icon → Snapshots).
2. Click **Take** (or the camera icon).
3. Name: `Clean Install — Windows Server 2022`
4. Description: `Fresh installation, Guest Additions installed, no configuration applied yet.`
5. Click **OK**.

> [!TIP]
> Take snapshots before every major configuration change in the lab. If something goes wrong, you can restore in seconds instead of reinstalling.

---

## 5. Commands Used

The installation itself is GUI-based. The following commands are useful immediately after installation for verification:

```powershell
# Check OS version
winver

# Check computer name (defaults to a random name before renaming)
hostname

# Check IP configuration
ipconfig /all

# Verify system info
systeminfo | Select-String -Pattern "OS Name|OS Version|Total Physical Memory"
```

---

## 6. Expected Result

After completing this lab:

- VirtualBox VM named **SERVER01** is created and running.
- **Windows Server 2022 Standard (Desktop Experience)** is installed.
- Administrator password is set.
- VirtualBox Guest Additions are installed.
- A clean-install snapshot named `Clean Install — Windows Server 2022` exists.
- Server Manager opens automatically on login.

---

## 7. Troubleshooting

| Problem | Likely Cause | Solution |
|---|---|---|
| VM won't boot from ISO | ISO not attached, or boot order incorrect | Settings → Storage: verify ISO is attached. Settings → System → Boot Order: Optical first |
| "No bootable medium found" error | Same as above | Re-attach the ISO and restart |
| Black screen after starting VM | Insufficient video memory | Settings → Display → increase Video Memory to 128 MB |
| Installation freezes or is very slow | Insufficient host RAM | Close other applications. Increase VM RAM if host has capacity |
| VBoxWindowsAdditions fails to run | Windows hasn't activated optional features | Reboot the VM and try again; ensure no Windows updates are pending |
| Cannot press Ctrl+Alt+Del | Host OS intercepts the shortcut | Use VirtualBox menu: Input → Keyboard → Insert Ctrl+Alt+Del |
| "Windows cannot be installed on this disk" (GPT/MBR error) | Partition table mismatch | Delete all partitions on the virtual disk during setup and create fresh |
| Guest Additions CD doesn't appear | Guest Additions ISO not mounted | Devices → Insert Guest Additions CD image... again |

---

## 8. Screenshots / Evidence

> **Status: Pending** — Screenshots will be added during live lab execution.

Planned screenshots:
- VirtualBox VM settings (RAM, CPU, Storage, Network)
- Edition selection screen (Desktop Experience highlighted)
- Partitioning screen
- Administrator password screen
- First login — Server Manager visible
- VirtualBox Guest Additions installer
- Snapshot taken confirmation

Refer to the [screenshots README](screenshots/README.md) for the full list.

---

## 9. Learning Outcome

After completing this lab exercise, you will be able to:

- Download a Windows Server evaluation ISO from Microsoft.
- Create and configure a VirtualBox VM with appropriate hardware specifications.
- Install Windows Server 2022 Standard (Desktop Experience) from scratch.
- Choose the correct installation type (Desktop Experience vs. Server Core).
- Set a strong Administrator password.
- Install VirtualBox Guest Additions to improve VM usability.
- Use VirtualBox snapshots as a lab safety net.
- Identify and resolve common installation errors.

---

## 10. Completion Status

| Task | Status |
|---|---|
| Documentation written | ✅ Documented |
| VirtualBox VM created | ⬜ Pending |
| Windows Server 2022 installed | ⬜ Pending |
| Guest Additions installed | ⬜ Pending |
| Clean snapshot taken | ⬜ Pending |
| Screenshots added | ⬜ Pending |
