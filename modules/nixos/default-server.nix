{ 
  ... 

}: {
  imports = [
    ./web-service/default.nix
    ./borgbackup.nix
    ./nginx.nix
    ./nvim.nix
    ./tailscale.nix
    ./direnv.nix
    ./vscode-server.nix
  ];
}
