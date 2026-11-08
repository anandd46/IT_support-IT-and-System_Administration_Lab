# Master IT Troubleshooting Checklist

A universal, structured checklist for desktop support engineers and system administrators.

---

## Stage 1: Preliminary Information Gathering
- [ ] Record user contact details, physical desk/cabin location, and asset tag.
- [ ] Transcribe the exact wording of error messages or photograph dialog boxes.
- [ ] Determine scope: Single user, entire department, or vessel-wide?
- [ ] Ask: What changed immediately prior to the failure (updates, power cut, moved cable)?
- [ ] Attempt to duplicate the error condition step by step.

---

## Stage 2: Physical & Environmental Verification (Layer 1)
- [ ] Device power cord firmly seated in active, tested electrical outlet.
- [ ] Power switch turned on; power supply fan spinning.
- [ ] Network patch cord latched securely into RJ45 jack; link LED lit green/amber.
- [ ] Video display cables (HDMI/DP) hand-tightened into dedicated GPU ports.
- [ ] Device temperature normal (no fan screaming or thermal throttling).

---

## Stage 3: Logical Network & Addressing (Layers 2 & 3)
- [ ] Execute `ipconfig /all` (or `ip a`).
- [ ] Confirm IP is NOT an APIPA address (`169.254.x.x`).
- [ ] Ping local loopback (`127.0.0.1`) to verify local network stack.
- [ ] Ping Default Gateway (`192.168.100.1`) to confirm local switch reachability.
- [ ] Ping external IP (`8.8.8.8`) to confirm WAN/Internet routing.
- [ ] Ping domain name (`google.com`) or run `nslookup` to confirm DNS health.

---

## Stage 4: Authentication & Security (Layers 5 & 7)
- [ ] Verify user account is not locked out in Active Directory (`Search-ADAccount -LockedOut`).
- [ ] Verify account password has not expired.
- [ ] Verify computer system time matches Domain Controller within 5 minutes (`w32tm /query /status`).
- [ ] Verify user belongs to authorized security groups for requested resources.
- [ ] Purge client Kerberos ticket cache (`klist purge`) if permissions changed.

---

## Stage 5: Remediation & Action Plan
- [ ] Formulate a hypothesis of probable cause based on collected evidence.
- [ ] Ensure a rollback strategy exists before making configuration changes.
- [ ] **APPLY ONE CHANGE AT A TIME**. Never change multiple parameters simultaneously.
- [ ] Re-test the exact user workflow after each individual change.

---

## Stage 6: Validation, Closure & Documentation
- [ ] Have the end-user test their primary business software in your presence.
- [ ] Verify no secondary errors or side effects were introduced.
- [ ] Populate helpdesk ticketing system with Root Cause Analysis (RCA).
- [ ] Update asset inventory or hardware registry if components were swapped.
- [ ] Inform customer of resolution and formally close ticket.
