{
  config,
  lib,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "usbhid"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/8ac17d03-8db2-455f-b73a-06d73022a079";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."luks-bf3ff3bf-7210-4c50-a6bc-feb5bdb6fa0d".device =
    "/dev/disk/by-uuid/bf3ff3bf-7210-4c50-a6bc-feb5bdb6fa0d";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/3854-4FAE";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  fileSystems."/media/games" = {
    device = "/dev/disk/by-uuid/ea672712-282d-4421-bf34-c9a249a9b275";
    fsType = "btrfs";
    options = [
      "compress=zstd"
      "subvol=games"
    ];
  };

  fileSystems."/media/hoard" = {
    device = "/dev/disk/by-uuid/ea672712-282d-4421-bf34-c9a249a9b275";
    fsType = "btrfs";
    options = [
      "compress=zstd"
      "subvol=hoard"
    ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/000dc4be-b250-4870-9284-b761486e8cea"; }
  ];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
