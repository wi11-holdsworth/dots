{ 
  ... 

}: {
  imports = [
    ./borgbackup.nix
    ./nginx.nix
    ./nvim.nix
    ./tailscale.nix
    ./web-service/default.nix
  ];
}
