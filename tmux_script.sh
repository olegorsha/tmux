unset -f tmux_update_env
tmux_update_env() {                                                                                             # {{{1
  # Update environment variables in TMUX
  # https://raim.codingfarm.de/blog/2013/01/30/tmux-update-environment/
  echo "Updating to latest tmux environment...";

  local _line;
  while read _line; do
    if [[ $_line == -* ]]; then
      unset ${_line/#-/}
    else
      _line=${_line/=/=\"}
      _line=${_line/%/\"}
      eval export $_line;
    fi;
  done < <(tmux show-environment)

  echo "...done"
}
