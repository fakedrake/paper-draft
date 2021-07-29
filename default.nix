{ pkgs ? import <nixpkgs> {}} :
let
  dot2tex = pkgs.python2Packages.dot2tex;
  tectonic_5 = pkgs.callPackage ./tectonic_pkg.nix {
    rustPlatform = pkgs.rustPackages.rustPlatform;
    harfbuzz = pkgs.harfbuzzFull;
  };
  lua = pkgs.luaPackages.luaposix;
  tex = with pkgs; (texlive.combine {
    inherit (texlive)
      scheme-small
      latexmk
      babel
      acmart
      xstring
      environ
      hyperxmp
      ifmtarg
      luacode
      ncctools
      comment
      preprint

      abstract
      acronym
      algorithm2e
      amsfonts
      amsmath
      apacite
      appendix
      auxhook
      bbding
      bbold
      braket
      cancel
      ccicons
      checkend
      cmap
      colortbl
      comma
      coollist
      coolstr
      curves
      datenumber
      decimal
      dirtytalk
      draftwatermark
      enumitem
      epigraph
      epstopdf
      esdiff
      etex
      fancybox
      fancyhdr
      fancyvrb
      fixfoot
      fixme
      float
      forloop
      fp
      gb4e
      geometry
      graphics
      harmony
      hyperref
      index
      kvoptions
      listings
      mathabx
      mathtools
      mciteplus
      microtype
      multirow
      natbib
      nomencl
      nopageno
      physics
      SIunits
      stmaryrd
      soul
      subfig
      subfigure
      textcase
      tfrupee
      tipa
      totpages
      trimspaces
      units
      wrapfig
      xcolor
      luapackageloader ; });
in pkgs.stdenv.mkDerivation {
  pname = "phd-thesis";
  version = "0.0.1";
  src = ./.;
  buildInputs = [tex dot2tex lua ];
  phases = "buildPhase";
  buildPhase = ''
  ./build.sh
  '';
  # ${./.} is the path to /nix/store/... ${toString ./.} evaluates to
  # the current directory.
  LUA_PATH = "${toString ./.}/lua/?.lua;$LUA_PATH";
}
