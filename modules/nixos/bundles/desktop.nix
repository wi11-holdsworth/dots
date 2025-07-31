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

    environment.systemPackages = with pkgs; [
      beeper
      brave
      calibre
      cameractrls-gtk3
      jellyfin-media-player
      kiwix
      libreoffice
      obsidian
      vlc
      vscode
    ];
  };

  imports = [ ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
