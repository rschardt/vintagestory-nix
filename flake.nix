{
  description = "Vintage Story dedicated server";

  outputs = _: {
    nixosModules = {
      vintagestory = import ./modules/vintagestory.nix;
    };
  };
}
