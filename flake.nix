{
    description = "The reinventing the wheel of the libc";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/23.11";
        flake-utils.url = "github:numtide/flake-utils";
        flake-compat = {
            url = "github:edolstra/flake-compat";
            flake = false;
        };
    };

    outputs = { nixpkgs, ... }: let
        pkgs = import nixpkgs {
            inherit system;
        };
        system = "aarch64-darwin";
    in
    {
        devShell.${system} = pkgs.mkShell {
            buildInputs = with pkgs; [
                libclang
                python311Packages.compiledb
            ];
        };
    };
}
