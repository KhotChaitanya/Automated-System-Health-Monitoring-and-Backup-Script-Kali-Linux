#!/bin/bash

# Automated System Health Monitoring and Backup Script for Kali Linux

# Variables
BACKUP_SOURCE="/home/$(whoami)/Documents"
BACKUP_DEST="/home/$(whoami)/backups"
DATE=$(date +%d-%m-%Y)
BACKUP_FILE="$BACKUP_DEST/backup-$DATE.tar.gz"
CPU_THRESHOLD=80
RAM_THRESHOLD=500 # MB
DISK_THRESHOLD=85

# Create backup directory if not exists
mkdir -p $BACKUP_DEST

echo "===================================="
echo " Kali Linux System Health Check "
echo "===================================="

# CPU Usage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
CPU_INT=${CPU_USAGE%.*}
echo "CPU Usage: $CPU_USAGE %"
if [ "$CPU_INT" -gt "$CPU_THRESHOLD" ]; then
  echo "⚠️  High CPU Usage Warning!"
fi

# RAM Usage
FREE_RAM=$(free -m | awk '/^Mem:/{print $4}')
echo "Free RAM: $FREE_RAM MB"
if [ "$FREE_RAM" -lt "$RAM_THRESHOLD" ]; then
  echo "⚠️  Low Available RAM Warning!"
fi

# Disk Usage
DISK_USAGE=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')
echo "Disk Usage on / : $DISK_USAGE %"
if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]; then
  echo "⚠️  High Disk Usage Warning!"
fi

# Critical Services Status Check (ssh, cron)
SERVICES=("ssh" "cron")
echo "Checking Critical Services:"
for service in "${SERVICES[@]}"
do
    if systemctl is-active --quiet $service; then
        echo "✅ $service service is running."
    else
        echo "❌ $service service is NOT running."
    fi
done

# Create Backup
echo "Creating backup of $BACKUP_SOURCE ..."
tar -czf $BACKUP_FILE $BACKUP_SOURCE 2>/dev/null

if [ $? -eq 0 ]; then
    echo "✅ Backup created successfully at $BACKUP_FILE"
else
    echo "❌ Backup failed!"
fi

echo "===================================="
echo " Health Check Completed. "
echo "===================================="
