# Diagram: Simulated Cruise Ship IT Network Architecture

## 1. Overview
This diagram depicts a realistic, high-level maritime network topology showing physical locations, satellite uplinks, core server room components, and strict VLAN network segmentation.

> **Disclaimer:** This diagram is a hypothetical simulation designed for educational demonstration. Actual vessel systems adhere to proprietary safety and classification society (DNV/Lloyd's Register) standards.

---

## 2. Mermaid Simulated Shipboard Topology

```mermaid
graph TD
    Satellite["Dual VSAT Satellite Antennas<br/>(C-Band / Ku-Band / LEO Starlink)"] --- Modems["Satellite Modem Bank<br/>& Bandwidth Controller"]
    Modems --- CoreRouter["Core Shipboard Firewall & Router<br/>(Cisco / Fortinet Cluster)"]
    
    subgraph Server_Room ["IT Server Room (Deck 2 - Climate Controlled)"]
        CoreRouter --- CoreSwitch["Dual Core Backbone Switches<br/>(10 Gbps Fiber Ring)"]
        CoreSwitch --- UPS["Dual Online UPS Systems<br/>(Battery Backup + Generator)"]
        CoreSwitch --- Servers["Shipboard Enterprise Servers<br/>- Domain Controller (AD DS / DNS / DHCP)<br/>- Property Management System (PMS)<br/>- Point of Sale Server (POS)<br/>- File & Backup Servers"]
    end

    subgraph Operations_Tier ["Vessel Operations (Strictly Isolated VLANs)"]
        CoreSwitch ===|Fiber Trunk| BridgeSwitch["Bridge Deck Switch (VLAN 10)<br/>Navigation & Radar Terminals"]
        CoreSwitch ===|Fiber Trunk| EngineSwitch["Engine Control Switch (VLAN 50)<br/>Automation & Monitoring Terminals"]
        CoreSwitch ===|Fiber Trunk| SafetySwitch["Safety Center Switch (VLAN 15)<br/>CCTV & Access Control"]
    end

    subgraph Hotel_Admin_Tier ["Administration & Crew (VLAN 20 & 30)"]
        CoreSwitch --- AdminSwitch["Administration Switch (VLAN 20)<br/>Purser Desk, HR, Finance, F&B"]
        AdminSwitch --- AdminPCs["Office Workstations & Mapped Shares"]
        AdminSwitch --- DeptPrinters["Departmental Network Printers"]
        CoreSwitch --- CrewSwitch["Crew Recreation Switch (VLAN 30)"]
        CrewSwitch --- CrewAP["Crew Wi-Fi Access Points"]
    end

    subgraph Guest_Tier ["Guest Services Tier (Logically Isolated VLAN 40)"]
        CoreSwitch --- GuestSwitch["Guest Distribution Switches (VLAN 40)<br/>Decks 4 through 12"]
        GuestSwitch --- GuestAPs["Public & Cabin Wi-Fi 6 APs<br/>Captive Portal & Bandwidth Throttled"]
    end

    classDef core fill:#e8eaf6,stroke:#3f51b5,stroke-width:2px;
    classDef ops fill:#ffebee,stroke:#c62828,stroke-width:2px;
    classDef hotel fill:#e0f2f1,stroke:#00695c,stroke-width:2px;
    classDef guest fill:#fff8e1,stroke:#f57f17,stroke-width:2px;

    class CoreRouter,CoreSwitch,Servers,UPS,Modems,Satellite core;
    class BridgeSwitch,EngineSwitch,SafetySwitch ops;
    class AdminSwitch,AdminPCs,DeptPrinters,CrewSwitch,CrewAP hotel;
    class GuestSwitch,GuestAPs guest;
```

---

## 3. Key Maritime Network Segmentation Concepts
1. **Logical Isolation:** Guest traffic (VLAN 40) is strictly firewalled from Administration (VLAN 20) and Navigation Operations (VLAN 10). Guests cannot reach internal servers under any circumstances.
2. **Quality of Service (QoS):** Satellite bandwidth is dynamically allocated. Bridge safety communications and financial PMS credit card clearing have priority #1. Guest streaming is throttled during satellite bandwidth congestion at sea.
3. **High Availability:** Core switches utilize redundant fiber uplinks and dual power supplies connected to isolated UPS phases backed by the ship's emergency diesel generator.
