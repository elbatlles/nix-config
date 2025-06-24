{
  description = "Entornos de desarrollo para IA y Web";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

  outputs = { self, nixpkgs }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    devShells.${system} = {
      ia = pkgs.mkShell {
        packages = with pkgs.python311Packages; [
          jupyterlab
          openai
          langchain
          ipykernel
          pandas
          numpy
        ];
      };

      web = pkgs.mkShell {
        packages = with pkgs; [
          nodejs_18
          yarn
          typescript
          eslint
          vite
        ];
      };
    };

    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
        ];
      };
    };
  };
}
