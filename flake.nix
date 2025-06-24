{
  description = "Entornos de desarrollo para IA y Web";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

  outputs = { self, nixpkgs }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    devShells = {
      ia = pkgs.mkShell {
        packages = with pkgs.python311Packages; [
          ipykernel
          jupyterlab
          openai
          langchain
          pandas
          numpy
        ];
        shellHook = ''
          echo "Entorno IA activado (Jupyter, LangChain, OpenAI)"
        '';
      };

      web = pkgs.mkShell {
        packages = with pkgs; [
          nodejs_18
          yarn
          typescript
          eslint
          vite
        ];
        shellHook = ''
          echo "Entorno Web activado (Node.js, Vite, TypeScript)"
        '';
      };
    };
  };
}
