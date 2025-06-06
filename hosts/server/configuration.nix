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

  # self-hosted web services
  couchdb.enable = true;
  dufs.enable = true;
  homepage-dashboard.enable = true;
  immich.enable = true;
  jellyfin-bundle.enable = true;
  ntfy-sh.enable = true;
  stirling-pdf.enable = true;
  vaultwarden.enable = true;

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
