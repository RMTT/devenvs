{ pkgs, ... }: {
  embedded = pkgs.callPackage ./embedded.nix { };
}
