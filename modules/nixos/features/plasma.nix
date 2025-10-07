{
  config,
  lib,
  pkgs,
  ...
}:
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

    environment.systemPackages =
      with pkgs.kdePackages;
      [
        # keep-sorted start
        ktorrent
        kzones
        # keep-sorted end
      ]
      ++ (with pkgs; [
        # keep-sorted start
        haruna
        # keep-sorted end
      ]);
  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
