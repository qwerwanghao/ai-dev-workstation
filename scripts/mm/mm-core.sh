#!/usr/bin/env bash
# mm-core.sh - Core MM functionality
# This file contains the core functions for configuration loading, validation, and utilities

# Version
MM_VERSION="1.0.0"

# Configuration file location
MM_CONFIG_FILE="${MM_CONFIG_FILE:-$HOME/.mmrc}"

# Project configuration (loaded from .mmrc)
PROJECT_NAME=""
PROJECT_DIR=""
PROJECT_WIN=""
PROJECT_TYPE="generic"
WINDOWS_DRIVE_F="/mnt/f"
WINDOWS_DRIVE_C="/mnt/c"
ZELLIJ_LAYOUT="ai_workstation"

# Associative arrays for configuration
declare -A APPS
declare -A CMDS
WORKSPACE_APPS=()

#-------------------------------------------------------------------------------
# Logging Functions
#-------------------------------------------------------------------------------

mm::info() {
    echo -e "\033[0;34m[INFO]\033[0m $*" >&2
}

mm::warn() {
    echo -e "\033[0;33m[WARN]\033[0m $*" >&2
}

mm::error() {
    echo -e "\033[0;31m[ERROR]\033[0m $*" >&2
}

mm::success() {
    echo -e "\033[0;32m[OK]\033[0m $*" >&2
}

#-------------------------------------------------------------------------------
# Configuration Loading
#-------------------------------------------------------------------------------

# Load configuration file
mm::load_config() {
    if [[ ! -f "$MM_CONFIG_FILE" ]]; then
        mm::error "Configuration file not found: $MM_CONFIG_FILE"
        mm::info "Run 'mm init' to create a configuration"
        exit 1
    fi

    # Source the config file
    # shellcheck source=/dev/null
    if ! source "$MM_CONFIG_FILE" 2>/dev/null; then
        mm::error "Invalid configuration file: $MM_CONFIG_FILE"
        exit 1
    fi
}

# Validate required configuration
mm::validate_config() {
    local errors=0

    if [[ -z "$PROJECT_NAME" ]]; then
        mm::error "PROJECT_NAME not set in configuration"
        ((errors++))
    fi

    if [[ -z "$PROJECT_DIR" ]]; then
        mm::error "PROJECT_DIR not set in configuration"
        ((errors++))
    elif [[ ! -d "$PROJECT_DIR" ]]; then
        mm::error "Project directory does not exist: $PROJECT_DIR"
        ((errors++))
    fi

    if [[ $errors -gt 0 ]]; then
        exit 1
    fi
}

# Check if running under WSL
mm::check_wsl() {
    if ! grep -qi microsoft /proc/version 2>/dev/null; then
        mm::warn "Not running under WSL. Some features may not work as expected."
        return 1
    fi
    return 0
}

# Check if command exists
mm::check_command() {
    local cmd="$1"
    local name="${2:-$cmd}"

    if ! command -v "$cmd" &>/dev/null; then
        mm::error "Required command '$cmd' not found. Please install $name."
        return 1
    fi
    return 0
}

#-------------------------------------------------------------------------------
# Path Utilities
#-------------------------------------------------------------------------------

# Convert Windows path to WSL path
mm::win_to_wsl() {
    local win_path="$1"
    # Convert backslashes to forward slashes
    local path="${win_path//\\//}"
    # Handle drive letters
    if [[ "$path" =~ ^([A-Z]):/(.*)$ ]]; then
        local drive="${BASH_REMATCH[1]}"
        local rest="${BASH_REMATCH[2]}"
        echo "/mnt/${drive,,}/$rest"
    else
        echo "$path"
    fi
}

# Convert WSL path to Windows path
mm::wsl_to_win() {
    local wsl_path="$1"
    # Handle /mnt/drive paths
    if [[ "$wsl_path" =~ ^/mnt/([a-z])/(.*)$ ]]; then
        local drive="${BASH_REMATCH[1]}"
        local rest="${BASH_REMATCH[2]}"
        echo "${drive^^}:\\$rest" | sed 's/\//\\/g'
    else
        echo "$wsl_path"
    fi
}

#-------------------------------------------------------------------------------
# Project Directory
#-------------------------------------------------------------------------------

# Change to project directory
mm::cd_project() {
    if [[ ! -d "$PROJECT_DIR" ]]; then
        mm::error "Project directory does not exist: $PROJECT_DIR"
        exit 1
    fi
    cd "$PROJECT_DIR" || exit 1
}

#-------------------------------------------------------------------------------
# Version Information
#-------------------------------------------------------------------------------

# Show version information
mm::version() {
    cat <<EOF
mm v${MM_VERSION}
AI Dev Workstation - Project Management Tool

License: MIT
Source: https://github.com/ai-dev-workstation/ai-dev-workstation
EOF
}
