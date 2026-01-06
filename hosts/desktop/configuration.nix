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
    "external-speakers"
    "gaming"
    "link2c"
    "plasma"
    # keep-sorted end
  ])
  ++ (util.toImports ../../modules/nixos/bundles [
    # keep-sorted start
    "desktop"
    "dev"
    "gui"
    # keep-sorted end
  ]);

  boot.initrd.luks.devices."luks-b164af31-c1c3-4b4e-83c8-eb39802c2027".device =
    "/dev/disk/by-uuid/b164af31-c1c3-4b4e-83c8-eb39802c2027";

  hardware.amdgpu.overdrive.enable = true;

  services.btrfs.autoScrub.enable = true;

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
