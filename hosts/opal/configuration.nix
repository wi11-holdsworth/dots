{ 
  pkgs,
  host,
  user,
  shell,
  editor,
  dots,
  ... 

}: {
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/nixos
    ];

  boot.loader = { 
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  
  networking = {
    hostName = host;

    firewall = {
      enable = true;
      trustedInterfaces = [ "tailscale0" ];
      allowedTCPPorts = [ 80 443 ];
    };
  }; 

  time.timeZone = "Australia/Melbourne";

  i18n.defaultLocale = "en_AU.UTF-8";

  environment.systemPackages = with pkgs; [
    nh
    gh
    eza
    ripgrep-all
    fd
    dust
    bat
  ];

  environment.sessionVariables = {
    FLAKE = dots;
    EDITOR = editor;
  };

  fileSystems."/repo" = {
    device = "/dev/disk/by-uuid/0AA0-99A6";
    fsType = "vfat";
  };

  services = { 
    immich = {
      enable = true;
      port = 2283;
      mediaLocation = "/srv/immich";
    };

    tailscale.enable = true;

    udisks2.enable = true;

    borgbackup.jobs = 
      let 
        srv = {
          paths = "/srv";

          compression = "auto,zstd";

          startAt = "*-*-* 04:00:00 Australia/Melbourne";

          prune.keep = {
            daily = 7;
            weekly = 4;
            monthly = 6;
          };
        };

      in {
        onsite = srv // {
          repo = "/repo";
          
          encryption.mode = "repokey-blake2";
          encryption.passCommand = "cat ${dots}/hosts/${host}/secret/onsitePw";

          removableDevice = true;
        };

        offsite = srv // {
          repo = "vuc5c3xq@vuc5c3xq.repo.borgbase.com:repo";
          
          encryption.mode = "repokey-blake2";
          encryption.passCommand = "cat ${dots}/hosts/${host}/secret/offsitePw";

          environment.BORG_RSH = "ssh -i /home/${user}/.ssh/id_ed25519";
        };
      };
    nginx = {
      enable = true;

      recommendedProxySettings = true;
      recommendedTlsSettings = true;
      recommendedGzipSettings = true;
      recommendedOptimisation = true;

      virtualHosts."${host}.mink-codlet.ts.net" = {
        forceSSL = true;
        sslCertificate = "/etc/ssl/certs/${host}.mink-codlet.ts.net.crt";
        sslCertificateKey = "/etc/ssl/certs/${host}.mink-codlet.ts.net.key";

        locations = {
          "/dufs/" = {
            proxyPass = "http://127.0.0.1:5000";
          };

          "/vaultwarden/" = {
            proxyPass = "http://127.0.0.1:5001";
            proxyWebsockets = true;
          };

          # immich doesn't support base paths yet
          "/" = {
            proxyPass = "http://[::1]:2283";
            proxyWebsockets = true;
          };
        };
      };
    };
  };

  virtualisation = {
    docker.enable = true;

    oci-containers = {
      backend = "docker";

      containers = {
        dufs = {
          autoStart = true;

          image = "sigoden/dufs";

          ports = [
            "5000:5000"
          ];

          volumes = [
            "/srv/dufs:/data"
          ];

          cmd = [
            "/data"
            "-A"
            "--path-prefix=/dufs"
          ];
        };

        vaultwarden = {
          autoStart = true;

          image = "vaultwarden/server";

          ports = [
            "5001:80"
          ];

          volumes = [
            "/srv/vaultwarden:/data"
          ];

          environment = {
            DOMAIN="https://${host}.mink-codlet.ts.net/vaultwarden";
            SIGNUPS_ALLOWED = "false";
            INVITATIONS_ALLOWED = "false";
            SHOW_PASSWORD_HINT="false";
            USE_SYSLOG="true";
            EXTENDED_LOGGING="true";
          };
        };
      };
    };
  };

  users.users.${user} = {
    isNormalUser = true;

    home = "/home/${user}";

    shell = pkgs.${shell};

    extraGroups = [ "wheel" "docker" ];
  };

  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    optimise.automatic = true;
  };

  system.stateVersion = "24.11";
}

