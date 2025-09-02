#!/usr/bin/env bash

# Get current TTY
TTY=$(tmux display -p "#{pane_tty}" | cut -d/ -f3)

# Count stopped jobs (T state) in current tty
JOBS=$(ps -o stat= -t "$TTY" | grep -c '^T')

if [ "$JOBS" -gt 0 ]; then
  echo "[Background Jobs :$JOBS]"
else
  echo ""
fi
