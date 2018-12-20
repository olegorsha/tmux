#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HELPERS_DIR="$CURRENT_DIR"

REMOTE_SHELL_WAIT_TIME="0.4"

source "${HELPERS_DIR}/helpers.sh"

REMOTE_SHELL_WAIT_TIME="0.4"

add_sleep_for_remote_shells() {
  local pane_command
  pane_command="$(tmux display-message -p '#{pane_current_command}')"
  if [[ $pane_command =~ (ssh|mosh) ]]; then
    sleep "$REMOTE_SHELL_WAIT_TIME"
  fi
}

main(){
  tmux send -X start-of-line
  add_sleep_for_remote_shells
  tmux send -X begin-selection
  tmux send -X end-of-line
  tmux send -X previous-word
  tmux send -X next-word-end
  tmux send -X copy-pipe-and-cancel "xclip -i -selection clipboard"
  display_message 'Line copied to clipboard!'
}

main
