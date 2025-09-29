{
  config,
  lib,
  ...
}:
let
  feature = "borgbackup-srv";
in
{
  config = lib.mkIf config.${feature}.enable {
    # onsite drive
    services.udisks2.enable = true;

    fileSystems."/backup" = {
      device = "/dev/disk/by-uuid/d3b3d7dc-d634-4327-9ea2-9d8daa4ecf4e";
      fsType = "ext4";
    };

    # secrets
    age.secrets = {
      "borgbackup-server-onsite" = {
        file = ../../../secrets/borgbackup-server-onsite.age;
      };
      "borgbackup-server-offsite" = {
        file = ../../../secrets/borgbackup-server-offsite.age;
      };
    };
  };

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
