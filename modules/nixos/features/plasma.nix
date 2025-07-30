{ config, lib, pkgs, ... }:
let
  feature = "plasma";
in
{
  config = lib.mkIf config.${feature}.enable {
    services = {
      desktopManager.plasma6.enable = true;
      displayManager.sddm = {
        enable = true;
        wayland.enable = true;
      };
    };

    environment.systemPackages = with pkgs.kdePackages; [
      skanlite
      ktorrent
      kzones
    ];
  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
