{ pkgs, hostName, inputs, userName, ... }: {
  imports = [ ../../modules/nixos/default.nix ];

  # web services
  agenix.enable = true;
  aria2.enable = true;
  borgbackup-srv.enable = true;
  dufs.enable = true;
  glances.enable = true;
  immich.enable = true;
  jellyfin.enable = true;
  nginx.enable = true;
  vscode-server.enable = true;
  vaultwarden.enable = true;

  environment.systemPackages = with pkgs; [
    nh
    gh
    eza
    ripgrep-all
    fd
    dust
    bat
    nom
    delta
    zellij
  ];

  networking.hostName = "${hostName}";

  services.openssh.enable = true;

  system.stateVersion = "24.11";

  users.users.${userName} = {
    extraGroups = [ "wheel" "docker" ];
    home = "/home/srv";
    isNormalUser = true;
    shell = pkgs.bash;
  };

  virtualisation.docker.enable = true;
}
