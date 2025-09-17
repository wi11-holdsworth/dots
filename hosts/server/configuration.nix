{
  hostName,
  userName,
  ...
}:
{
  imports = [
    ../../modules/nixos/default.nix
    ./hardware-configuration.nix
  ];

  # reusable modules

  # keep-sorted start
  borgbackup-srv.enable = true;
  intel-gpu.enable = true;
  server.enable = true;
  # keep-sorted end

  # config

  networking.hostName = "${hostName}";

  services.openssh.enable = true;

  system.stateVersion = "24.11";

  users = {
    groups.${userName} = { };
    users.${userName} = {
      extraGroups = [
        # keep-sorted start
        "wheel"
        "docker"
        # keep-sorted end
      ];
      home = "/home/srv";
      isNormalUser = true;
    };
  };

  virtualisation.docker.enable = true;
}
