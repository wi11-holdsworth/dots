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
    dev.enable = true;
    pipewire.enable = true;
    print-and-scan.enable = true;

    environment.systemPackages = with pkgs; [
      # keep-sorted start
      beeper
      brave
      calibre
      cameractrls-gtk3
      jellyfin-media-player
      onlyoffice-desktopeditors
      sleek-todo
      # keep-sorted end
    ];
  };

  imports = [ ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
