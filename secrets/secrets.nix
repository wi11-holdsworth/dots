let
  srv = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOeV0NxqIGIXXgLYE6ntkHE4PARceZBp1FTI7kKLBbk8"; 

in {
  "borgbackup-opal-onsite.age".publicKeys = [ srv ];
  "borgbackup-opal-offsite.age".publicKeys = [ srv ];
  "api-porkbun.age".publicKeys = [ srv ];
  "davis-app.age".publicKeys = [ srv ];
  "davis-admin-password.age".publicKeys = [ srv ];
  "api-mailjet.age".publicKeys = [ srv ];
  "secret-mailjet.age".publicKeys = [ srv ];
  "vaultwarden-admin.age".publicKeys = [ srv ];
}
