# IT Troubleshooting Session Log

| Field | Detail |
|---|---|
| **Log ID** | LOG-2024-XXXX |
| **Ticket Reference** | INC-2024-XXXX |
| **Date** | YYYY-MM-DD |
| **Technician** | Anand D |
| **Customer Name** | User Name |
| **Department / Location** | Room / Deck / Office |

---

## 1. Initial User Statement
> *"Quote the user's description of what is failing."*

## 2. Questions Asked During Triage
- Exact error message displayed?
- When did the issue first occur?
- Was any software installed or hardware moved recently?
- Are other users in your immediate area experiencing this?

## 3. Diagnostic Tests Executed

| Test Number | Diagnostic Action | Result Observed | Deduction |
|---|---|---|---|
| Test 1 | Verified physical cable & link lights | Solid Green Link LED | Layer 1 Physical OK |
| Test 2 | Ran `ipconfig /all` | IP: `192.168.100.20` | Layer 3 Valid IP |
| Test 3 | Pinged Default Gateway `192.168.100.1` | Reply in <1ms | Local LAN OK |
| Test 4 | Pinged Domain Controller `SERVER01` | Host Unreachable | Target server down |

## 4. Solution Implemented
*Document the exact steps, commands, or component replacements performed.*

## 5. User Verification
- [ ] User tested core application successfully
- [ ] No collateral errors observed
- [ ] User acknowledged ticket resolution
