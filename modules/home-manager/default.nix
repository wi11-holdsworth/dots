{
  util,
  ...
}:
{
  imports = util.toImports ./features [
    # keep-sorted start
    "aerc"
    "agenix"
    "bat"
    "delta"
    "eza"
    "fish"
    "gh"
    "git"
    "lazygit"
    "mail"
    "starship"
    "yazi"
    "zellij"
    "zoxide"
    # keep-sorted end
  ];
}
