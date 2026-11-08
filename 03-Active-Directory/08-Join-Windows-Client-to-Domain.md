# Practical Task: Joining Windows 11 Workstations to Active Directory Domain

## 1. Objective
Configure Windows 11 client networking to point to the Domain Controller DNS, bind the client machine (`CLIENT01`) to `lab.local`, and test domain user interactive login.

## 2. Requirements
- Primary Domain Controller (`SERVER01.lab.local` at `192.168.100.10`)
- Client Workstation (`CLIENT01`) running Windows 11 Pro/Enterprise
- Domain Administrator or delegated account credentials

## 3. Background
For a Windows workstation to join a domain:
1. **Network Connectivity:** Client must physically or virtually communicate with the DC.
2. **DNS Resolution:** **THE #1 REASON FOR DOMAIN JOIN FAILURES!** The client must query the Domain Controller's DNS server to locate the SRV records (`_ldap._tcp.dc._msdcs.lab.local`). If the client uses an external DNS like 8.8.8.8, domain join will always fail!
3. **Computer Account:** A computer object (`CLIENT01$`) is created in Active Directory.

## 4. Step-by-Step Procedure
1. **Configure DNS on Client:**
   - On `CLIENT01`, open Network Connections (`ncpa.cpl`).
   - Open Ethernet properties > IPv4 properties.
   - Set Preferred DNS Server to `192.168.100.10` (the DC's static IP).
2. **Test Domain Locator Records:** Open Command Prompt and ping `lab.local` or run `nslookup lab.local`. Verify response returns `192.168.100.10`.
3. **Join Domain via GUI:**
   - Open Settings > System > About > Click "Advanced system settings" > Computer Name tab > Click `Change...`.
   - Select Member of: Domain > Enter `lab.local`.
   - Enter `LAB\Administrator` credentials when prompted.
   - Receive dialog: "Welcome to the lab.local domain".
4. **PowerShell Domain Join:** Alternatively, run `Add-Computer -DomainName "lab.local" -Restart`.
5. **Restart Workstation:** Reboot the client machine.
6. **Domain Login:** At login screen, choose "Other user", enter `LAB\user01`, enter temporary password, and complete mandatory password change.

## 5. Commands Used

### Command 1: Join Domain via PowerShell
```powershell
Add-Computer -DomainName "lab.local" -Credential (Get-Credential) -Restart
```
- **What it does:** Prompts for domain credentials, binds the workstation to `lab.local`, provisions the computer account, and restarts the computer.

### Command 2: Verify Domain Membership
```powershell
Get-CimInstance Win32_ComputerSystem | Select-Object Name, Domain, PartOfDomain
```
- **What it does:** Confirms `PartOfDomain = True` and `Domain = lab.local`.

### Command 3: Test Domain Controller Locator (Netlogon)
```cmd
nltest /dsgetdc:lab.local
```
- **What it does:** Queries Netlogon to confirm the workstation successfully established a secure channel with `SERVER01`.

## 6. Expected Result
`CLIENT01` is joined to `lab.local`, resides in the domain computer directory, and allows domain users to log in with personalized roaming or local profiles.

## 7. Troubleshooting
- **Issue: Error "An Active Directory Domain Controller for the domain 'lab.local' could not be contacted":**
  - *Cause:* Client is using router/ISP DNS instead of `192.168.100.10`.
  - *Solution:* Inspect `ipconfig /all`. Ensure ONLY `192.168.100.10` is listed as DNS server. Run `ipconfig /flushdns`.

## 8. Screenshots / Evidence
- `screenshots/08-domain-join-welcome.png` — *Pending lab execution: Capture "Welcome to the lab.local domain" dialog.*
- `screenshots/08-nltest-output.png` — *Pending lab execution: Capture nltest /dsgetdc command output.*

## 9. Practical Learning Outcome
Ability to properly configure DNS resolvers, establish secure workstation domain bindings, and verify enterprise domain logon.

## 10. Completion Status
Documented
