# Practical Task: Linux Package Management with APT and DPKG

## 1. Objective
Manage software lifecycle, update repositories, install packages, query installed binaries, and resolve broken dependencies in Ubuntu 22.04 LTS using the Advanced Package Tool (APT).

## 2. Requirements
- Ubuntu 22.04 LTS VM
- Sudo privileges
- Internet access (or local package mirror)

## 3. Background
Ubuntu Linux uses Debian `.deb` package architecture managed through APT. Repositories listed in `/etc/apt/sources.list` provide cryptographically signed packages. Keeping systems patched against known CVEs requires regular repository catalog updates and package upgrades.

## 4. Step-by-Step Procedure
1. **Update Repository Index:** Run `sudo apt update` to refresh package manifests from Ubuntu archives.
2. **Perform Safe Upgrade:** Run `sudo apt upgrade -y` to install latest bugfixes and security patches.
3. **Search for Packages:** Search for network diagnostic tools using `apt search nmap` or `apt search net-tools`.
4. **Install Essential IT Tools:** Install `net-tools`, `htop`, `curl`, `nmap`, and `traceroute`.
5. **Inspect Package Details:** Use `apt show htop` to view package maintainer, size, and dependencies.
6. **Query Installed Files:** Use `dpkg -L htop` to list every binary, configuration file, and man page installed by the package.
7. **Clean Unused Dependencies:** Execute `sudo apt autoremove -y` and `sudo apt clean` to free disk storage.

## 5. Commands Used

### Command 1: Refresh & Upgrade
```bash
sudo apt update && sudo apt upgrade -y
```
- **What it does:** Synchronizes local package index with remote repositories and upgrades installed packages without removing existing dependencies.

### Command 2: Install Essential IT Utilities
```bash
sudo apt install -y net-tools htop curl wget nmap traceroute
```
- **What it does:** Installs fundamental networking, system inspection, and web transfer binaries.

### Command 3: Query Installed Package Files via DPKG
```bash
dpkg -L net-tools
```
- **What it does:** Displays binary paths installed by the package (e.g., `/sbin/ifconfig`, `/sbin/netstat`, `/sbin/arp`).

### Command 4: Purge Package and Configurations
```bash
sudo apt purge -y htop
```
- **What it does:** Removes package binaries AND deletes configuration files associated with the application.

## 6. Expected Result
The Linux system is upgraded with latest security patches, equipped with essential support utilities, and freed of obsolete package caches.

## 7. Troubleshooting
- **Issue: "Could not get lock /var/lib/dpkg/lock-frontend":**
  - *Cause:* Automatic unattended updates or another APT process is running in the background.
  - *Solution:* Wait 2 minutes for unattended-upgrades to finish, or check holding PID: `sudo lsof /var/lib/dpkg/lock-frontend`.

## 8. Screenshots / Evidence
- `screenshots/05-apt-update-terminal.png` — *Pending lab execution: Capture apt update output.*
- `screenshots/05-installed-tools-verify.png` — *Pending lab execution: Capture dpkg verify output.*

## 9. Practical Learning Outcome
Ability to install, audit, maintain, and secure Linux server software packages.

## 10. Completion Status
Documented
