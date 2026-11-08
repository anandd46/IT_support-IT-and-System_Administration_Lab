# Diagram: Basic Local Area Network (LAN) Topology

## 1. Overview
This diagram illustrates a standard small office / departmental LAN connecting client workstations, an enterprise network printer, and a wireless access point to a Layer 2 switch with upstream gateway routing.

## 2. Mermaid LAN Diagram

```mermaid
graph TD
    Internet["Public Internet / ISP"] --- Modem["Modem / Fiber ONT"]
    Modem --- Router["Edge Router / Firewall<br/>192.168.1.1"]
    
    subgraph LAN_Segment ["Department Local Area Network (192.168.1.0/24)"]
        Router --- Switch["Core Layer 2 Switch<br/>24-Port Gigabit Ethernet"]
        
        Switch --- PC1["Workstation 01<br/>192.168.1.10"]
        Switch --- PC2["Workstation 02<br/>192.168.1.11"]
        Switch --- PC3["Workstation 03<br/>192.168.1.12"]
        Switch --- NetPrinter["Network Laser Printer<br/>192.168.1.50 (Static)"]
        Switch --- AP["Wireless Access Point<br/>192.168.1.20"]
        
        AP -.- Laptop["Mobile Laptop<br/>192.168.1.101 (DHCP)"]
        AP -.- Tablet["Inventory Tablet<br/>192.168.1.102 (DHCP)"]
    end

    classDef hardware fill:#e1f5fe,stroke:#0288d1,stroke-width:2px;
    classDef router fill:#fff3e0,stroke:#f57c00,stroke-width:2px;
    classDef client fill:#f1f8e9,stroke:#689f38,stroke-width:2px;

    class Switch,AP hardware;
    class Router,Modem router;
    class PC1,PC2,PC3,NetPrinter,Laptop,Tablet client;
```

## 3. Addressing Scheme Summary

| Node | Interface | IPv4 Address | Assignment | Purpose |
|---|---|---|---|---|
| Router | LAN Interface | `192.168.1.1` | Static | Default Gateway & DHCP |
| Switch | Management IP | `192.168.1.2` | Static | Switch Management |
| NetPrinter | Ethernet | `192.168.1.50` | Static / Reservation | Shared Office Printing |
| AP | Ethernet | `192.168.1.20` | Static | Wi-Fi Access Point |
| Workstations | Ethernet | `192.168.1.10 - .49` | DHCP / Static | Office Workstations |
| Mobile Wi-Fi | WLAN | `192.168.1.100 - .254` | Dynamic DHCP | User Laptops / Tablets |
