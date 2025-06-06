{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  # Change this to your username.
  user = "toft";
  # Change this to match your system's CPU.
  platform = "amd";
  # Change this to specify the IOMMU ids you wrote down earlier.
  vfioIds = ["1002:744c" "1002:ab30"];

  cfg = config.modules.vm;
in {
  options = {
    modules.vm.enable = mkEnableOption "vm";
  };

  config = mkIf cfg.enable {
    boot = {
      kernelModules = ["kvm-${platform}" "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio"];
      kernelParams = ["${platform}_iommu=on" "${platform}_iommu=pt" "kvm.ignore_msrs=1"];
      extraModprobeConfig = "options vfio-pci ids=${builtins.concatStringsSep "," vfioIds}";
    };
    # Add a file for looking-glass to use later. This will allow for viewing the guest VM's screen in a
    # performant way.
    systemd.tmpfiles.rules = [
      "f /dev/shm/looking-glass 0660 ${user} qemu-libvirtd -"
    ];
    # Add virt-manager and looking-glass to use later.
    environment.systemPackages = with pkgs; [
      virt-manager
      looking-glass-client
    ];
    # Enable virtualisation programs. These will be used by virt-manager to run your VM.
    virtualisation = {
      libvirtd = {
        enable = true;
        extraConfig = ''
          user="${user}"
        '';
        # Don't start any VMs automatically on boot.
        onBoot = "ignore";
        # Stop all running VMs on shutdown.
        onShutdown = "shutdown";
        qemu = {
          package = pkgs.qemu_kvm;
          ovmf.enable = true;
          verbatimConfig = ''
            namespaces = []
            user = "${user}"
          '';
        };
      };
    };
    users.users.${user}.extraGroups = ["kvm" "libvirtd" "disk"];
  };
}
