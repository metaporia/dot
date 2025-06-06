{ lib, stdenv, fetchurl, pkg-config, SDL, libGLU, libGL, openal, lua, libdevil
, freetype, physfs, libmodplug, mpg123, libvorbis, libogg, libmng }:

stdenv.mkDerivation rec {
  pname = "love";
  version = "0.7.2";

  src = fetchurl {
    url =
      "https://github.com/love2d/love/releases/download/${version}/love-${version}-linux-src.tar.gz";
    sha256 = "0s7jywkvydlshlgy11ilzngrnybmq5xlgzp2v2dhlffwrfqdqym5";
  };

  # see discussion on arch linux user repository (https://aur.archlinux.org/packages/love07/?setlang=cs#comment-684696)
  patches = [ ./0.7-gl-prototypes.patch ];

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [
    SDL
    libGLU
    libGL
    openal
    lua
    libdevil
    freetype
    physfs
    libmodplug
    mpg123
    libvorbis
    libogg
    libmng
  ];

  preConfigure = ''
    luaoptions="${"''"} lua luajit "
    for i in lua luajit-; do
      for j in 5 5.0 5.1 5.2 5.3 5.4; do
        luaoptions="$luaoptions $i$j "
      done
    done
    luaso="$(echo "${lua}/lib/"lib*.so.*)"
    luaso="''${luaso##*/lib}"
    luaso="''${luaso%%.so*}"
    luaoptions="$luaoptions $luaso"
    sed -e "s/${"''"} lua lua.*;/$luaoptions;/" -i configure

    luaincdir="$(echo "${lua}/include"/*/ )"
    test -d "$luaincdir" && {
      export NIX_CFLAGS_COMPILE="$NIX_CFLAGS_COMPILE -I$luaincdir"
    } || true
  '';

  # after 24.11 SDL changed from SDL1 -> SDL_compat (SDL2 compat layer)
  # SDL_compat doesn't expose a `dev` output. so not sure how to include the
  # headers

  NIX_CFLAGS_COMPILE = ''
    -I${freetype.dev}include/freetype2
    -I${SDL.dev}/include/SDL
  '';

  meta = {
    homepage = "https://love2d.org";
    description = "A Lua-based 2D game engine/scripting language";
    license = lib.licenses.zlib;
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.raskin ];
  };
}
