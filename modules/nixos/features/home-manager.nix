{
  config,
  hostName,
  inputs,
  lib,
  userName,
  ...
}:
let
  feature = "home-manager";
in
{
  config = lib.mkIf config.${feature}.enable {
    home-manager = {
      users.${userName} = import ../../../hosts/${hostName}/home.nix;
      backupFileExtension = "backup";
      extraSpecialArgs = {
        inherit userName;
      };
      useGlobalPkgs = true;
      useUserPackages = true;
    };
  };

  imports = [ inputs.home-manager.nixosModules.home-manager ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";
}
