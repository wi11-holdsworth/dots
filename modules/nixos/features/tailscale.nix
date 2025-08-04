{
  config,
  lib,
  ...
}:
let
  feature = "tailscale";
in
{
  config = lib.mkIf config.${feature}.enable {
    services.tailscale = {
      enable = true;
      extraSetFlags = [
        "--accept-dns=false"
      ];
    };

    networking.firewall.trustedInterfaces = [ "tailscale0" ];
  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
