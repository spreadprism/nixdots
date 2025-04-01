{
  pkgs,
  config,
  flakeRoot,
  ...
}: {
  home.packages = with pkgs; [
    tmux
  ];
  xdg.configFile.tmux.source = config.lib.file.mkOutOfStoreSymlink "${flakeRoot}/dotfiles/.config/tmux";
  shell.extra = [
    ''
      __tmux_available () {
        [[ -x "$(command -v tmux)" ]]
      }

      __tmux_running () {
        tmux run 2> /dev/null
      }

      __inside_tmux () {
        [[ ! -z "$TMUX" ]]
      }

      __interactive_shell () {
        [[ -n "$PS1" ]]
      }

      __tmux_session_to_attach () {
        for session_number in $(tmux ls -F "#{session_name}:#{?session_attached,attached,not-attached}" | jq -R 'split(":") | select(try(.[0] | tonumber //false)) | select(.[1] == "not-attached") | .[0] | tonumber' | sort); do
          echo $session_number
          return
        done
      }

      __tmux_new_session () {
        expected_number=0
        for __session_number in $(tmux ls -F "#{session_name}" | jq -R "select(try(. | tonumber // false)) | tonumber" | sort); do
          if [[ $__session_number != $expected_number ]]; then
            echo $expected_number
            return
          fi
          expected_number=$((expected_number+1))
        done
        echo $expected_number
      }

      ti = tmux_init() {
      if __tmux_available; then
        if __interactive_shell && ! __inside_tmux; then
          if __tmux_running; then
            session_number=$(__tmux_session_to_attach)
            if [[ -n $session_number ]]; then
              exec tmux attach-session -t $session_number
            fi
            session_number=$(__tmux_new_session)
            echo $session_number
            exec tmux new -s $session_number -c "$PWD"
          else
            tmux new-session -d -s base
            exec tmux new -s 0 -c "$PWD"
          fi
        fi
      fi
      }
      tinit = function() {
      ti
      }
    ''
  ];
}
