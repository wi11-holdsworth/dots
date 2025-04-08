{ pkgs, inputs, hostName, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/default.nix
    inputs.home-manager.nixosModules.home-manager
    inputs.agenix.nixosModules.default
    inputs.nixvim.nixosModules.nixvim
  ];

  # web services
  aria2.enable = true;
  borgbackup-srv.enable = true;
  dufs.enable = true;
  glances.enable = true;
  immich.enable = true;
  jellyfin.enable = true;
  nginx.enable = true;
  vscode-server.enable = true;
  vaultwarden.enable = true;

  # TODO: remove reference to username
  age.identityPaths = [ "/home/srv/.ssh/id_ed25519" ];

  environment.systemPackages = with pkgs;
    [ nh gh eza ripgrep-all fd dust bat nom delta zellij ]
    ++ ([ inputs.agenix.packages.x86_64-linux.default ]);

  # TODO: remove reference to username
  home-manager.users.srv = import ./home.nix;

  networking.hostName = "${hostName}";

  services.openssh.enable = true;

  system.stateVersion = "24.11";

  # TODO: remove reference to username
  users.users.srv = {
    extraGroups = [ "wheel" "docker" ];
    home = "/home/srv";
    isNormalUser = true;
    shell = pkgs.bash;
  };

  virtualisation.docker.enable = true;
}
