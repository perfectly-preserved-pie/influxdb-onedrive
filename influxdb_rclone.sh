#!/bin/bash
# Get today's date in mm-dd-yyyy
today=`date +%m-%d-%Y`
# Do a full backup of all influxdb databases to a temp directory with the current date
influxd backup -portable "/home/weewx/influxdb_backup/$today"
# Copy this new directory to OneDrive
rclone copy "/home/weewx/influxdb_backup/$today" remote:influxdb/$today
# To prevent the disk from filling, delete all backups except the latest 3
cd /home/weewx/influxdb_backup && ls -tp | grep -v '/$' | tail -n +6 | xargs -d '\n' -r rm --
