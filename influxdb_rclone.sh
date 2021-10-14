#!/bin/bash
# Get today's date in mm-dd-yyyy
today=`date +%m-%d-%Y`
# Do a full backup of all influxdb databases to a temp directory with the current date
influxd backup -portable "/home/weewx/influxdb_backup/$today"
# Copy this new directory to OneDrive
rclone copy "/home/weewx/influxdb_backup/$today" remote:influxdb/$today
# If the local directory becomes more than 1GB in size, delete the contents of the local directory
# First get the size of the directory
size=`du -sb "/home/weewx/influxdb_backup/"`
# then decide what to do
if [[ "$size" -gt '1073741824' ]]; then
	rm -rf "/home/weewx/influxdb_backup/*"
fi

