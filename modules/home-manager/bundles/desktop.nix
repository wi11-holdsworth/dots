{
  util,
  ...
}:
{
  imports = util.toImports ../features [
    # keep-sorted start
    "aerc"
    "kitty"
    "mail"
    "obsidian"
    "zellij"
    "zen-browser"
    # keep-sorted end
  ];
}
