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
    "pipewire"
    "print-and-scan"
    "protonmail-bridge"
    # keep-sorted end
  ];

  environment.systemPackages = with pkgs; [
    # keep-sorted start
    beeper
    calibre
    cameractrls-gtk3
    # https://github.com/NixOS/nixpkgs/issues/437865
    # jellyfin-media-player
    onlyoffice-desktopeditors
    textsnatcher
    # keep-sorted end
  ];
}
