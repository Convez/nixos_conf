{ nixpkgs, nixunstable, nixmaster, home-manager, ... }:
system: rec {
  inherit system;
  # This is equivalent to nixpgks.config
  config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };
  # Easy access to the nixpkg channels
  stable = import nixpkgs { inherit system config; };
  unstable = import nixunstable { inherit system config; };
  master = import nixmaster { inherit system config; };

  # Use project library functions
  helper = import ./default.nix { inherit home-manager nixpkgs; };
}
