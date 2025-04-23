let
  srv = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOeV0NxqIGIXXgLYE6ntkHE4PARceZBp1FTI7kKLBbk8";
  will = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPHAnTQP77HQ/8nbf1oX7xftfKYtbH6MSh83wic0qdBy";
  users = [
    srv
    will
  ];

in
{
  "borgbackup-server-onsite.age".publicKeys = users;
  "borgbackup-server-offsite.age".publicKeys = users;
  "api-porkbun.age".publicKeys = users;
  "davis-app.age".publicKeys = users;
  "davis-admin-password.age".publicKeys = users;
  "api-mailjet.age".publicKeys = users;
  "secret-mailjet.age".publicKeys = users;
  "vaultwarden-admin.age".publicKeys = users;
  "aria2.age".publicKeys = users;
}
