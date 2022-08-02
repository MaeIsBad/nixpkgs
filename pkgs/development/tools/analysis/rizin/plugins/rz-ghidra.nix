{ lib, stdenv, fetchgit, pkg-config, cmake, openssl, rizin-unwrapped }: stdenv.mkDerivation {
  name = "rz-ghidra";
  version = "v0.4.0";

  src = fetchgit {
    url = "https://github.com/rizinorg/rz-ghidra.git";
    rev = "e70aa0f68310f18620153eed57b27fdfb9ba3018";
    sha256 = "sha256-7GZdrxHGSAf1MlMdEpKDOa4Dxu5ckG+IlgAN+mp/U5E=";
    fetchSubmodules = true;
  };
  mesonFlags = [ "-Djsc_folder=.." ];
  buildInputs = [ rizin-unwrapped cmake openssl ];
  nativeBuildInputs = [ pkg-config ];

  meta = with lib; {
    description = "Deep ghidra decompiler and sleigh disassembler integration for rizin";
    homepage = "https://github.com/rizinorg/rz-ghidra";
    license = licenses.lgpl3;
    maintainers = [];
  };
}
