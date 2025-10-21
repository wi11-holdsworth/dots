{
  pkgs,
  ...
}:
{
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
}
