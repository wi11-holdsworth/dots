{
  config,
  lib,
  pkgs,
  ...
}:
let
  feature = "desktop";
in
{
  config = lib.mkIf config.${feature}.enable {
    # keep-sorted start
    dev.enable = true;
    pipewire.enable = true;
    print-and-scan.enable = true;
    protonmail-bridge.enable = true;
    # keep-sorted end

    environment.systemPackages = with pkgs; [
      # keep-sorted start
      beeper
      calibre
      cameractrls-gtk3
      # https://github.com/NixOS/nixpkgs/issues/437865
      # jellyfin-media-player
      onlyoffice-desktopeditors
      sleek-todo
      textsnatcher
      # keep-sorted end
    ];
  };

  imports = [ ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
