{
  # keep-sorted start
  userName,
  util,
  # keep-sorted end
  ...
}:
{
  imports = [
    # keep-sorted start
    ../../modules/nixos/default.nix
    ./hardware-configuration.nix
    # keep-sorted end
  ]
  ++ (util.toImports ../../modules/nixos/features [
    # keep-sorted start
    "amd-gpu"
    "gnome"
    "tlp"
    # keep-sorted end
  ])
  ++ (util.toImports ../../modules/nixos/bundles [
    # keep-sorted start
    "desktop"
    "dev"
    # keep-sorted end
  ]);

  boot.initrd.luks.devices."luks-a7726a9d-535f-44bc-9c0e-adc501fad371".device =
    "/dev/disk/by-uuid/a7726a9d-535f-44bc-9c0e-adc501fad371";

  system.stateVersion = "24.11";

  i18n.extraLocaleSettings.LC_ALL = "en_AU.UTF-8";

  users.users.${userName} = {
    extraGroups = [
      # keep-sorted start
      "lp"
      "networkmanager"
      "scanner"
      "wheel"
      # keep-sorted end
    ];
    isNormalUser = true;
  };
}
