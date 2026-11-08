# Diagram: Enterprise Server-Client Network Topology with Active Directory

## 1. Overview
This topology illustrates the complete lab architecture utilized throughout this portfolio: a Windows Server 2022 Domain Controller (`SERVER01`) providing directory services, DNS, DHCP, and SMB file sharing to Windows 11 clients (`CLIENT01`) and Ubuntu Linux administration servers (`UBUNTU01`).

## 2. Mermaid Network Topology

```mermaid
graph TD
    WAN["WAN Uplink / Gateway<br/>192.168.100.1"] --- Switch["Enterprise Managed Switch<br/>Cisco SG350-24"]
    
    subgraph Infrastructure_Subnet ["Active Directory Infrastructure (lab.local - 192.168.100.0/24)"]
        Switch --- DC["SERVER01<br/>Windows Server 2022<br/>IP: 192.168.100.10<br/>Roles: AD DS, DNS, File Server"]
        Switch --- LinuxSRV["UBUNTU01<br/>Ubuntu 22.04 LTS<br/>IP: 192.168.100.30<br/>Services: SSH, Diagnostic Host"]
    end

    subgraph Client_Access ["Workstation & Peripheral Tier"]
        Switch --- PC01["CLIENT01<br/>Windows 11 Pro (Domain Joined)<br/>IP: 192.168.100.20<br/>User: LAB\user01"]
        Switch --- Printer["HP LaserJet Pro<br/>IP: 192.168.100.50<br/>Network Shared Printer"]
    end

    classDef server fill:#e8eaf6,stroke:#3f51b5,stroke-width:2px;
    classDef client fill:#e0f2f1,stroke:#00897b,stroke-width:2px;
    classDef net fill:#fff8e1,stroke:#ffa000,stroke-width:2px;

    class DC,LinuxSRV server;
    class PC01,Printer client;
    class Switch,WAN net;
```

## 3. Communication Protocols Illustrated
- **Authentication:** `CLIENT01` authenticates domain logins against `SERVER01` over Kerberos (Port 88) and LDAP (Port 389).
- **Name Resolution:** All workstations query `SERVER01` DNS on Port 53.
- **File Sharing:** Mapped drives access `\\SERVER01\Shares` over SMB on Port 445.
- **Printing:** Print jobs route to IP `192.168.100.50` over Standard TCP/IP Port 9100 (RAW).
- **Remote Shell:** Technicians administer `UBUNTU01` over SSH Port 22.
