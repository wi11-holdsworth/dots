{ lib, ... }: {
  imports = [
    ./features/aria2.nix
    ./features/borgbackup-srv.nix
    ./features/direnv.nix
    ./features/dufs.nix
    ./features/glances.nix
    ./features/immich.nix
    ./features/jellyfin.nix
    ./features/nginx.nix
    ./features/nh.nix
    ./features/nixvim.nix
    ./features/tailscale.nix
    ./features/vscode-server.nix
    ./features/vaultwarden.nix
  ];

  direnv.enable = lib.mkDefault true;
  nh.enable = lib.mkDefault true;
  nixvim.enable = lib.mkDefault true;
  tailscale.enable = lib.mkDefault true;
}
