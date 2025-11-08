{ config, pkgs, ... }:

{
  home.username = "gustaw";
  home.homeDirectory = "/home/gustaw";
  home.stateVersion = "25.11";

  nixpkgs.config.allowUnfree = true;

  programs.git.enable = true;

  programs.bash = {
    enable = true;
    shellAliases = {
      works = "echo tak";
      nixBuild = "sudo nixos-rebuild switch --flake /home/gustaw/nixos-dotfiles#gustaw";
    };
  };


  home.packages = with pkgs; [
    # --- Tools ---
    neovim
    gcc
    cmake
    ninja
    pkg-config
    git
    fastfetch
    brave
    obs-studio
    steam
    vscode
    jetbrains.clion
    discord

    # --- SDL3 Wayland build deps ---
    alsa-lib
    pipewire
    libdecor
    libxkbcommon
    dbus
    udev
    wayland
    waylandpp
    wayland-protocols
    mesa
    libGL
    vulkan-headers
    vulkan-loader
    vulkan-tools

    kde.dolphin
  ];
}
