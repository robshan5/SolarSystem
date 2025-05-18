{
  description = "Julia project with CairoMakie support";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default = pkgs.mkShell {
          packages = with pkgs;[
            julia-bin
            tree-sitter-grammars.tree-sitter-julia
            libGL
            mesa_glu
            mesa
            clang-tools
            mesa                 # OpenGL implementation
  libGL                # libGL.so for dynamic linking
  libglvnd             # GL vendor-neutral dispatch
  libxkbcommon         # Keyboard input for GL context
  xorg.libX11          # X11 support
  xorg.libXrandr       # Needed by GLFW
  xorg.libXi           # Input extension (mouse, keyboard)
  xorg.libXcursor
  xorg.libXinerama
  xorg.libXext
  glfw                 # GLMakie depends on GLFW for windowing
  fontconfig           # Needed for text rendering
  freetype             # Font rendering
  zlib                 # Compression library used internally
  pkg-config           # Helps with C library discovery
  alsa-lib             # Optional: audio support for future interactivity
          ];

          shellHook = ''
            export JULIA_PROJECT=.
            echo "Julia dev shell is active"
            exec zsh
          '';
        };
      });
}

