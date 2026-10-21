#!/bin/sh

THRESHOLD=7 

NC='\033[0m'
RED='\033[31m'

LOGFILE='/var/log/pacman.log'
LAST_UPDATE="$(grep Syu "$LOGFILE" | tail -n 1)"

# Convert datetime from log to EPOCH date  
[[ $LAST_UPDATE =~ '^\[([^]]+)\]' ]] && 
LU_EPOCH="$(echo "$match[1]" | xargs -I {} date -d '{}' +%s)"

# Calculate difference between today and last update
NOW_EPOCH="$(date +%s)"
DIFF_DAYS="$(((NOW_EPOCH - LU_EPOCH)/86400))"

[ "$DIFF_DAYS" -lt $THRESHOLD ] && return 0

echo -e "\
${RED}\
!! WARNING !!
Last update $DIFF_DAYS days ago.\n"
