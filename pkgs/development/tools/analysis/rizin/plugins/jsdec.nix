{ lib, stdenv, fetchFromGitHub, meson, pkg-config, cmake, ninja, openssl, rizin-unwrapped }: stdenv.mkDerivation {
  name = "jsdec";
  version = "v0.4.0";
  meta = with lib; {
    description = "Simple decompiler for Rizin";
    homepage = "https://github.com/rizinorg/jsdec";
    license = with licenses; [
      asl20
      bsd3
      mit
    ];
    maintainers = [];
  };

  src = fetchFromGitHub {
    owner = "rizinorg";
    repo = "jsdec";
    rev = "5ef437d181ad73fc74e406d922f02d09904ae047";
    sha256 = "sha256-Z5QU7IdMGk5IcWbmOVeblfWlo1hfulaYVt3qWRmmYjc=";
  };
  preConfigure = ''
    cd p
  '';
  mesonFlags = [ "-Djsc_folder=/build/source/" ];
  buildInputs = [ rizin-unwrapped openssl ];
  nativeBuildInputs = [ meson pkg-config ninja ];
}
