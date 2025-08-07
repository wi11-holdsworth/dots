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

  borgbackup-srv.enable = true;
  intel-gpu.enable = true;
  server.enable = true;

  # config

  networking.hostName = "${hostName}";

  services.openssh.enable = true;

  system.stateVersion = "24.11";

  users = {
    groups.${userName} = { };
    users.${userName} = {
      extraGroups = [
        "wheel"
        "docker"
      ];
      home = "/home/srv";
      isNormalUser = true;
      shell = pkgs.fish;
    };
  };

  virtualisation.docker.enable = true;
}
