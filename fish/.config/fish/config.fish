if status is-interactive
  # Commands to run in interactive sessions can go here
  # Disable welcome greeting
  set fish_greeting

  starship init fish | source

  direnv hook fish | source
end

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :

# Nix
if test -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
    source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
end

export PATH="$HOME/.local/bin:$PATH"
