{ lib, openjdk11, fetchFromGitHub, jetbrains, fetchpatch }:

openjdk11.overrideAttrs (oldAttrs: rec {
  pname = "jetbrains-jdk";
  version = "11_0_13-b1751.25";

  src = fetchFromGitHub {
    owner = "JetBrains";
    repo = "JetBrainsRuntime";
    rev = "jb${version}";
    sha256 = "sha256-TPNYZUkAoiZfp7Ci3fslKnRNGY1lnyIhXYUt6J31lwI=";
  };
  patches = [
    (fetchpatch {
      url = "https://github.com/JetBrains/JetBrainsRuntime/commit/980cfdf8d04c015bf2ecb4642064e45e3f36630d.patch";
      sha256 = "sha256-/f20sWnlWoObgdgZKWD785q0aRZ5oIP5pzW+AmejLWM=";
    })
  ];
  meta = with lib; {
    description = "An OpenJDK fork to better support Jetbrains's products.";
    longDescription = ''
     JetBrains Runtime is a runtime environment for running IntelliJ Platform
     based products on Windows, Mac OS X, and Linux. JetBrains Runtime is
     based on OpenJDK project with some modifications. These modifications
     include: Subpixel Anti-Aliasing, enhanced font rendering on Linux, HiDPI
     support, ligatures, some fixes for native crashes not presented in
     official build, and other small enhancements.

     JetBrains Runtime is not a certified build of OpenJDK. Please, use at
     your own risk.
    '';
    homepage = "https://confluence.jetbrains.com/display/JBR/JetBrains+Runtime";
    inherit (openjdk11.meta) license platforms mainProgram;
    maintainers = with maintainers; [ edwtjo petabyteboy ];
  };
  passthru = oldAttrs.passthru // {
    home = "${jetbrains.jdk}/lib/openjdk";
  };
})
