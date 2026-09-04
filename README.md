<h1 align="center">
    <a name="top" title="dotfiles">~/ 🏠</a><br/>dotfiles<br/> <sup><sub>powered by <a href="https://www.chezmoi.io/">chezmoi</a></sub></sup>
</h1>

### Note
This is my personal configuration setup. If you decide to install it using `chezmoi` it will run a bootstrap script located in `.chezmoiscripts` installing packages and scripts i use on my system. So please be aware. Use at your own risk!

### Installation
```sh
sh -c "$(curl -fsLS https://chezmoi.io/get)" -- init --apply nullbyto
```

### Configuration (`.chezmoidata.yaml`)

This setup uses `.chezmoidata.yaml` to dynamically manage package installations based on the selected display protocol and window manager preferences.

To customize your setup:

1. Before running `chezmoi apply`, create or modify `~/.local/share/chezmoi/.chezmoidata.yaml`.
2. Configure your environment under the `config` key:
   - **`setup_custom_desktop`**: Set to `true` to install desktop environment packages.
   - **`display_protocols`**: List your preferred protocols (e.g., `wayland`, `xorg`).
   - **`wms`**: List your preferred window managers (e.g., `hyprland`, `i3wm`, `qtile`).

**Complete Example Configuration:**

```yaml
config:
  setup_custom_desktop: true

  # Select one or more protocols
  display_protocols:
    - "wayland"

  # Select one or more window managers
  wms:
    - "hyprland"

packages:
  # Core CLI packages installed on all systems regardless of desktop config
  common:
    - git
    - neovim
    - curl
    - zsh

  # GUI / Desktop tools (installed if setup_custom_desktop is true)
  desktop_common:
    - alacritty
    - pipewire
    - thunar

  # Protocol-specific packages
  desktop_wayland:
    - waybar
    - wofi
  desktop_xorg:
    - rofi

  # Distro-specific overrides and dependencies
  distros:
    arch:
      # Official repository packages
      packages:
        - python-pynvim

      # AUR packages (Only valid on Arch-based systems)
      aur_packages:
        - kora-icon-theme

      # Window manager specific dependencies mapped to 'wms' config
      wm_packages:
        hyprland:
          - hyprland
          - xdg-desktop-portal-hyprland
        i3wm:
          - i3-wm
          - i3status-rust

    # Target specific distributions (e.g., cachyos, ubuntu)
    # By default, distros inherit packages from their parent family (e.g., arch, debian)
    cachyos:
      standalone: true # Set to true to bypass parent family inheritance
      packages:
        - some-cachyos-exclusive-package
```

The bootstrap script will automatically read this file, resolve the appropriate packages for your OS family (e.g., Arch, Debian, Fedora), and intelligently install only what is required based on your config flags.
