reminders_file="${HOME}/.reminders"

if [ -s "$reminders_file" ]; then
  echo ""
  echo "## REMINDERS ##"
  cat "$reminders_file"
  echo "###############"
  echo ""
fi

frem() {
    if [ -f "$reminders_file" ]; then
        echo -n > "$reminders_file"
        return 0
    else
        echo "[$0] File $reminders_file not found."
        return 1
    fi

    return 2
}
