# How to use
## Import vintagestory flake like this
```
{
  description = "a vintagestory server";
  inputs.vintagestory-nix = {
      url = "github:rschardt/vintagestory-nix";
  };

  outputs = { self, nixpkgs, vintagestory-nix }: {
    nixosConfigurations.<your-hostname> = nixpkgs.lib.nixosSystem {
      modules = [
        vintagestory-nix.nixosModules.vintagestory
      ];
    };
  };
}
```
## Specifiy example vintagestory service in config
```
{
  ...
  services.vintagestory = {
    enable = true;
  };
}
```
