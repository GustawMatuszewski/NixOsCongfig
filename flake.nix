{
  description = "My NixOS + dev shell flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ self, flake-parts, nixpkgs, home-manager, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      flake = {
        nixosConfigurations = {
          gustaw = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = { inherit inputs; };
            modules = [
              ./configuration.nix
              home-manager.nixosModules.home-manager
            ];
            configuration = {
              home-manager.users.gustaw = { ... }: {
                programs.home-manager.enable = true;
              };
            };
          };
        };

        devShells.x86_64-linux = {
          default = let
            pkgs = import nixpkgs { system = "x86_64-linux"; };
          in pkgs.mkShell {
            nativeBuildInputs = with pkgs.buildPackages; [
              # C/C++ toolchain
              gcc clang cmake ninja git gdb lldb pkg-config neovim

              # SDL3 & X11 dependencies
              sdl3 pulseaudio alsa-lib xorg.libX11 xorg.libXrandr xorg.libXinerama xorg.libXcursor
              xorg.libXi xorg.libXext xorg.libXfixes xorg.libXrender xorg.libXdamage xorg.xorgproto
              xorg.libXScrnSaver xorg.libXtst xcbuild

              # Wayland / Vulkan
              wayland wayland-protocols libdrm mesa vulkan-tools vulkan-loader
              vulkan-validation-layers
            ];

            shellHook = ''
              echo "Vulkan/SDL3 dev shell loaded. You can run cmake, make, or launch CLion from here."
            '';
          };
        };
      };
    };
}
