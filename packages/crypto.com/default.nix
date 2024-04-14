 { appimageTools, fetchurl }:
let
  pname = "nuclear";
  version = "0.6.30";
  src = fetchurl {
    url = "https://github.com/nukeop/nuclear/releases/download/v${version}/${pname}-v${version}.AppImage";
    hash = "sha256-he1uGC1M/nFcKpMM9JKY4oeexJcnzV0ZRxhTjtJz6xw=";
  };
in
appimageTools.wrapType2 {
  inherit pname version src;
}