{ config, lib, pkgs, ... }:
let
  feature = "gaming";
  cfg = config.${feature};

in {
  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      mangohud
      protonup-qt
      lutris
      heroic
    ];

    programs = {
      gamemode.enable = true;
      steam = {
        enable = true;
        gamescopeSession.enable = true;
      };
    };
  };
}
