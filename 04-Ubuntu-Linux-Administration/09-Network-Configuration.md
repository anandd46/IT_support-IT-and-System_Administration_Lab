# Practical Task: Linux Network Configuration and Netplan Administration

## 1. Objective
Configure static and DHCP IPv4 network parameters using Ubuntu's modern Netplan YAML architecture, manage routing tables, test DNS resolvers, and troubleshoot interfaces.

## 2. Requirements
- Ubuntu 22.04 LTS VM
- Sudo administrative access
- Netplan configuration directory (`/etc/netplan/`)

## 3. Background
Ubuntu modern networking is managed by **Netplan**, a declarative YAML network abstraction renderer. Netplan parses YAML files in `/etc/netplan/*.yaml` and applies settings through backend renderers: `systemd-networkd` (servers) or `NetworkManager` (desktops).

Legacy commands like `ifconfig` are superseded by the modern `ip` utility suite (`iproute2`).

## 4. Step-by-Step Procedure
1. **Inspect Active Interfaces:** Run `ip addr show` to identify physical interface names (e.g., `eth0`, `enp0s3`).
2. **Review Routing Table:** Run `ip route show` to identify default gateway.
3. **Backup Netplan Configuration:** Copy existing YAML in `/etc/netplan/` to a backup file.
4. **Configure Static IP via YAML:** Edit `/etc/netplan/01-netcfg.yaml` with static IP parameters.
5. **Test Configuration Safely:** Run `sudo netplan try` (provides a 120-second fallback if connection breaks).
6. **Apply Netplan:** Execute `sudo netplan apply`.
7. **Verify Network State:** Run `ip addr` and test external ping and DNS resolution.

## 5. Commands Used

### Command 1: Modern IP Interface Inspection
```bash
ip addr show
ip -brief address
```
- **What it does:** Displays MAC addresses, IPv4/IPv6 addresses, MTU, and interface up/down status.

### Command 2: Modern Routing Inspection
```bash
ip route show
```
- **Expected Output:**
```text
default via 192.168.100.1 dev enp0s3 proto static
192.168.100.0/24 dev enp0s3 proto kernel scope link src 192.168.100.30
```

### Command 3: Sample Netplan Static IP Configuration
```yaml
# /etc/netplan/01-netcfg.yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    enp0s3:
      dhcp4: no
      addresses:
        - 192.168.100.30/24
      routes:
        - to: default
          via: 192.168.100.1
      nameservers:
        addresses: [192.168.100.10, 8.8.8.8]
```

### Command 4: Test & Apply Netplan
```bash
sudo netplan try
sudo netplan apply
```
- **What it does:** Validates YAML indentation and syntax, tests live connectivity, and compiles systemd-networkd configuration files.

## 6. Expected Result
The Ubuntu system operates with a static IP configuration defined in clean YAML, resolves DNS via `SERVER01`, and maintains default gateway routing.

## 7. Troubleshooting
- **Issue: `netplan apply` returns "Invalid YAML at line X column Y":**
  - *Cause:* YAML forbids tab characters; indentation must strictly use spaces (typically 2 spaces per level).
  - *Solution:* Open file in nano, replace tabs with spaces, and re-run.

## 8. Screenshots / Evidence
- `screenshots/09-ip-addr-terminal.png` — *Pending lab execution: Capture ip addr show output.*
- `screenshots/09-netplan-yaml-config.png` — *Pending lab execution: Capture netplan configuration file.*

## 9. Practical Learning Outcome
Ability to administer modern Linux network stacks using Netplan YAML, troubleshoot IP routing, and configure static addressing.

## 10. Completion Status
Documented
