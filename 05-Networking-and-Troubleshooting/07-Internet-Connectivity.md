# Practical Task: Internet and WAN Connectivity Troubleshooting

## 1. Objective
Diagnose Wide Area Network (WAN) and satellite internet uplink disruptions, evaluate latency and packet loss, and differentiate ISP failures from internal infrastructure bugs.

## 2. Requirements
- Client PC connected to network with internet access
- Command prompt utilities: `ping`, `tracert`, `pathping`

## 3. Background
In enterprise offices and maritime shipboard environments, WAN connectivity connects the local facility to corporate datacenters and the public internet. Onboard vessels, WAN relies on satellite uplinks (VSAT / Starlink):
- **Satellite Latency:** Geostationary VSAT incurs round-trip latency of 500ms – 700ms; LEO constellations incur 40ms – 80ms.
- **Weather / Obstruction:** Heavy rain fade, mast shadows, or pitching in rough seas can degrade satellite signals.
- **Bandwidth Contention:** Bandwidth is capped and prioritized via Quality of Service (QoS) rules (Navigation & Safety > Crew Admin > Guest Wi-Fi).

## 4. Step-by-Step Procedure
1. **Continuous Latency Ping:** Execute `ping -t 8.8.8.8` to evaluate link stability, jitter, and dropped packet percentage.
2. **Execute Path Traceroute:** Run `tracert 8.8.8.8` to identify each router hop between the client and public internet.
3. **Execute PathPing:** Run `pathping 8.8.8.8` to measure packet loss per individual router hop over a 2-minute period.
4. **Isolate Failure Point:**
   - Drops at Hop 1: Local router failure.
   - Drops at Hop 2/3: ISP / Satellite modem / satellite dish blockage.
   - Drops at destination: Remote server issue.

## 5. Commands Used

### Command 1: Continuous Ping Test
```cmd
ping -n 20 8.8.8.8
```
- **What it does:** Sends 20 ICMP Echo Requests and calculates Minimum, Maximum, Average latency, and Packet Loss %.

### Command 2: Trace Network Path (Windows)
```cmd
tracert 8.8.8.8
```
- **What it does:** Uses ICMP with incrementing Time-To-Live (TTL) values to list every intermediate router hop.
- **Expected Output:**
```text
Tracing route to dns.google [8.8.8.8] over a maximum of 30 hops:
  1    <1 ms    <1 ms    <1 ms  192.168.100.1
  2     5 ms     4 ms     5 ms  10.50.0.1
  3    15 ms    14 ms    15 ms  isp-core-router.net [203.0.113.1]
  4    18 ms    17 ms    18 ms  dns.google [8.8.8.8]
Trace complete.
```

### Command 3: PathPing Detailed Loss Analysis
```cmd
pathping -q 5 -p 250 8.8.8.8
```
- **What it does:** Combines ping and traceroute to compute exact packet loss percentage on each intermediate hop.

## 6. Expected Result
The technician pinpoints whether network slowness or outages originate within the local LAN or on external WAN/satellite links.

## 7. Troubleshooting
- **Issue: High packet loss (e.g., 40%) with alternating timeouts:**
  - *Cause:* Saturated satellite uplink, rain fade on satellite dish, or damaged physical patch lead.
  - *Solution:* Inspect satellite modem signal-to-noise ratio (SNR); enforce bandwidth shaping to restrict high-bandwidth consumers.

## 8. Screenshots / Evidence
- `screenshots/07-tracert-hops.png` — *Pending lab execution: Capture completed tracert output.*
- `screenshots/07-pathping-loss.png` — *Pending lab execution: Capture pathping packet loss table.*

## 9. Practical Learning Outcome
Ability to diagnose WAN performance, analyze route hops, and isolate satellite uplink degradation.

## 10. Completion Status
Documented
