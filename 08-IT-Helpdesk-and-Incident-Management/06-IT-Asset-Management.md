# Practical Task: IT Asset Management and Hardware Inventory Control

## 1. Objective
Establish an IT Asset Management (ITAM) lifecycle registry, assign asset tags, record serial numbers, track warranty status, and manage secure electronic asset disposal.

## 2. Requirements
- IT Asset Inventory CSV (`templates/asset-inventory-template.csv`)
- Physical asset tags (barcode/QR labels)
- PowerShell inventory audit script

## 3. Background
IT Asset Management tracks the financial, contractual, and physical inventory of enterprise technology. The asset lifecycle consists of:
1. **Procurement:** Purchase orders, serial number registration, warranty agreements.
2. **Deployment:** Operating system imaging, domain join, user assignment, physical placement.
3. **Maintenance:** Hardware upgrades, repairs, location reassignments.
4. **Retirement & Disposal:** Cryptographic disk wipe (NIST 800-88 sanitization) to prevent data leaks before recycling.

## 4. Step-by-Step Procedure
1. **Asset Tagging:** Apply tamper-evident barcode label to chassis (e.g., `ASSET-001`).
2. **Record Metadata:** In the inventory registry, record Manufacturer, Model, Serial Number, Purchase Date, Warranty Expiry, Assigned User, Department, and MAC Address.
3. **Automated Inventory Audit:** Run PowerShell script to extract hardware serial and BIOS metadata directly from endpoints.
4. **Disposal / Sanitization:** For retired drives, execute secure zero-fill or ATA Secure Erase before physical disposal.

## 5. Commands Used

### Command 1: Extract Asset Hardware Metadata via PowerShell
```powershell
[PSCustomObject]@{
    AssetTag     = "ASSET-001"
    ComputerName = $env:COMPUTERNAME
    Manufacturer = (Get-CimInstance Win32_ComputerSystem).Manufacturer
    Model        = (Get-CimInstance Win32_ComputerSystem).Model
    SerialNumber = (Get-CimInstance Win32_Bios).SerialNumber
    MemoryGB     = [math]::Round((Get-CimInstance Win32_PhysicalMemory | Measure-Object Capacity -Sum).Sum / 1GB, 2)
    OS           = (Get-CimInstance Win32_OperatingSystem).Caption
    IPAddress    = (Get-CimInstance Win32_NetworkAdapterConfiguration -Filter "IPEnabled=True").IPAddress[0]
    MACAddress   = (Get-CimInstance Win32_NetworkAdapterConfiguration -Filter "IPEnabled=True").MACAddress[0]
} | Format-List
```

## 6. Expected Result
100% of IT hardware is accounted for, assigned to designated owners, tracked against active warranties, and inventoried in standard CSV format.

## 7. Completion Status
Documented
