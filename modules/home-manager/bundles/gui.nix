{
  util,
  ...
}:
{
  imports = util.toImports ../features [
    # keep-sorted start
    "alacritty"
    "firefox"
    "kitty"
    "obsidian"
    # "zen-browser"
    # keep-sorted end
  ];
}
