{
  services = {
    tailscale = {
      enable = true;
      extraSetFlags = [
        "--accept-dns=true"
      ];
    };
    tailscaleAuth = {
      enable = true;
      user = "caddy";
      group = "caddy";
    };
  };
}
