{
  util,
  ...
}:
{
  imports = util.toImports ../features [
    # keep-sorted start
    "firefox"
    "kitty"
    "obsidian"
    # "zen-browser"
    # keep-sorted end
  ];
}
