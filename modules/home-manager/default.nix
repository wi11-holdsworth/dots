{
  util,
  ...
}:
{
  imports = util.toImports ./features [
    # keep-sorted start
    "agenix"
    "bat"
    "direnv"
    "eza"
    "fish"
    "gh"
    "git"
    "starship"
    "yazi"
    "zoxide"
    # keep-sorted end
  ];
}
