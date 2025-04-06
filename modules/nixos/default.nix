{ lib, ... }: {
  imports = [
    ./features/amd-desktop.nix # depends on system
    ./features/aria2.nix # depends on nginx, age
    ./features/borgbackup-srv.nix # depends on nginx, age
    ./features/direnv.nix # depends on bash, system
    ./features/dufs.nix # depends on nginx
    ./features/gaming.nix # depends on amd-desktop
    ./features/glances.nix # depends on nginx
    ./features/immich.nix # depends on nginx, age
    ./features/jellyfin.nix # depends on nginx
    ./features/link2c.nix # depends on amd-desktop
    ./features/nginx.nix # depends on age, system
    ./features/nh.nix # depends on system
    ./features/nixvim.nix # depends on system
    ./features/print-and-scan.nix # depends on system
    ./features/speakers.nix # depends on system
    ./features/system.nix # depends on home-manager
    ./features/tailscale.nix # depends on system
    ./features/vscode-server.nix # depends on system
    ./features/vaultwarden.nix # depends on nginx, age
  ];

  direnv.enable = lib.mkDefault true;
  nh.enable = lib.mkDefault true;
  nixvim.enable = lib.mkDefault true;
  system.enable = lib.mkDefault true;
  tailscale.enable = lib.mkDefault true;
}
