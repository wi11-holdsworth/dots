{
  # keep-sorted start
  pkgs,
  util,
  # keep-sorted end
  ...
}:
{
  imports = util.toImports ../features [
    # keep-sorted start
    "fonts"
    # keep-sorted end
  ];

  environment.systemPackages = with pkgs; [
    # keep-sorted start
    beeper
    cameractrls-gtk3
    jellyfin-desktop
    onlyoffice-desktopeditors
    textsnatcher
    # keep-sorted end
  ];
}
