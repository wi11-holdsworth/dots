{
  hostName,
  ...
}:
{
  networking = {
    hostName = "${hostName}";
    networkmanager.enable = true;
    firewall.enable = true;
  };
}
