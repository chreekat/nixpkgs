{ SDL
, SDL_image
, SDL_mixer
, cmake
, curl
, gtk2
, libpng
, libpthreadstubs
, pcre
, perl
, pkgconfig
, vala
, stdenv
}:

stdenv.mkDerivation rec {
  name = "crossfire-${version}";
  version = "1.72.0";

  # FIXME: Use sourceforge mirror
  #src = pkgs.fetchurl {
  #  url = "mirror://sourceforge/${pname}/${name}.tar.gz";
  #  sha256 = "016h1mlhpqxjj25lcvl4fqc19k8ifmsv6df7rhr12fyfcrp5i14d";
  #};

  src = /home/b/Downloads/crossfire-client-1.72.0.tar.bz2;

  # FIXME: This works, but is it a hack?
  patchPhase = ''
    grep -rl '<SDL_image.h>' | xargs sed -i 's#<SDL_image#<SDL/SDL_image#'
  '';

  # FIXME: Add extra goodies like lua, because why not?
  buildInputs = [
    SDL
    SDL_image
    SDL_mixer
    cmake
    curl
    gtk2
    libpng
    libpthreadstubs
    pcre
    perl
    pkgconfig
    vala
  ];

  enableParallelBuilding = true;

  meta = with stdenv.lib; {
    description = "Client for the multiplayer roguelike game Crossfire";
    homepage = http://crossfire.real-time.com/index.html;
    license = licenses.gpl2Plus;
    longDescription = ''
       Crossfire is a multiplayer graphical arcade and adventure game.

       It has certain flavours from other games, especially Gauntlet (TM) and
       Nethack/Moria.

       Any number of players can move around in their own window, finding and
       using items and battle monsters. They can choose to cooperate or compete
       in the same 'world'.

       To play the game you'll need to have access to a local or remote server.
    '';
    maintainers = [ maintainers.chreekat ];
    # FIXME: Confirm all platforms
    platforms = platforms.all;
  };
}
