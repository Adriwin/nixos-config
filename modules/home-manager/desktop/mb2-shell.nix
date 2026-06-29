{
  pkgs ? import <nixpkgs> { },
}:

let
  # Force the entire environment and packages to be 32-bit (i686)
  pkgs32 = pkgs.pkgsi686Linux;
in
pkgs32.mkShell {
  name = "mb2-native-env";

  # List of packages required to run the game
  buildInputs = with pkgs32; [
    libx11
    libxext
    libGL
    openal
    alsa-lib
    glibc
    zlib
    SDL2
    stdenv.cc.cc.lib # GCC Standard C++ library (libstdc++)
  ];

  shellHook = ''
    # Load dynamic library paths (LD_LIBRARY_PATH)
    export LD_LIBRARY_PATH="${pkgs32.libGL}/lib:${pkgs32.openal}/lib:${pkgs32.libx11}/lib:${pkgs32.libxext}/lib:${pkgs32.alsa-lib}/lib:${pkgs32.zlib}/lib:${pkgs32.SDL2}/lib:${pkgs32.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH"

    export SDL_VIDEO_FULLSCREEN_DISPLAY=2

    echo "========================================================="
    echo " Movie Battles 2 environment ready (with Steam Overlay)!"
    echo " To launch the game, type: ./mbii.i386"
    echo "========================================================="
  '';
}
