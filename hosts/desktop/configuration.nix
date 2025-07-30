{
  pkgs,
  hostName,
  inputs,
  userName,
  ...
}:
{
  imports = [
    ../../modules/nixos/default.nix
    ./hardware-configuration.nix
  ];

  # reusable modules

  amd-gpu.enable = true;
  desktop.enable = true;
  external-speakers.enable = true;
  gaming.enable = true;
  link2c.enable = true;
  plasma.enable = true;

  # config

  boot.initrd.luks.devices."luks-b164af31-c1c3-4b4e-83c8-eb39802c2027".device =
    "/dev/disk/by-uuid/b164af31-c1c3-4b4e-83c8-eb39802c2027";

  services.btrfs.autoScrub.enable = true;

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
