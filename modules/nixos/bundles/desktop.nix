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
      beeper
      brave
      calibre
      cameractrls-gtk3
      jellyfin-media-player
      obsidian
      sleek-todo
    ];
  };

  imports = [ ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
