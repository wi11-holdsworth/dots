{ pkgs, inputs, ... }: {
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
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users.srv = import ./home.nix;
  };

  # TODO: remove reference to username
  age.identityPaths = [ "/home/srv/.ssh/id_ed25519" ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # TODO: remove reference to hostname
  networking = {
    hostName = "server";
    firewall.enable = true;
  };

  time.timeZone = "Australia/Melbourne";

  i18n.defaultLocale = "en_AU.UTF-8";

  environment.systemPackages = with pkgs;
    [ nh gh eza ripgrep-all fd dust bat nom delta zellij ]
    ++ ([ agenix.packages.x86_64-linux.default ]);

  # TODO: remove reference to username
  environment.sessionVariables = {
    FLAKE = "/home/srv/.dots";
    EDITOR = "nvim";
  };

  services = {
    openssh.enable = true;
    glances.enable = true;
  };

  virtualisation.docker.enable = true;

  # TODO: remove reference to username
  users.users.srv = {
    isNormalUser = true;

    home = "/home/srv";

    shell = pkgs.bash;

    extraGroups = [ "wheel" "docker" ];
  };

  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];

    optimise.automatic = true;
  };

  system.stateVersion = "24.11";
}

