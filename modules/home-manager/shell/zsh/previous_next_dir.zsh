previous_dir () {
  dirhistory_back
  zle .accept-line
}
next_dir () {
  dirhistory_forward
  zle .accept-line
}

zle -N previous_dir
zle -N next_dir

bindkey '^O' previous_dir
bindkey '^P' next_dir
