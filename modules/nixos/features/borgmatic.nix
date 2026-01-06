{
  # keep-sorted start
  config,
  lib,
  # keep-sorted end
  ...
}:
{
  # service
  services.borgmatic = {
    enable = true;
    settings = {
      # keep-sorted start block=yes
      compression = "auto,zlib";
      encryption_passcommand = "cat ${config.age.secrets.borgmatic.path}";
      keep_daily = 7;
      keep_monthly = 6;
      keep_weekly = 4;
      keep_yearly = 1;
      ntfy = {
        topic = "backups";
        server = config.services.ntfy-sh.settings.base-url;
        finish = {
          title = "Ping!";
          message = "Your backups have succeeded :)";
          tags = "tada,BorgBackup,Server";
        };
        fail = {
          title = "Ping!";
          message = "Your backups have failed :(";
          tags = "rotating_light,BorgBackup,Server";
        };
        states = [
          "finish"
          "fail"
        ];
      };
      repositories = [
        {
          path = "/mnt/external/backup/repo";
          label = "onsite";
          # encryption = "repokey-blake2";
        }
        {
          path = "ssh://vuc5c3xq@vuc5c3xq.repo.borgbase.com/./repo";
          label = "offsite";
          # encryption = "repokey-blake2";
        }
      ];
      retries = 3;
      retry_wait = 10;
      ssh_command = "ssh -i /home/srv/.ssh/id_ed25519";
      # keep-sorted end
    };
  };

  # postgres
  services.postgresql.ensureUsers = [
    {
      name = "root";
    }
  ];
  systemd.services.postgresql.postStart = lib.mkAfter ''
    /run/current-system/sw/bin/psql postgres -c "GRANT pg_read_all_data TO root"
  '';
  systemd.services.borgmatic.path = [
    config.services.postgresql.package
  ];

  # credentials
  systemd.services.borgmatic.serviceConfig.LoadCredential = [
    "borgmatic-pg:${config.age.secrets.borgmatic-pg.path}"
  ];

  # onsite drive

  # secrets
  age.secrets = {
    "borgmatic".file = ../../../secrets/borgmatic.age;
    "borgmatic-pg".file = ../../../secrets/borgmatic-pg.age;
  };
}
