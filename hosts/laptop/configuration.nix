{
  pkgs,
  hostName,
  inputs,
  userName,
  ...
}:
{
  imports = [ ../../modules/nixos/default.nix ];

  amd-desktop.enable = true;
  print-and-scan.enable = true;
  site-blocker.enable = true;

  boot.initrd.luks.devices."luks-433a5889-6f18-4c9a-8d99-db02af39bdee".device = "/dev/disk/by-uuid/433a5889-6f18-4c9a-8d99-db02af39bdee";

  networking = {
    hostName = "${hostName}";
    networkmanager.enable = true;
  };

  system.stateVersion = "24.11";

  i18n.extraLocaleSettings.LC_ALL = "en_AU.UTF-8";

  users.users.${userName} = {
    extraGroups = [
      "networkmanager"
      "wheel"
      "scanner"
      "lp"
    ];
    isNormalUser = true;
  };
}
