# Practical Task: Microsoft 365 Desktop Applications and Cloud Sync Support

## 1. Objective
Diagnose and resolve common Microsoft 365 desktop application incidents, including Outlook profile corruption, Teams audio/video device sharing, OneDrive synchronization stalls, and Office licensing reactivation.

## 2. Requirements
- Windows 11 client with Microsoft 365 Apps for Enterprise (Word, Excel, Outlook, Teams, OneDrive)
- User credentials for troubleshooting

## 3. Background
Microsoft 365 is the standard productivity suite for modern enterprises and cruise ship hotel management. Helpdesk technicians must handle:
- **Outlook Connectivity:** Autodiscover, Exchange Online sync, local `.ost` cache file corruption.
- **Microsoft Teams:** Hardware acceleration glitches, clearing bloated Teams caches, audio/video permissions.
- **OneDrive for Business:** Files On-Demand, sync conflict resolution, path character restrictions.

---

## 4. Troubleshooting Microsoft 365 Core Applications

### 1. Outlook Won't Open or Freezes ("Cannot start Microsoft Outlook"):
- **Cause:** Corrupted local Exchange data cache (`.ost` file) or corrupted mail profile.
- **Solution:**
  1. Test starting Outlook in Safe Mode: `outlook.exe /safe`.
  2. If safe mode works, disable suspect COM add-ins.
  3. If persistent, rebuild mail profile: Control Panel > Mail (Microsoft Outlook) > Show Profiles > Add new profile > Re-authenticate user. Outlook recreates a clean `.ost` cache from Exchange Online.

### 2. Microsoft Teams Blank Screen or Call Drop Glitches:
- **Cause:** Corrupted Chromium/Electron cache.
- **Solution:** Clear the Microsoft Teams cache completely:
```cmd
taskkill /IM ms-teams.exe /F
rmdir /s /q "%localappdata%\Packages\MSTeams_8wekyb3d8bbwe\LocalCache"
```

### 3. OneDrive Synchronization Stuck ("Processing changes"):
- **Cause:** Hidden temporary office lock files (`~$filename.docx`) or special characters in filenames (`< > : " / \ | ? *`).
- **Solution:** Reset the OneDrive client using the built-in reset command:
```cmd
%localappdata%\Microsoft\OneDrive\onedrive.exe /reset
```
*OneDrive will restart, verify the local file catalog, and re-sync without re-downloading existing files.*

## 5. Expected Result
The technician rapidly rectifies Microsoft 365 application stalls, rebuilds email profiles cleanly, resets cloud synchronization engines, and restores user productivity.

## 6. Completion Status
Documented
