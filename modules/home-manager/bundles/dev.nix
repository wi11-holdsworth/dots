{
  util,
  ...
}:
{
  imports = util.toImports ../features [
    # keep-sorted start
    "direnv"
    "zed-editor"
    # keep-sorted end
  ];
}
