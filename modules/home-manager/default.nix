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
    "starship"
    "yazi"
    "zoxide"
    # keep-sorted end
  ];
}
