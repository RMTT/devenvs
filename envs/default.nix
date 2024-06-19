{ pkgs, ... }: {
  zephyr = pkgs.callPackage ./zephyr.nix { };
}
