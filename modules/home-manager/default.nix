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
