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
    "gui"
    # keep-sorted end
  ]);

  boot.initrd.luks.devices."luks-c2f5123c-0be0-4357-b383-b3f422e99a34".device = "/dev/disk/by-uuid/c2f5123c-0be0-4357-b383-b3f422e99a34";

  system.stateVersion = "25.05";

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
