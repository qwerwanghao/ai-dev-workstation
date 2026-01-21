# Installation Guide

This guide will walk you through installing the AI Dev Workstation on your Windows 11 machine with WSL2.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Quick Install](#quick-install)
- [Manual Install](#manual-install)
- [Verification](#verification)
- [Troubleshooting](#troubleshooting)

---

## Prerequisites

### Required

- **Windows 11** with WSL2 enabled
- **Ubuntu** or another Linux distribution on WSL2
- **Git** installed on WSL2
- **Curl** installed on WSL2

### Enable WSL2

If you haven't enabled WSL2 yet, run this in PowerShell (as Administrator):

```powershell
wsl --install
```

Restart your computer when prompted.

### Verify WSL2

Open Ubuntu/WSL and verify:

```bash
# Check WSL version
wsl --status

# Verify you're running WSL2
uname -r
# Should show: ...-microsoft-standard
```

---

## Quick Install

### 1. Clone the Repository

```bash
git clone https://github.com/yourname/ai-dev-workstation.git
cd ai-dev-workstation
```

### 2. Run the Installer

```bash
chmod +x install.sh
./install.sh
```

The installer will:
- Install WezTerm
- Install Zellij
- Install CLI tools (bat, ripgrep, eza, lazygit, zoxide, delta)
- Configure your shell
- Install the `mm` project manager

### 3. Reload Your Shell

```bash
source ~/.bashrc
```

### 4. Initialize Your Project

```bash
mm init /path/to/project
```

---

## Manual Install

If you prefer to install components individually:

### WezTerm

```bash
# Add WezTerm PPA
curl -fsSL https://wezfurlong.org/releases/apt/pubkey.asc | sudo gpg --dearmor -o /usr/share/keyrings/wezterm.gpg
echo "deb [signed-by=/usr/share/keyrings/wezterm.gpg] https://wezfurlong.org/releases/apt/debian stable main" | sudo tee /etc/apt/sources.list.d/wezterm.list

# Install
sudo apt update
sudo apt install -y wezterm
```

### Zellij

```bash
sudo apt install -y zellij
```

### CLI Tools

```bash
# Basic tools
sudo apt install -y bat ripgrep fzf

# eza (modern ls)
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza

# lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin

# zoxide
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

# delta (git diff)
DELTA_VERSION=$(curl -s "https://api.github.com/repos/dandavison/delta/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
wget "https://github.com/dandavison/delta/releases/download/${DELTA_VERSION}/delta-${DELTA_VERSION}-x86_64-unknown-linux-gnu.tar.gz"
tar xzf delta-${DELTA_VERSION}-x86_64-unknown-linux-gnu.tar.gz
sudo install delta-${DELTA_VERSION}-x86_64-unknown-linux-gnu/delta /usr/local/bin
```

### MM Project Manager

```bash
# Install mm
mkdir -p ~/bin
cp scripts/mm/mm ~/bin/mm
chmod +x ~/bin/mm

# Copy mm libraries
mkdir -p ~/.ai-dev-workstation/mm
cp scripts/mm/*.sh ~/.ai-dev-workstation/mm/

# Update mm script paths
sed -i "s|SCRIPT_DIR=.*|SCRIPT_DIR=\"$HOME/.ai-dev-workstation/mm\"|" ~/bin/mm
```

### Configuration Files

```bash
# Zellij
mkdir -p ~/.config/zellij/layouts
cp config/zellij/config.kdl ~/.config/zellij/
cp config/zellij/layouts/*.kdl ~/.config/zellij/layouts/

# WezTerm
mkdir -p ~/.config/wezterm/colors
cp config/wezterm/wezterm.lua ~/.config/wezterm/
cp config/wezterm/colors/*.lua ~/.config/wezterm/colors/
```

---

## Verification

Run the verification script:

```bash
bash scripts/setup/verify-install.sh
```

Expected output:
```
======================================
AI Dev Workstation - Installation Verification
======================================

Terminal Emulators:
✓ WezTerm: wezterm 0.0.0

Terminal Multiplexer:
✓ Zellij: zellij 0.43.1

CLI Tools:
✓ bat: bat 0.24
✓ ripgrep: rg 14.1.0
✓ eza: eza 0.18.0
✓ lazygit: lazygit 0.40.0
✓ zoxide: zoxide
✓ delta: delta 0.16.0
✓ fzf: fzf 0.44.1

Project Management:
✓ mm script: /home/user/bin/mm
✓ mm libraries: /home/user/.ai-dev-workstation/mm
ℹ mm config: not found (run 'mm init')
```

---

## Troubleshooting

### WezTerm won't start

- Make sure you have GPU drivers installed
- Try running WezTerm from Windows PowerShell first
- Check WezTerm logs: `~/.wezterm.log`

### Zellij layout not found

```bash
# Verify layouts are installed
ls ~/.config/zellij/layouts/

# Reinstall if missing
cp config/zellij/layouts/*.kdl ~/.config/zellij/layouts/
```

### MM command not found

```bash
# Check if mm is in PATH
echo $PATH | grep -o ~/bin

# If not, add to PATH
export PATH="$HOME/bin:$PATH"
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
```

### Permission denied

```bash
# Make scripts executable
chmod +x install.sh
chmod +x ~/bin/mm
```

---

## Next Steps

1. [Configure your project](configuration.md)
2. [Customize layouts](customization.md)
3. [Learn AI workflows](workflows/ai-development.md)
