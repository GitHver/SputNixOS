{ pkgs
, lib
, config
, ...
}:

let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.programs.qemuvm;
in {

  options.programs.qemuvm.enable = mkEnableOption ''
    the QEMU virtual machine
  '';

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      #==<< QEMU >>=======================>
      qemu
      quickemu
      (pkgs.writeShellScriptBin "qemu-system-x86_64-uefi" ''
        qemu-system-x86_64 \
          -bios ${pkgs.OVMF.fd}/FV/OVMF.fd \
          "$@"
      '')
      # nemu
    ];
  };

}
