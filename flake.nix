{
  description = "mt's configuration of devenvs";

  inputs = {
    nixpkgs.url = "nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";

    zephyr-nix.url = "github:adisbladis/zephyr-nix";
  };

  outputs = { nixpkgs, flake-utils, zephyr-nix, ... }:
    with flake-utils.lib;
    eachSystem [ system.x86_64-linux ] (system:
      let
        zephyr = zephyr-nix.packages.x86_64-linux;
        pkgs = import nixpkgs
          {
            system = system;
            overlays = [
              (self: super: {
                zephyr = zephyr;
              })
            ];
            config.allowUnfree = true;
            config.segger-jlink.acceptLicense = true;
            config.permittedInsecurePackages = [
              "segger-jlink-qt4-794l"
            ];
          };
      in
      {
        formatter = pkgs.nixpkgs-fmt;
        devShells = import ./envs pkgs;
      }
    );
}

