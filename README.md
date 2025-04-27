# Automated System Health Monitoring and Backup Script (Kali Linux)

## Overview
A lightweight Bash script designed for Kali Linux systems that monitors CPU usage, available RAM, disk usage, and critical services like SSH and Cron. Additionally, it automates the backup process for important user directories into compressed archives, aiding system administrators in maintaining system health and securing essential files.

## Features
- Real-time CPU usage monitoring
- Free RAM availability check
- Disk space usage monitoring
- Status check of critical services (SSH, Cron)
- Automated backup of user Documents folder into timestamped `.tar.gz` files
- Simple and lightweight; runs efficiently even on low-resource virtual machines

## Technologies Used
- Bash Scripting
- Kali Linux
- Linux System Commands: `top`, `free`, `df`, `systemctl`, `tar`

## How to Run
1. Clone or download this repository to your Kali Linux system.
2. Open the terminal and navigate to the project folder.
3. Make the script executable:
   ```bash
   chmod +x health_backup.sh
  ./health_backup.sh

### CPU, RAM, Disk Usage Output
![output](https://github.com/user-attachments/assets/11b0b099-217c-4a02-8d21-f8aaf472f523)
