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
  gnome.enable = true;
  tlp.enable = true;

  # config

  boot.initrd.luks.devices."luks-a7726a9d-535f-44bc-9c0e-adc501fad371".device = "/dev/disk/by-uuid/a7726a9d-535f-44bc-9c0e-adc501fad371";

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
