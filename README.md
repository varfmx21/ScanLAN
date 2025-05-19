Collecting workspace information# ScanLAN

ScanLAN is a Bash script for analyzing local network information and discovering hosts on your LAN.

## Features

- **Network Information Analysis**:
  - Identifies IP address class (A, B, C, D, E)
  - Displays network address, first and last host addresses
  - Shows broadcast address and number of assignable hosts
  - Color-coded output for better readability

- **Host Discovery**:
  - Scans local network for connected devices
  - Displays hostname, IP address, and MAC address for each device
  - Identifies unknown hosts

## Requirements

- **Linux Environment**: This script currently only works on Linux systems
- Requires `arp` and `ip` commands (pre-installed on most Linux distributions)

## Usage

1. Make the script executable:
   ```bash
   chmod +x localNetworkHost.sh
   ```

2. Run the script:
   ```bash
   ./localNetworkHost.sh
   ```

3. Choose an option from the menu:
   - **Option 1**: Analyze your local network configuration
     - Shows information about your current network
     - Optionally scans for all hosts on your LAN
   - **Option 2**: Enter a custom IP address for analysis

## Note

The script currently uses a specific network interface name (`wlp0s20f3`). You may need to modify this in the script if your network interface has a different name.

## Example Output

```
-----------------------------------
|    🌐Network Informaction Menu   |
-----------------------------------

[1] Local Network
[2] Enter Network manually
>>> Choose an option: 1

---📡Local Network Information---

[+] Class: C
[+] Network Adress: 192.168.1.0
[+] First Host Adress: 192.168.1.1
[+] Last Host Adress: 192.168.1.254
[+] Broadcast Adress: 192.168.1.255
[+] Asignable Hosts: 254

[?] Want to discover all the hosts in LAN? (y/n) > y

---📡Scanning all hosts---

[+] Host: router
     IP: 192.168.1.1
     MAC: 00:11:22:33:44:55
```