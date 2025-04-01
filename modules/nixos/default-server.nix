{ 
  ... 

}: {
  imports = [
    ./borgbackup.nix
    ./direnv.nix
    ./nginx.nix
    ./nh.nix
    ./nvim.nix
    ./tailscale.nix
    ./vscode-server.nix
    ./web-service/default.nix
  ];
}
