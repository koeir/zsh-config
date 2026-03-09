## Checks if pacupg was ran over a week ago
lastupg="$(grep pacupg $HISTFILE | grep -v grep | tail -n 1 | cut -d ':' -f2)"
currentunixdate="$(date +%s)"
lastupg_daysago=$(( (currentunixdate-lastupg) / 86400 ))
if (( lastupg_daysago >= 7 )); then
    echo ""
    echo -e "\e[31m!! WARNING !!"
    echo -e "Last system update was "$lastupg_daysago" days ago.\e[0m"
fi
