{
  ...

}: {
    services = {
      tailscale.enable = true;
      nginx.tailscaleAuth.enable = true;
    };
    networking.firewall.trustedInterfaces = [ "tailscale0" ];
}
