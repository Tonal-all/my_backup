# ~/.profile: executed by Bourne-compatible login shells.

if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi

mesg n 2> /dev/null || true
. "$HOME/.cargo/env"
# eval "$(oh-my-posh --init --shell bash --config /mnt/c/Users/17562/AppData/Local/Programs/oh-my-posh/themes/gruvbox.omp.json)"
