{ config, lib, ... }:
let
  # declare the module name and its local module dependencies
  feature = "borgbackup-srv";
  dependencies = with config; [ age core ];
  secret = "borgbackup";

  # helper functions
  dependenciesEnabled = (lib.all (dep: dep.enable) dependencies);
  featureEnabled = config.${feature}.enable;
  enabled = featureEnabled && dependenciesEnabled;

in {
  config = lib.mkIf enabled {
    services.borgbackup.jobs = let
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
        exclude = [ "/srv/immich" ];

        encryption.mode = "repokey-blake2";
        encryption.passCommand =
          "cat ${config.age.secrets.borgbackup-server-onsite.path}";

        removableDevice = true;
      };

      offsite = srv // {
        repo = "vuc5c3xq@vuc5c3xq.repo.borgbase.com:repo";

        encryption.mode = "repokey-blake2";
        encryption.passCommand =
          "cat ${config.age.secrets.borgbackup-server-offsite.path}";

        environment.BORG_RSH = "ssh -i /home/srv/.ssh/id_ed25519";
      };
    };

    # onsite drive
    services.udisks2.enable = true;

    fileSystems."/repo" = {
      device = "/dev/sdb1";
      fsType = "vfat";
    };

    # secrets
    age.secrets = {
      "${secret}-server-onsite" = {
        file = ../../../secrets/${secret}-server-onsite.age;
      };
      "${secret}-server-offsite" = {
        file = ../../../secrets/${secret}-server-offsite.age;
      };
    };
  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
