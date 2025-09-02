#!/usr/bin/env bash

# Get current TTY
TTY=$(tmux display -p "#{pane_tty}" | cut -d/ -f3)

# Count stopped jobs (T state) in current tty
JOBS=$(ps -o stat= -t "$TTY" | grep -c '^T')

echo "[Jobs :$JOBS]"
