let
  # keep-sorted start
  desktop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPHAnTQP77HQ/8nbf1oX7xftfKYtbH6MSh83wic0qdBy";
  laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOeu5HwuRayiXIZE35AxX6PmxHxbXZ8NTlTgHrcPwhcQ";
  srv = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOeV0NxqIGIXXgLYE6ntkHE4PARceZBp1FTI7kKLBbk8";
  # keep-sorted end

  users = [
    # keep-sorted start
    desktop
    laptop
    srv
    # keep-sorted end
  ];
in
{
  # keep-sorted start
  "api-miniflux.age".publicKeys = users;
  "borgbackup-server-offsite.age".publicKeys = users;
  "borgbackup-server-onsite.age".publicKeys = users;
  "copyparty-will.age".publicKeys = users;
  "immich.age".publicKeys = users;
  "jellyfin.age".publicKeys = users;
  "jellyseerr.age".publicKeys = users;
  "lidarr.age".publicKeys = users;
  "miniflux-creds.age".publicKeys = users;
  "paperless.age".publicKeys = users;
  "porkbun-api.age".publicKeys = users;
  "protonmail-cert.age".publicKeys = users;
  "protonmail-password.age".publicKeys = users;
  "prowlarr.age".publicKeys = users;
  "radarr.age".publicKeys = users;
  "radicale.age".publicKeys = users;
  "sonarr.age".publicKeys = users;
  "vaultwarden-admin.age".publicKeys = users;
  # keep-sorted end
}
