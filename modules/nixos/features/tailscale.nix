{ config, lib, ... }:
let
  feature = "tailscale";
  cfg = config.${feature};

in {
  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";

  config = lib.mkIf cfg.enable {
    services = {
      ${feature}.enable = true;
      nginx.tailscaleAuth.enable = true;
    };

    networking.firewall.trustedInterfaces = [ "tailscale0" ];
  };
}
