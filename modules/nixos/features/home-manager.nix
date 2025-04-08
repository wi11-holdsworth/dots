{ config, hostName, inputs, lib, userName, ... }:
let
  feature = "home-manager";
  cfg = config.${feature};

in {
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  options.${feature}.enable = lib.mkEnableOption "enables ${feature}";

  config = lib.mkIf cfg.enable {

    home-manager = {
      users.${userName} = import ../../../hosts/${hostName}/home.nix;
      backupFileExtension = "backup";
      extraSpecialArgs = { inherit userName; };
      useGlobalPkgs = true;
      useUserPackages = true;
    };
  };
}
