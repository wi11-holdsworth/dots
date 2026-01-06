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

  # external drive
  services.udisks2.enable = true;
  fileSystems."/mnt/external" = {
    device = "/dev/disk/by-uuid/d3b3d7dc-d634-4327-9ea2-9d8daa4ecf4e";
    fsType = "ext4";
    options = [
      "nofail"
      "defaults"
      "user"
      "rw"
      "utf8"
      "noauto"
      "umask=000"
    ];
  };

  networking.hostName = "${hostName}";

  # hardened openssh
  services.openssh = {
    allowSFTP = false;
    extraConfig = ''
      AllowTcpForwarding yes
      X11Forwarding no
      AllowAgentForwarding no
      AllowStreamLocalForwarding no
      AuthenticationMethods publickey
    '';
    settings = {
      KbdInteractiveAuthentication = false;
      PasswordAuthentication = false;
    };
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
