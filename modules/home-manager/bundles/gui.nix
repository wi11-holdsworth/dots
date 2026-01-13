{
  util,
  ...
}:
{
  imports = util.toImports ../features [
    # keep-sorted start
    "alacritty"
    "firefox"
    "obsidian"
    # "zen-browser"
    # keep-sorted end
  ];
}
