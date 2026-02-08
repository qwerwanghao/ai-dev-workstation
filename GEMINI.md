# AI Dev Workstation - Project Context

## Project Overview

**AI Dev Workstation** is a configuration-as-code project that transforms a Windows 11 + WSL2 environment into a high-performance, AI-integrated development terminal. It orchestrates a suite of modern tools to create a seamless workflow between Windows GUI applications and Linux CLI utilities.

## Architecture

The system follows a layered architecture:

1.  **Host:** Windows 11
2.  **Subsystem:** WSL2 (Linux)
3.  **Terminal:** WezTerm (GPU-accelerated, running on Windows but driven by WSL)
4.  **Multiplexer:** Zellij (manages panes and sessions)
5.  **Shell:** Zsh (customized with plugins)
6.  **Manager:** `of` (custom project management tool)

## Key Components

### 1. The `of` Project Manager
Located at `scripts/of/of`, this Zsh script is the core control utility. It manages:
*   **Project Registry:** Tracks projects in `~/.config/of/projects.json`.
*   **Context Switching:** Changes directory and environment variables.
*   **Tool Orchestration:** Launches editors (VS Code, etc.) on Windows and terminal layouts in Zellij.

**Key Commands:**
*   `of register <name>`: Registers the current directory as a project.
*   `of use <name>`: Switches the active project context.
*   `of start [name]`: Launches the full environment (Editor + AI Terminal).
*   `of ai [name]`: Launches only the AI Terminal (Zellij layout).
*   `of stop`: Gracefully closes the editor and terminal session.

### 2. Configuration Files (`config/`)
*   **`config/wezterm/`**: Lua configuration for WezTerm, including the Tokyo Night color scheme.
*   **`config/zellij/`**: KDL configuration for Zellij.
    *   `config.kdl`: Main settings.
    *   `layouts/`: Defines pane structures (e.g., `ai_workstation.kdl` for the tabbed AI view).
*   **`config/shell/`**: Shell configuration snippets (aliases, exports).

### 3. Installation Scripts (`install.sh`)
*   **`install.sh`**: The master installer. It detects the OS, installs dependencies (WezTerm, Zellij, CLI tools), and deploys configuration files.
*   **`scripts/setup/verify-install.sh`**: Verifies that all components are correctly installed.

## Development & Usage

### Building/Installing
This is a configuration project, so "building" equates to running the installation script:

```bash
./install.sh
```

Flags available:
*   `--no-wezterm`: Skip WezTerm installation.
*   `--no-zellij`: Skip Zellij installation.
*   `--no-cli-tools`: Skip extra tools (bat, eza, etc.).

### Modifying the System

**To add a new Project Template/Layout:**
1.  Create a new KDL file in `config/zellij/layouts/`.
2.  Update `~/.config/of/projects.json` to reference this layout (key: `zellij_layout`).

**To modify the `of` manager:**
1.  Edit `scripts/of/of`.
2.  The script uses embedded Python 3 for JSON manipulation. Ensure Python logic remains valid.
3.  Re-install or manually copy the script to `~/bin/of` to test changes.

### Conventions
*   **Languages:** Bash for the installer, Zsh for the `of` manager, Lua for WezTerm, KDL for Zellij.
*   **Paths:** The system relies on `wslpath` to translate between Windows (`C:\...`) and WSL (`/mnt/c/...`) paths.
*   **Dependencies:** The system assumes a standard Ubuntu/Debian-based WSL2 environment.

## Context for AI Agents
When working on this repository, be aware that:
*   This code runs inside WSL2 but interacts heavily with the Windows host (launching `.exe` files).
*   File paths often need to be considered in both Unix and Windows formats.
*   The `of` script acts as the "glue" holding the workflow together.
