#!/bin/sh

THRESHOLD="$1"
[ -n "$THRESHOLD" ] || THRESHOLD=7 
[ "$THRESHOLD" -eq 0 ]  # Checks if $THRESHOLD is an integer

NC='\033[0m'
RED='\033[31m'

LOGFILE='/var/log/pacman.log'
LAST_UPDATE="$(grep Syu /var/log/pacman.log | tail -n 1)"

LU_EPOCH="$(date -d "$ts" +%s)"
NOW_EPOCH="$(date +%s)"
DIFF_DAYS="$(((NOW_EPOCH - LU_EPOCH)/86400))"

[ "$DIFF_DAYS" -lt 7 ] && exit 0

echo -e "\
${RED}\
!! WARNING !!
Last update $DIFF_DAYS days ago.\n"
