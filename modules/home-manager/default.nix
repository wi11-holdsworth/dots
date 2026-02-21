{
  util,
  ...
}:
{
  imports = util.toImports ./features [
    # keep-sorted start
    "agenix"
    "bash"
    "bat"
    "bottom"
    "delta"
    "eza"
    "fd"
    "git"
    "lazygit"
    "shell-aliases"
    "starship"
    "yazi"
    "zoxide"
    # keep-sorted end
  ];
}
