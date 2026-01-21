#!/usr/bin/env bash
# AI Dev Workstation - One-Command Installer
# This script installs the complete AI Dev Workstation

set -euo pipefail

#-------------------------------------------------------------------------------
# Configuration
#-------------------------------------------------------------------------------

VERSION="1.0.0"
INSTALL_DIR="${INSTALL_DIR:-$HOME/.ai-dev-workstation}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Installation options (can be overridden by flags)
INSTALL_WEZTERM="${INSTALL_WEZTERM:-true}"
INSTALL_ZELLIJ="${INSTALL_ZELLIJ:-true}"
INSTALL_CLI_TOOLS="${INSTALL_CLI_TOOLS:-true}"
SHELL_CONFIG="${SHELL_CONFIG:-true}"

#-------------------------------------------------------------------------------
# Logging Functions
#-------------------------------------------------------------------------------

log_info() { echo -e "\033[0;34m[INFO]\033[0m $*"; }
log_success() { echo -e "\033[0;32m[OK]\033[0m $*"; }
log_error() { echo -e "\033[0;31m[ERROR]\033[0m $*" >&2; }
log_warn() { echo -e "\033[0;33m[WARN]\033[0m $*"; }

#-------------------------------------------------------------------------------
# Usage
#-------------------------------------------------------------------------------

show_usage() {
    cat <<'EOF'
AI Dev Workstation Installer v1.0.0

USAGE:
    ./install.sh [OPTIONS]

OPTIONS:
    --no-wezterm      Skip WezTerm installation
    --no-zellij       Skip Zellij installation
    --no-cli-tools    Skip CLI tools installation
    --no-shell        Skip shell configuration
    --help, -h        Show this help message

EXAMPLES:
    ./install.sh                    # Install everything
    ./install.sh --no-wezterm       # Skip WezTerm
    ./install.sh --no-cli-tools     # Skip CLI tools

FOR MORE INFORMATION:
    https://github.com/yourname/ai-dev-workstation
EOF
}

#-------------------------------------------------------------------------------
# Parse Arguments
#-------------------------------------------------------------------------------

while [[ $# -gt 0 ]]; do
    case $1 in
        --no-wezterm)
            INSTALL_WEZTERM=false
            shift
            ;;
        --no-zellij)
            INSTALL_ZELLIJ=false
            shift
            ;;
        --no-cli-tools)
            INSTALL_CLI_TOOLS=false
            shift
            ;;
        --no-shell)
            SHELL_CONFIG=false
            shift
            ;;
        --help|-h)
            show_usage
            exit 0
            ;;
        *)
            log_error "Unknown option: $1"
            show_usage
            exit 1
            ;;
    esac
done

#-------------------------------------------------------------------------------
# Pre-flight Checks
#-------------------------------------------------------------------------------

log_info "AI Dev Workstation v${VERSION} Installer"
echo ""

# Check if running on WSL
if ! grep -qi microsoft /proc/version 2>/dev/null; then
    log_warn "Not running under WSL. Some features may not work as expected."
    read -p "Continue anyway? [y/N] " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        log_info "Installation cancelled"
        exit 0
    fi
fi

# Check for required dependencies
log_info "Checking dependencies..."
missing_deps=()

for cmd in git curl; do
    if ! command -v "$cmd" &>/dev/null; then
        missing_deps+=("$cmd")
    fi
done

