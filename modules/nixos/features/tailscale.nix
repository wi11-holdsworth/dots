{
  services.tailscale = {
    enable = true;
    extraSetFlags = [
      "--accept-dns=true"
    ];
  };
}
