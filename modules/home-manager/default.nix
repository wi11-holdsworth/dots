{
  util,
  ...
}:
{
  imports = util.toImports ./features [
    # keep-sorted start
    "agenix"
    "bat"
    "bottom"
    "delta"
    "eza"
    "fd"
    "fish"
    "gh"
    "git"
    "lazygit"
    "shell-aliases"
    "starship"
    "yazi"
    "zoxide"
    # keep-sorted end
  ];
}
