{
  ...

}: {
    services = {
      tailscale.enable = true;

      nginx.tailscaleAuth.enable = true;
    };
}
