{
  config,
  pkgs,
  ...
}:
let
  jobConfig = {
    compression = "auto,zlib";
    doInit = false;
    preHook = ''
      /run/wrappers/bin/sudo -u postgres ${pkgs.postgresql}/bin/pg_dumpall > /srv/backup/database/postgres/dump.sql
    '';
    postHook = ''
      rm /srv/backup/database/postgres/dump.sql
    '';
    prune.keep = {
      daily = 7;
      weekly = 4;
      monthly = 6;
      yearly = 1;
    };
    readWritePaths = [
      "/srv/backup"
    ];
    startAt = "*-*-* 03:00:00";
    extraCreateArgs = [ "-v" ];
  };
in
{
  services.borgbackup = {
    jobs = {
      onsite = {
        encryption = {
          passCommand = "cat ${config.age.secrets.borgbackup-onsite.path}";
          mode = "repokey-blake2";
        };
        removableDevice = true;
        repo = "/mnt/external/backup/take2";
      }
      // jobConfig;
      offsite = {
        encryption = {
          passCommand = "cat ${config.age.secrets.borgbackup-offsite.path}";
          mode = "repokey-blake2";
        };
        environment.BORG_RSH = "ssh -i /home/srv/.ssh/id_ed25519";
        repo = "ssh://vuc5c3xq@vuc5c3xq.repo.borgbase.com/./repo";
      }
      // jobConfig;
    };
  };

  age.secrets = {
    borgbackup-onsite.file = ../../../secrets/borgbackup-onsite.age;
    borgbackup-offsite.file = ../../../secrets/borgbackup-offsite.age;
  };
}
