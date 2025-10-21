{
  # keep-sorted start
  config,
  hostName,
  # keep-sorted end
  ...
}:
{
  accounts.email =
    let
      certificatesFile = config.age.secrets.protonmail-cert.path;
    in
    {
      inherit certificatesFile;
      accounts =
        let
          # keep-sorted start block=yes
          address = "willholdsworth@pm.me";
          authentication = "login";
          host = "127.0.0.1";
          tls = {
            enable = false;
            useStartTls = true;
            inherit certificatesFile;
          };
          # keep-sorted end
        in
        {
          personal = {
            enable = true;
            # keep-sorted start block=yes
            imap = {
              port = 1143;
              inherit tls;
              inherit authentication;
              inherit host;
            };
            inherit address;
            passwordCommand = "cat ${config.age.secrets."protonmail-${hostName}-password".path}";
            primary = true;
            realName = "Will Holdsworth";
            smtp = {
              port = 1025;
              inherit tls;
              inherit authentication;
              inherit host;
            };
            userName = address;
            # keep-sorted end
          };
        };
    };
  age.secrets."protonmail-cert".file = ../../../secrets/protonmail-cert.age;
}
