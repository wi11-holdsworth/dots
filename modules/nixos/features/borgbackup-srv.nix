{
  config,
  lib,
  pkgs,
  ...
}:
let
  feature = "borgbackup-srv";

  secret = "borgbackup";
  notify =
    {
      tag,
      msg,
      location,
    }:
    ''
      ${pkgs.curl}/bin/curl -H "X-Tags: ${tag},BorgBackup,Server,${location}"  -d "${msg}" ${config.services.ntfy-sh.settings.base-url}/backups
    '';
  notifySuccess =
    location:
    notify {
      tag = "tada";
      msg = "Backup succeeded";
      inherit location;
    };
  notifyFailure =
    location:
    notify {
      tag = "tada";
      msg = "Backup failed, check logs";
      inherit location;
    };

in
{
  config = lib.mkIf config.${feature}.enable {
    services.borgbackup.jobs =
      let
        srv = location: {
          paths = [
            "/srv"
            "/home/srv/.config/syncthing"
            "/home/srv/Sync"
          ];

          compression = "auto,zstd";

          startAt = "*-*-* 04:00:00 Australia/Melbourne";

          prune.keep = {
            daily = 7;
            weekly = 4;
            monthly = 6;
          };

          postHook = ''
            if [ $exitStatus -eq 0 ]; then
              ${notifySuccess location}
            else
              ${notifyFailure location}
            fi
          '';
        };

      in
      {
        onsite = srv "onsite" // {
          repo = "/repo";
          exclude = [ "/srv/immich" ];

          encryption.mode = "repokey-blake2";
          encryption.passCommand = "cat ${config.age.secrets.borgbackup-server-onsite.path}";

          removableDevice = true;
        };

        offsite = srv "offsite" // {
          repo = "vuc5c3xq@vuc5c3xq.repo.borgbase.com:repo";

          encryption.mode = "repokey-blake2";
          encryption.passCommand = "cat ${config.age.secrets.borgbackup-server-offsite.path}";

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
