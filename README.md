To rebuild the system use 
```bash
rebuild.sh
```
Use `-h` for help with the options of running the rebuild scritpy.

The design is modular: This means that you can create a new host in the directory "hosts", and then use the rebuild script `rebuild.sh`, with the host name as the target of the rebuild, to create a new machine. The modules can easily be enabled and disabled:
```nix
ghostty.enable = true;
```
This enables the ghostty terminal.

Do not use the hardware configurations from this repository as they are likely not compatible with other systems. To generate a new hardware configuration use `nixos-generate-config` 

## further work
- dendritic pattern (big task)
- fix neovim config
- auto add new modules
- make available for all systems, not just x86_64
