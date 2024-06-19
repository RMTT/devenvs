{
  description = "mt's configuration of devenvs";

  inputs = {
    nixpkgs.url = "nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    with flake-utils.lib;
    eachSystem [ system.x86_64-linux ] (system:
      let
        pkgs = import nixpkgs
          {
            system = system;
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

