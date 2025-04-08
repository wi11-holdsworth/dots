{ pkgs, inputs, hostName, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/default.nix
    inputs.home-manager.nixosModules.home-manager
    inputs.agenix.nixosModules.default
    inputs.nixvim.nixosModules.nixvim
  ];

  amd-desktop.enable = true;
  gaming.enable = true;
  link2c.enable = true;
  print-and-scan.enable = true;
  speakers.enable = true;

  boot.initrd.luks.devices."luks-b164af31-c1c3-4b4e-83c8-eb39802c2027".device =
    "/dev/disk/by-uuid/b164af31-c1c3-4b4e-83c8-eb39802c2027";

  environment.systemPackages = with pkgs; [
    bat
    dust
    delta
    eza
    fd
    gh
    nixfmt
    nom
    ripgrep-all
    zellij
  ];

  # TODO: remove reference to username
  home-manager = {
    users.will = import ./home.nix;
    backupFileExtension = "backup";
  };

  networking = {
    hostName = "${hostName}";
    networkmanager.enable = true;
  };

  system.stateVersion = "24.11"; # Did you read the comment?

  # TODO: remove reference to username
  users.users.will = {
    description = "Will Holdsworth";
    extraGroups = [ "networkmanager" "wheel" "scanner" "lp" ];
    isNormalUser = true;
  };
}
