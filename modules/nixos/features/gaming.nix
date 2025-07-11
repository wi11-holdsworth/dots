{
  config,
  lib,
  pkgs,
  ...
}:
let
  feature = "gaming";
in
{
  config = lib.mkIf config.${feature}.enable {
    environment.systemPackages = with pkgs; [
      heroic
      lutris
      mangohud
      nexusmods-app
      protonup-qt
      wine
      wine64
      winetricks
      prismlauncher
    ];

    programs = {
      gamemode.enable = true;
      steam = {
        enable = true;
        gamescopeSession.enable = true;
      };
    };

    # latest kernel
    boot.kernelPackages = pkgs.linuxPackages_latest;
  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
