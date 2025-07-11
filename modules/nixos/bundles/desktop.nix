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
    pipewire.enable = true;
    print-and-scan.enable = true;
    plasma.enable = true;

    environment.systemPackages =
      with pkgs;
      [
        beeper
        brave
        calibre
        cameractrls-gtk3
        firefox
        jellyfin-media-player
        kiwix
        libreoffice
        nixfmt-rfc-style
        obsidian
        vlc
        vscode
      ]
      ++ (with pkgs.kdePackages; [
        skanlite
        ktorrent
        kzones
      ]);
  };

  imports = [ ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
