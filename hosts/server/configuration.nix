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
  ];

  borgbackup-srv.enable = true;
  intel-desktop.enable = true;
  nginx.enable = true;
  vscode-server.enable = true;
  web-services.enable = true;

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
      shell = pkgs.bash;
    };
  };

  virtualisation.docker.enable = true;
}
