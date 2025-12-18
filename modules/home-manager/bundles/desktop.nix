{
  util,
  ...
}:
{
  imports = util.toImports ../features [
    # keep-sorted start
    "aerc"
    "firefox"
    "kitty"
    "mail"
    "obsidian"
    "zellij"
    "zen-browser"
    # keep-sorted end
  ];
}
