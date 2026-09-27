{ pkgs, lib, config, ... }:

with lib;
let
  cnfg = config.qemuvm;
in

{
  options.qemuvm.enable = mkOption {
    type = types.bool;
    default = false;
    # description = "QEMU virtual machines";
  };

  config = mkIf cnfg.enable {
    environment.systemPackages = with pkgs; [
      #==<< QEMU >>=======================>
      qemu
      quickemu
      (pkgs.writeShellScriptBin "qemu-system-x86_64-uefi" ''
        qemu-system-x86_64 \
          -bios ${pkgs.OVMF.fd}/FV/OVMF.fd \
          "$@"
      '')
    ];
  };
}