if [[ ${#missing_deps[@]} -gt 0 ]]; then
    log_error "Missing required dependencies: ${missing_deps[*]}"
    log_info "Install them with: sudo apt install ${missing_deps[*]}"
    exit 1
fi

log_success "Dependencies OK"
echo ""

#-------------------------------------------------------------------------------
# Installation Functions
#-------------------------------------------------------------------------------

# Backup existing configuration
backup_config() {
    local file="$1"
    if [[ -f "$file" ]]; then
        local backup="${file}.backup.$(date +%Y%m%d%H%M%S)"
        log_info "Backing up $file -> $backup"
        cp "$file" "$backup"
    fi
}

# Install WezTerm
install_wezterm() {
    if [[ "$INSTALL_WEZTERM" != true ]]; then
        log_info "Skipping WezTerm installation"
        return
    fi

    log_info "Installing WezTerm..."

    if command -v wezterm &>/dev/null; then
        log_success "WezTerm already installed"
        return
    fi

    # Detect system
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        OS="$ID"
    else
        log_error "Cannot detect OS"
        return 1
    fi

    case "$OS" in
        ubuntu)
            # Add WezTerm PPA
            curl -fsSL https://wezfurlong.org/releases/apt/pubkey.asc | sudo gpg --dearmor -o /usr/share/keyrings/wezterm.gpg
            echo "deb [signed-by=/usr/share/keyrings/wezterm.gpg] https://wezfurlong.org/releases/apt/debian stable main" | sudo tee /etc/apt/sources.list.d/wezterm.list >/dev/null
            sudo apt update
            sudo apt install -y wezterm
            ;;
        *)
            log_warn "Automatic WezTerm installation not supported for $OS"
            log_info "Please install WezTerm manually: https://wezfurlong.org/wezterm/install.html"
            return
            ;;
    esac

    log_success "WezTerm installed"
}

# Install Zellij
install_zellij() {
    if [[ "$INSTALL_ZELLIJ" != true ]]; then
        log_info "Skipping Zellij installation"
        return
    fi

    log_info "Installing Zellij..."

    if command -v zellij &>/dev/null; then
        log_success "Zellij already installed"
        return
    fi

    sudo apt install -y zellij
    log_success "Zellij installed"
}

# Install CLI tools
install_cli_tools() {
    if [[ "$INSTALL_CLI_TOOLS" != true ]]; then
        log_info "Skipping CLI tools installation"
        return
    fi

    log_info "Installing CLI tools..."

    # Install via apt
    local apt_tools=(bat ripgrep fzf)
    local missing_tools=()

    for tool in "${apt_tools[@]}"; do
        if ! command -v "$tool" &>/dev/null; then
            missing_tools+=("$tool")
        fi
    done

    if [[ ${#missing_tools[@]} -gt 0 ]]; then
        sudo apt install -y "${missing_tools[@]}"
    fi

    # Install eza (modern ls)
    if ! command -v eza &>/dev/null; then
        log_info "Installing eza..."
        sudo mkdir -p /etc/apt/keyrings
        wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
        echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list >/dev/null
        sudo apt update
        sudo apt install -y eza
    fi

    # Install lazygit
    if ! command -v lazygit &>/dev/null; then
        log_info "Installing lazygit..."
        LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
        curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
        tar xf lazygit.tar.gz lazygit
        sudo install lazygit /usr/local/bin
        rm -f lazygit lazygit.tar.gz
    fi

    # Install zoxide
    if ! command -v zoxide &>/dev/null; then
        log_info "Installing zoxide..."
        curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
    fi

    # Install delta (git diff viewer)
    if ! command -v delta &>/dev/null; then
        log_info "Installing delta..."
        DELTA_VERSION=$(curl -s "https://api.github.com/repos/dandavison/delta/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
        wget -q "https://github.com/dandavison/delta/releases/download/${DELTA_VERSION}/delta-${DELTA_VERSION}-x86_64-unknown-linux-gnu.tar.gz"
        tar xzf "delta-${DELTA_VERSION}-x86_64-unknown-linux-gnu.tar.gz"
        sudo install "delta-${DELTA_VERSION}-x86_64-unknown-linux-gnu/delta" /usr/local/bin
        rm -rf "delta-${DELTA_VERSION}-*"
    fi

    log_success "CLI tools installed"
}

# Configure shell
configure_shell() {
    if [[ "$SHELL_CONFIG" != true ]]; then
        log_info "Skipping shell configuration"
        return
    fi

    log_info "Configuring shell..."

    local shell_rc="$HOME/.bashrc"
    local marker="# AI Dev Workstation"

    # Check if already configured
    if grep -q "$marker" "$shell_rc" 2>/dev/null; then
        log_success "Shell already configured"
        return
    fi

    # Add aliases
    cat >> "$shell_rc" <<'EOF'

# AI Dev Workstation aliases (added by install script)
alias ls='eza --icons'
alias ll='eza -la --icons'
alias tree='eza --tree --icons'
alias cat='bat'

# mm shortcut
alias mm='~/bin/mm'

# zoxide
if command -v zoxide &>/dev/null; then
    eval "$(zoxide init bash)"
fi
EOF

    # Configure git delta
    if command -v delta &>/dev/null; then
        git config --global core.pager delta 2>/dev/null || true
        git config --global delta.light true 2>/dev/null || true
    fi

    log_success "Shell configured"
}

# Install mm script
install_mm() {
    log_info "Installing mm script..."

    # Create bin directory
    mkdir -p "$HOME/bin"

    # Copy mm script
    cp "$SCRIPT_DIR/scripts/mm/mm" "$HOME/bin/mm"
    chmod +x "$HOME/bin/mm"

    # Copy mm libraries
    mkdir -p "$HOME/.ai-dev-workstation/mm"
    cp "$SCRIPT_DIR/scripts/mm/mm-core.sh" "$HOME/.ai-dev-workstation/mm/"
    cp "$SCRIPT_DIR/scripts/mm/mm-commands.sh" "$HOME/.ai-dev-workstation/mm/"

    # Update mm script to use installed location
    sed -i "s|SCRIPT_DIR=.*|SCRIPT_DIR=\"$HOME/.ai-dev-workstation/mm\"|" "$HOME/bin/mm"

    log_success "mm script installed"
}

# Copy configurations
copy_configs() {
    log_info "Copying configuration files..."

    # Zellij
    backup_config "$HOME/.config/zellij/config.kdl"
    mkdir -p "$HOME/.config/zellij/layouts"
    cp "$SCRIPT_DIR/config/zellij/config.kdl" "$HOME/.config/zellij/" 2>/dev/null || true
    cp "$SCRIPT_DIR/config/zellij/layouts/"*.kdl "$HOME/.config/zellij/layouts/" 2>/dev/null || true

    # WezTerm
    backup_config "$HOME/.config/wezterm/wezterm.lua"
    mkdir -p "$HOME/.config/wezterm/colors"
    cp "$SCRIPT_DIR/config/wezterm/wezterm.lua" "$HOME/.config/wezterm/" 2>/dev/null || true
    cp "$SCRIPT_DIR/config/wezterm/colors/"*.lua "$HOME/.config/wezterm/colors/" 2>/dev/null || true

    log_success "Configurations copied"
}

#-------------------------------------------------------------------------------
# Main Installation
#-------------------------------------------------------------------------------

main() {
    echo ""
    log_info "Starting installation..."
    echo ""

    # Run installation steps
    install_wezterm
    install_zellij
    install_cli_tools
    configure_shell
    install_mm
    copy_configs

    echo ""
    log_success "Installation complete!"
    echo ""
    log_info "Next steps:"
    echo "  1. Run: source ~/.bashrc      # Reload shell configuration"
    echo "  2. Run: mm init              # Initialize for your project"
    echo "  3. Run: mm                   # Start your workstation"
    echo ""
    log_info "For more information, see: https://github.com/yourname/ai-dev-workstation"
}

main
