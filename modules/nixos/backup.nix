service: servicecfg:
{
  # keep-sorted start
  pkgs,
  config,
  lib,
# keep-sorted end
}:
let
  notify =
    {
      tag,
      msg,
      location,
    }:
    ''
      ${pkgs.curl}/bin/curl \
        -H "X-Tags: ${tag},BorgBackup,Server,${location}" \
        -d "${msg}" \
        ${config.services.ntfy-sh.settings.base-url}/backups
    '';
  notifySuccess =
    context:
    notify {
      tag = "tada";
      msg = "Backup succeeded";
      location = "${context}/${service}";
    };
  notifyFailure =
    context:
    notify {
      tag = "rotating_light";
      msg = "Backup failed, check logs";
      location = "${context}/${service}";
    };
  job =
    context: contextcfg:
    lib.nameValuePair "${context}-${service}" (
      {
        compression = "auto,zstd";
        startAt = "*-*-* 04:00:00 Australia/Melbourne";
        prune.keep = {
          daily = 7;
          weekly = 4;
          monthly = 6;
        };
        postHook = ''
          if [ $exitStatus -eq 0 ]; then
            ${notifySuccess context}
          else 
            ${notifyFailure context}
          fi
        '';
      }
      // contextcfg
      // servicecfg
    );
in
builtins.listToAttrs [
  (job "onsite" {
    repo = "/backup/repo";
    encryption = {
      mode = "repokey-blake2";
      passCommand = "cat ${config.age.secrets.borgbackup-server-onsite.path}";
    };
  })
  (job "offsite" {
    repo = "vuc5c3xq@vuc5c3xq.repo.borgbase.com:repo";
    encryption = {
      mode = "repokey-blake2";
      passCommand = "cat ${config.age.secrets.borgbackup-server-offsite.path}";
    };
    environment.BORG_RSH = "ssh -i /home/srv/.ssh/id_ed25519";
  })
]
