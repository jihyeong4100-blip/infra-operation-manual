# Project Overview: Linux Network Security & Service Ops

This directory contains a project focused on enhancing network security and optimizing core server services (DNS, Mail, Web, File Sharing) in a practical environment. The project aims to defend against security threats and maximize operational efficiency.

## Key Goals:
- Enhanced Security: 95% reduction in unnecessary port and external traffic (using ufw/iptables).
- Operational Efficiency: 80% reduction in daily check time through Shell Script automation.
- Technical Standardization: Creation and distribution of a troubleshooting manual for non-experts.

## Technologies Used:
- **OS**: Ubuntu Linux
- **Services**: BIND9 (DNS), Postfix/Dovecot (Mail), Apache/PHP/MySQL (APM), Samba (File Sharing)
- **Security**: UFW, iptables, Wireshark (Packet Analysis)
- **Automation**: Bash Shell Script

## Key Files:

### `README.md`
This file provides a comprehensive overview of the project, including its purpose, key achievements, technology stack, and core implementation details. It also outlines the file structure of the repository.

### `scripts/daily_check.sh`
A Bash shell script designed for automated daily system checks. It performs the following tasks:
- Checks disk usage (`df -h`).
- Verifies the status of essential services (BIND9, Apache2, MySQL) using `systemctl`.
- Summarizes recent security threats by grepping for "Failed password" in `/var/log/auth.log`.
This script helps to quickly identify potential issues and maintain system health.

### `docs/troubleshooting.md`
This document serves as a troubleshooting guide for common operational issues, specifically addressing network connection delays. It describes problem symptoms, potential causes (based on Wireshark analysis), and provides practical solutions, such as firewall rule adjustments.

## Usage:

- To run the daily system check, execute the script:
  ```bash
  bash scripts/daily_check.sh
  ```
- Refer to `docs/troubleshooting.md` for guidance on resolving network-related issues.
- Explore other files in the `scripts/` directory for additional automation and security configurations.
- Consult the `docs/` directory for further operational and troubleshooting manuals.
