{ rizin, jq, runCommand }: {
  canLoadRZGhidra =
    let
      rizin-with-ghidra = rizin.withPlugins (p: [ p.rz-ghidra ]);
    in
    runCommand "rizin-can-load-rz-ghidra" { }
      ''
        export HOME=$(mktemp -d)
        ${rizin-with-ghidra}/bin/rizin -q -c "Lcj" | ${jq}/bin/jq -e '[.[] | select(.name == "ghidra")] | length == 1' > /dev/null
        # needed for Nix to register the command as successful
        touch $out
      '';
}
