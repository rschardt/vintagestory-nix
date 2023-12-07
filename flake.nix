{
  description = "Vintage Story dedicated server";

  outputs = _: {
    nixosModules = {
      valheim = import ./modules/vintagestory.nix;
    };
  };
}
