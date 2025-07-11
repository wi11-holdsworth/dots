{
  config,
  lib,
  pkgs,
  ...
}:
let
  feature = "print-and-scan";
in
{
  config = lib.mkIf config.${feature}.enable {
    hardware.sane = {
      enable = true;
      extraBackends = [ pkgs.hplip ];
    };
    services = {
      avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };
      printing = {
        enable = true;
        drivers = [ pkgs.hplip ];
      };
    };
  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
