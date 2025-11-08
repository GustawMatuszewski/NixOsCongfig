{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager.users.gustaw = import ./home.nix;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "Europe/Warsaw";

  services.displayManager.ly.enable = true;
  programs.niri.enable = true;
  programs.xwayland.enable = true;

  services.xserver = { 
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
  };


  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  users.users.gustaw = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [ tree ];
  };

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    nano
    git
    htop
    tree
    wget

    ly
    niri
    xwayland
    xwayland-satellite
    wofi
    waybar
    wlr-randr
    alacritty
    pulseaudio

    vulkan-tools
    vulkan-loader
    mesa

    gamescope
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  #GPU DRIVERS COMMENT OUT THE NOT NEEDED !
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  #hardware.nvidia = {
  # package = pkgs.nvidia.x11; modesettings.enable = true;  
  #}
  

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.11";
}
