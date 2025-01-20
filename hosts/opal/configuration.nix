{ 
  pkgs,
  config,
  inputs,
  ... 

}: {
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/nixos
      inputs.sops-nix.nixosModules.sops
    ];

  sops = {
    defaultSopsFile = /home/srv/.dots/secrets.yaml;
    defaultSopsFormat = "yaml";
    
    age.keyFile = "/home/srv/.config/sops/age/keys.txt";

    secrets = {
      "borgbackup/opal" = {
        onsite = {};
        offsite = {};
      };
      api = {
        njalla = {};
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
    nom
    bottom
    sops
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
          encryption.passCommand = "cat ${config.sops.secrets."borgbackup/opal/onsite".path}";

          removableDevice = true;
        };

        offsite = srv // {
          repo = "vuc5c3xq@vuc5c3xq.repo.borgbase.com:repo";
          
          encryption.mode = "repokey-blake2";
          encryption.passCommand = "cat ${config.sops.secrets."borgbackup/opal/offsite".path}";

          environment.BORG_RSH = "ssh -i /home/srv/.ssh/id_ed25519";
        };
      };
    caddy = {
      enable = true;

      extraConfig = ''
        tls {
          dns njalla {
            api_token 
          }
        }
      '';

      # allow large immich uploads
 #     clientMaxBodySize = "50000M";

      virtualHosts."dufs.clinomania.net".extraConfig = ''
        reverse_proxy localhost:5000 
        '';

      virtualHosts."vault.clinomania.net".extraConfig = ''
        reverse_proxy localhost:5001 
        '';

      virtualHosts."immich.clinomania.net".extraConfig = ''
        reverse_proxy 0.0.0.0:2283 
        '';
      
      virtualHosts."kuma.clinomania.net".extraConfig = ''
        reverse_proxy localhost:5002
        '';
    };
#    acme = {
#      acceptTerms = true;
#      defaults.email = "wi11@duck.com";
#      certs."clinomania.net" = {
#        domain = "clinomnaia.net";
#        extraDomainNames = [ "*.clinomania.net" ];
#        dnsProvier = "njalla";
#      };
#    };
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
            DOMAIN="https://vault.clinomania.net";
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

