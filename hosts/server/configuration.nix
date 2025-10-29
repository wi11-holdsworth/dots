{
  # keep-sorted start
  hostName,
  userName,
  util,
  # keep-sorted end
  ...
}:
{
  imports = [
    # keep-sorted start
    ../../modules/nixos/default.nix
    ./hardware-configuration.nix
    # keep-sorted end
  ]
  ++ (util.toImports ../../modules/nixos/features [
    # keep-sorted start
    "borgmatic"
    "intel-gpu"
    # keep-sorted end
  ])
  ++ (util.toImports ../../modules/nixos/bundles [
    "server"
  ]);

  networking.hostName = "${hostName}";

  # hardened openssh
  services.openssh = {
    passwordAuthentication = false;
    allowSFTP = false; 
    challengeResponseAuthentication = false;
    extraConfig = ''
      AllowTcpForwarding yes
      X11Forwarding no
      AllowAgentForwarding no
      AllowStreamLocalForwarding no
      AuthenticationMethods publickey
    '';
  };

  system.stateVersion = "24.11";

  users = {
    groups.${userName} = { };
    users.${userName} = {
      extraGroups = [
        # keep-sorted start
        "docker"
        "wheel"
        # keep-sorted end
      ];
      home = "/home/srv";
      isNormalUser = true;
    };
  };

  virtualisation.docker.enable = true;
}
