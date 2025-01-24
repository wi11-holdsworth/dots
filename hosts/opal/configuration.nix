{ 
  pkgs,
  config,
  inputs,
  ... 

}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users.srv = import ./home.nix;
  };

  age = {
    identityPaths = [ "/home/srv/.ssh/id_ed25519 " ];
    secrets = {
      "borgbackup-opal-onsite" = {
        file = ../../secrets/borgbackup-opal-onsite.age;
      };
      "borgbackup-opal-offsite" = {
        file = ../../secrets/borgbackup-opal-offsite.age;
      };
      "api-porkbun" = {
        file = ../../secrets/api-porkbun.age;
        owner = "acme";
      };
    };
  };

  boot.loader = { 
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  
  networking = {
    hostName = "opal";

    firewall = {
      enable = true;
      trustedInterfaces = [ "tailscale0" ];
      interfaces."tailscale0".allowedTCPPorts = [ 80 443 ];
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
    nom
    bottom
  ];

  environment.sessionVariables = {
    FLAKE = "/home/srv/.dots";
    EDITOR = "nvim";
  };

  fileSystems."/repo" = {
    device = "/dev/disk/by-uuid/0AA0-99A6";
    fsType = "vfat";
  };

  services = { 
    jellyfin = {
      enable = true;
      dataDir = "/srv/jellyfin";
    };

    glances.enable = true;

    vaultwarden = {
      enable = true;
      backupDir = "/srv/vaultwarden";
      config = {
        ROCKET_PORT="5001";
        DOMAIN="https://vault.fi33.buzz";
        SIGNUPS_ALLOWED = "false";
        INVITATIONS_ALLOWED = "false";
        SHOW_PASSWORD_HINT="false";
        USE_SYSLOG="true";
        EXTENDED_LOGGING="true";
      };
    };

    openssh.enable = true;

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
          encryption.passCommand = "cat ${config.age.secrets.borgbackup-opal-onsite.path}";

          removableDevice = true;
        };

        offsite = srv // {
          repo = "vuc5c3xq@vuc5c3xq.repo.borgbase.com:repo";
          
          encryption.mode = "repokey-blake2";
          encryption.passCommand = "cat ${config.age.secrets.borgbackup-opal-offsite.path}";

          environment.BORG_RSH = "ssh -i /home/srv/.ssh/id_ed25519";
        };
      };
    nginx = {
      enable = true;

      recommendedProxySettings = true;
      recommendedTlsSettings = true;
      recommendedGzipSettings = true;
      recommendedOptimisation = true;

      # immich video uploads
      clientMaxBodySize = "50000M";

      tailscaleAuth.enable = true;

      virtualHosts = {
        "glances.fi33.buzz" = {
          forceSSL = true;
          useACMEHost = "fi33.buzz";
          locations."/" = {
            proxyPass = "http://localhost:61208";
          };
        };

        "vault.fi33.buzz" = {
          forceSSL = true;
          useACMEHost = "fi33.buzz";
          locations."/" = {
            proxyPass = "http://localhost:5001";
            proxyWebsockets = true;
          };
        };

        "dufs.fi33.buzz" = {
          forceSSL = true;
          useACMEHost = "fi33.buzz";
          locations."/" = {
            proxyPass = "http://localhost:5000";
          };
        };

        "immich.fi33.buzz" = {
          forceSSL = true;
          useACMEHost = "fi33.buzz";
          locations."/" = {
            proxyPass = "http://[::1]:2283";
            proxyWebsockets = true;
          };
        };
      };
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "wi11@duck.com";
    certs."fi33.buzz" = {
      domain = "fi33.buzz";
      extraDomainNames = [ "*.fi33.buzz" ];
      group = "nginx";
      dnsProvider = "porkbun";
      dnsPropagationCheck = true;
      credentialsFile = config.age.secrets."api-porkbun".path;
    };
  };

  users.users.nginx.extraGroups = [ "acme" ];

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
          ];
        };
      };
    };
  };

  users.users.srv = {
    isNormalUser = true;

    home = "/home/srv";

    shell = pkgs.bash;

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

