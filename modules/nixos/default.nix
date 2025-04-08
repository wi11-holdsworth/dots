{ lib, ... }: {
  imports = [
    # TODO autogenerate this
    ./features/age.nix
    ./features/amd-desktop.nix
    ./features/aria2.nix
    ./features/borgbackup-srv.nix
    ./features/core.nix
    ./features/direnv.nix
    ./features/dufs.nix
    ./features/gaming.nix
    ./features/glances.nix
    ./features/home-manager.nix
    ./features/immich.nix
    ./features/jellyfin.nix
    ./features/link2c.nix
    ./features/nginx.nix
    ./features/nh.nix
    ./features/nixvim.nix
    ./features/print-and-scan.nix
    ./features/speakers.nix
    ./features/tailscale.nix
    ./features/vscode-server.nix
    ./features/vaultwarden.nix
  ];

  core.enable = lib.mkDefault true;
  direnv.enable = lib.mkDefault true;
  home-manager.enable = lib.mkDefault true;
  nh.enable = lib.mkDefault true;
  nixvim.enable = lib.mkDefault true;
  tailscale.enable = lib.mkDefault true;
}
