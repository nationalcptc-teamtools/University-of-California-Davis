#!/usr/bin/env bash
# ~/.tmux-log.sh — called by tmux pipe-pane. Cleans a raw pane stream and
# appends a timestamped, de-ANSI'd transcript per pane to ~/tmux-logs.
#
# tmux invokes it as:  bash ~/.tmux-log.sh <pane_id> <window_index> <pane_index>
# Only shell-safe tmux formats are passed in; the session name is looked up
# internally and sanitized, so a hostile session name cannot inject or escape.
#
# Recommended deps on the VDI (optional — the script degrades gracefully):
#   sudo apt -y install colorized-logs moreutils
#     colorized-logs -> ansi2txt (robust CSI/OSC stripping)
#     moreutils      -> ts        (per-line timestamps)
#
# Install: copy to ~/.tmux-log.sh and `chmod +x`. Cloning the repo is NOT enough;
# the file must live at ~/.tmux-log.sh (and the config at ~/.tmux.conf).

set -u
umask 077   # logs can contain credentials / engagement data

san() { tr -cd 'A-Za-z0-9._-' | cut -c1-64; }

paneid_raw="${1:-%0}"
win="$(printf '%s' "${2:-0}" | san)"
pane="$(printf '%s' "${3:-0}" | san)"
pidclean="$(printf '%s' "$paneid_raw" | san)"   # e.g. %3 -> 3

# Session name is looked up here (never passed through the shell invocation),
# then sanitized before it touches a filename.
sess="$(tmux display-message -p -t "$paneid_raw" '#{session_name}' 2>/dev/null | san)"
[ -n "$sess" ] || sess="sess"

dir="$HOME/tmux-logs"
mkdir -p "$dir" || exit 1
f="$dir/${sess}-w${win}p${pane}-id${pidclean}-$(date +%Y%m%d).log"

clean() {
  if command -v ansi2txt >/dev/null 2>&1; then
    if command -v stdbuf >/dev/null 2>&1; then stdbuf -oL ansi2txt; else ansi2txt; fi
  else
    # '#' delimiter so literal '/' needs no escaping (escaping it as \/ breaks
    # the bracket range in GNU sed). [0-?] = CSI params, [ -/] = intermediates.
    sed -u -r \
      -e 's#\x1b\][^\x07\x1b]*(\x07|\x1b\\)##g' \
      -e 's#\x1b[P^_X][^\x1b]*\x1b\\##g' \
      -e 's#\x1b\[[0-?]*[ -/]*[@-~]##g' \
      -e 's#\x1b[()*+][A-Za-z0-9]##g' \
      -e 's#\x1b[=>]##g' \
      -e 's#\r##g'
  fi
}

stamp() {
  if command -v ts >/dev/null 2>&1; then
    ts '%Y-%m-%d %H:%M:%S'
  else
    while IFS= read -r line || [ -n "$line" ]; do
      printf '%s %s\n' "$(date '+%F %T')" "$line"
    done
  fi
}

clean | stamp >> "$f"
