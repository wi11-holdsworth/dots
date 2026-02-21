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
    cameractrls-gtk3
    jellyfin-desktop
    libreoffice
    signal-desktop
    textsnatcher
    # keep-sorted end
  ];
}
