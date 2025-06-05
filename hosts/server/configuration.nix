{
  pkgs,
  hostName,
  inputs,
  userName,
  ...
}:
{
  imports = [ ../../modules/nixos/default.nix ];

  # web services
  agenix.enable = true;
  aria2.enable = true;
  borgbackup-srv.enable = true;
  couchdb.enable = true;
  dufs.enable = true;
  homepage-dashboard.enable = true;
  immich.enable = true;
  intel-desktop.enable = true;
  jellyfin.enable = true;
  nginx.enable = true;
  ntfy-sh.enable = true;
  stirling-pdf.enable = true;
  vscode-server.enable = true;
  vaultwarden.enable = true;
  freshrss.enable = true;

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
