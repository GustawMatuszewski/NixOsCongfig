{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  # Tools needed to build your project
  nativeBuildInputs = with pkgs.buildPackages; [
    # C/C++ toolchain
    gcc
    clang
    cmake
    ninja
    pkg-config
    git
    gdb
    lldb

    # SDL3 dependencies
    sdl3
    pulseaudio
    alsaLib
    libX11
    libXrandr
    libXinerama
    libXcursor
    libXi
    libXext
    libXfixes
    libXrender
    libXdamage
    xorgproto
    xkbcommon

    # Wayland / Vulkan
    wayland
    wayland-protocols
    libdrm
    mesa
    libvulkan
    vulkan-loader
    vulkan-validation-layers

    # Optional but useful
    fribidi
    libusb
    libudev
    libunwind
  ];

  # This runs every time you enter the shell
  shellHook = ''
    echo "Vulkan/SDL3 dev shell loaded. You can run cmake, make, or launch CLion from here."
  '';
}
