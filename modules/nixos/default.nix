{ 
  ... 

}: {
  imports = [
    #./borgbackup.nix
    ./direnv.nix
    ./nh.nix
    #./nginx.nix
    ./nvim.nix
    ./tailscale.nix
    #./vscode-server.nix
    #./web-service/default.nix
  ];
}
