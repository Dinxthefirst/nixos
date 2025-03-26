{...}: {
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # Required Kernel Modules
  boot.kernelModules = [
    "kvm-amd"
    "vfio"
    "vfio_pci"
    "vfio_iommu_type1"
    "vfio_virqfd"
  ];

  # Enable IOMMU & PCI passthrough
  boot.kernelParams = [
    "amd_iommu=on"
    "iommu=pt"
    "vfio-pci.ids=1002:744c,1002:ab30"
  ];

  # Assign user to libvirt & KVM groups
  users.users.toft.extraGroups = ["libvirtd" "kvm"];
}
