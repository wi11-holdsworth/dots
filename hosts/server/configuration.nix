{
  # keep-sorted start
  hostName,
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
    "borgmatic"
    "intel-gpu"
    # keep-sorted end
  ])
  ++ (util.toImports ../../modules/nixos/bundles [
    "server"
  ]);

  networking.hostName = "${hostName}";

  services.openssh.enable = true;

  system.stateVersion = "24.11";

  users = {
    groups.${userName} = { };
    users.${userName} = {
      extraGroups = [
        # keep-sorted start
        "docker"
        "wheel"
        # keep-sorted end
      ];
      home = "/home/srv";
      isNormalUser = true;
    };
  };

  virtualisation.docker.enable = true;
}
