#!/usr/bin/env bash
# AI Dev Workstation - Uninstaller
# This script removes AI Dev Workstation from your system

set -euo pipefail

#-------------------------------------------------------------------------------
# Configuration
#-------------------------------------------------------------------------------

INSTALL_DIR="${INSTALL_DIR:-$HOME/.ai-dev-workstation}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

#-------------------------------------------------------------------------------
# Logging Functions
#-------------------------------------------------------------------------------

log_info() { echo -e "\033[0;34m[INFO]\033[0m $*"; }
log_success() { echo -e "\033[0;32m[OK]\033[0m $*"; }
log_error() { echo -e "\033[0;31m[ERROR]\033[0m $*" >&2; }
log_warn() { echo -e "\033[0;33m[WARN]\033[0m $*"; }

#-------------------------------------------------------------------------------
# Uninstallation Functions
#-------------------------------------------------------------------------------

remove_mm() {
    log_info "Removing mm script..."
    rm -f "$HOME/bin/mm"
    rm -rf "$HOME/.ai-dev-workstation/mm"
    log_success "mm script removed"
}

remove_configs() {
    log_info "Removing configuration files..."
    rm -rf "$HOME/.config/zellij"
    rm -rf "$HOME/.config/wezterm"
    log_success "Configuration files removed"
}

remove_shell_config() {
    log_info "Removing shell configuration..."

    local shell_rc="$HOME/.bashrc"
    local temp_file="/tmp/bashrc.tmp"

    # Remove AI Dev Workstation section
    if [[ -f "$shell_rc" ]]; then
        # Create temp file without AI Dev Workstation section
        awk '
            /^# AI Dev Workstation aliases/ { skip=1; next }
            skip && /^$/ && !in_block { skip=0; next }
            !skip { print }
        ' "$shell_rc" > "$temp_file"
        mv "$temp_file" "$shell_rc"
    fi

    log_success "Shell configuration removed"
}

remove_install_dir() {
    if [[ -d "$INSTALL_DIR" ]]; then
        log_info "Removing installation directory: $INSTALL_DIR"
        rm -rf "$INSTALL_DIR"
        log_success "Installation directory removed"
    fi
}

#-------------------------------------------------------------------------------
# Main Uninstallation
#-------------------------------------------------------------------------------

main() {
    echo "======================================"
    echo "AI Dev Workstation - Uninstaller"
    echo "======================================"
    echo ""
    log_warn "This will remove AI Dev Workstation from your system."
    echo ""
    read -p "Continue? [y/N] " -n 1 -r
    echo ""

    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        log_info "Uninstallation cancelled"
        exit 0
    fi

    echo ""
    remove_mm
    remove_configs
    remove_shell_config
    remove_install_dir

    echo ""
    log_success "Uninstallation complete!"
    echo ""
    log_info "Note: Installed tools (WezTerm, Zellij, CLI tools) were not removed."
    log_info "      To remove them, use your package manager."
}

main
