{
  inputs,
  config,
  hostname,
  pkgs,
  nixosModules,
  ...
}:

{
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd

    ./hardware-configuration.nix
    "${nixosModules}/common"
    "${nixosModules}/desktop"
    "${nixosModules}/programs"
  ];

  networking.hostName = hostname;

  # https://nixos.wiki/wiki/AMD_GPU
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
  boot.initrd.kernelModules = [ "amdgpu" ];

  # https://wiki.nixos.org/wiki/AMD_GPU
  hardware.amdgpu.initrd.enable = true;
  # Enable amd overclocking
  hardware.amdgpu.overdrive.enable = true;
  #boot.kernelParams = [
  #  "video=DP-1:1920x1080@60"
  #];
  boot.kernelModules = [
    "amdgpu"
    "kvm-amd"
  ];
  boot.blacklistedKernelModules = [ "radeon" ];

  # Lact
  environment.systemPackages = with pkgs; [ lact ];
  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = [ "multi-user.target" ];
  services.lact.enable = true;

  # Enable auto-mounting usbs
  services.udisks2.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?

  services.ollama = {
    enable = true;
    # Optional: preload models, see https://ollama.com/library
    # loadModels = [
    #   "llama3.2:3b"
    #   "deepseek-r1:1.5b"
    # ];
    package = pkgs.ollama-rocm;
  };
  services.open-webui = {
    enable = true;
  };
  services.flatpak.packages = [
    {
      appId = "com.bambulab.BambuStudio";
      origin = "flathub";
    }
    {
      appId = "com.orcaslicer.OrcaSlicer";
      origin = "flathub";
    }
  ];
  services.hardware.openrgb.enable = true;
}
