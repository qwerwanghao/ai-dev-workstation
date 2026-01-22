#!/usr/bin/env bash
# Verification script for AI Dev Workstation installation

set -euo pipefail

PASS="\033[0;32m✓\033[0m"
FAIL="\033[0;31m✗\033[0m"
INFO="\033[0;34mℹ\033[0m"

check() {
    local name="$1"
    local cmd="$2"

    if command -v "$cmd" &>/dev/null; then
        local version
        version=$($cmd --version 2>/dev/null | head -n1 || echo "installed")
        echo -e "$PASS $name: $version"
        return 0
    else
        echo -e "$FAIL $name: not found"
        return 1
    fi
}

check_file() {
    local name="$1"
    local file="$2"

    if [[ -f "$file" ]]; then
        echo -e "$PASS $name: $file"
        return 0
    else
        echo -e "$FAIL $name: not found ($file)"
        return 1
    fi
}

check_dir() {
    local name="$1"
    local dir="$2"

    if [[ -d "$dir" ]]; then
        echo -e "$PASS $name: $dir"
        return 0
    else
        echo -e "$FAIL $name: not found ($dir)"
        return 1
    fi
}

echo "======================================"
echo "AI Dev Workstation - Installation Verification"
echo "======================================"
echo ""

echo "Terminal Emulators:"
check "WezTerm" wezterm
echo ""

echo "Terminal Multiplexer:"
check "Zellij" zellij
echo ""

echo "CLI Tools:"
check "bat" bat
check "ripgrep" rg
check "eza" eza
check "lazygit" lazygit
check "zoxide" zoxide
check "delta" delta
check "fzf" fzf
echo ""

echo "AI CLI Tools:"
check "Claude" claude || true
check "Codex" codex || true
check "Gemini" gemini || true
echo ""

echo "Project Management:"
check_file "of script" "$HOME/bin/of"
check_dir "of config dir" "$HOME/.config/of"
check_file "of projects.json" "$HOME/.config/of/projects.json" || echo -e "$INFO of projects.json: not found (run 'of register <name>')"
echo ""

echo "Configuration Files:"
check_file "Zellij config" "$HOME/.config/zellij/config.kdl"
check_dir "Zellij layouts" "$HOME/.config/zellij/layouts"
check_file "WezTerm config" "$HOME/.config/wezterm/wezterm.lua" || true
echo ""

echo "Shell Integration:"
if grep -q "AI Dev Workstation" "$HOME/.bashrc" 2>/dev/null; then
    echo -e "$PASS Shell aliases configured"
else
    echo -e "$FAIL Shell aliases not configured"
fi
echo ""

echo "======================================"
echo "Verification complete!"
echo "======================================"
