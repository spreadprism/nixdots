# This file defines overlays
{inputs, ...}: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final.pkgs;

  codelldb = final: prev: {
    codelldb = prev.vscode-extensions.vadimcn.vscode-lldb.overrideAttrs (_: {
      postPatch = let
        # grab the bin at .share/vscode/extensions/vadimcn.vscode-lldb/adapter
      in ''
        mkdir -p $out/bin
        cp -r ${prev.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb $out/bin
      '';
    });
  };
  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.system;
    };
  };
}
