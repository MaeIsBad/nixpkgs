{ rizin
, rizin-unwrapped
, rizinPlugins
, symlinkJoin
, plugins ? [ ]
# Used for tests
, callPackage
 }:
let
  # For clarity
  self = rizin;
in
# Portable builds are needed for the plugins to work
assert rizin-unwrapped.portableBuild;
symlinkJoin
{
  name = "rizin";
  passthru.unwrapped = rizin-unwrapped;
  inherit (rizin-unwrapped) meta;

  preferLocalBuild = true;
  paths = [ rizin-unwrapped ] ++ plugins;
  postBuild = ''
    cd $out/bin/
    for file in ./*; do
      # Rizin loads plugins from a path relative to /proc/self/exe.
      # /proc/self/exe resolves symlinks so we need to copy the resulting binary.
      # This is obviously not ideal, but the binaries weight only a few kibibytes
      # and nix can replace the copy with a hardlink automatically, via nix store optimize
          
      cp --remove-destination "$(readlink "$file")" "$file"
    done
  '';

  # Convenience function to allow for python.withPackages style plugin installation
  passthru.withPlugins = pl:
    let
      newPlugins = pl rizinPlugins;
    in
    self.override (o: { plugins = plugins ++ newPlugins; });

  passthru.tests = callPackage ./tests.nix {};
}
