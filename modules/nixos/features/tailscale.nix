{
  services.tailscale = {
    enable = true;
    extraSetFlags = [
      "--accept-dns=true"
    ];
  };

  networking.firewall.trustedInterfaces = [ "tailscale0" ];
}
