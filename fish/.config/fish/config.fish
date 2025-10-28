if status is-interactive
  # Commands to run in interactive sessions can go here
  # Disable welcome greeting
  set fish_greeting

  starship init fish | source
end
