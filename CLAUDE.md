# CLAUDE.md
使用中文和我对话

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

AI Dev Workstation is a development environment automation tool for Windows 11 + WSL2. It sets up a terminal-based development environment with AI tool integration using WezTerm, Zellij, and a multi-project manager called `of`.

## Architecture

The project is a configuration-as-code system, not a traditional application:

```
Windows 11
└── WSL2 (Linux)
    └── WezTerm (GPU Terminal)
        └── Zellij (Terminal Multiplexer)
            └── Zsh (Shell)
                └── of (Project Manager)
                    └── AI CLI Tools (Claude, Codex, Gemini)
```

## Key Components

### OF Project Manager (`scripts/of/`)

The `of` tool is the primary entry point. It's a single Zsh script that manages multiple projects:

- **`of`** - Complete project manager with multi-project support
- Written in Zsh (uses embedded Python for JSON manipulation)
- Stores configuration in JSON format at `~/.config/of/projects.json`

### Core Commands

| Command | Description |
|---------|-------------|
| `of register <name>` | Register current directory as a project |
| `of use <name>` | Switch the current project |
| `of list` | List all registered projects |
| `of start [name]` | Start editor + AI workstation |
| `of ai [name]` | Start AI workstation only |
| `of stop` | Stop all tools |

### Configuration System

User configuration lives in `~/.config/of/projects.json`:

```json
{
  "current": "myproject",
  "default_editor": "antigravity",
  "zellij_layout": "ai_workstation",
  "editors": {
    "antigravity": "C:\\Users\\YourName\\AppData\\Local\\Programs\\Antigravity\\Antigravity.exe",
    "vscode": "C:\\Program Files\\Microsoft VS Code\\Code.exe"
  },
  "projects": {
    "myproject": {
      "name": "myproject",
      "win_path": "F:\\Git\\myproject",
      "wsl_path": "/mnt/f/Git/myproject",
      "editor": "antigravity"
    }
  }
}
```

### Zellij Layouts (`config/zellij/layouts/`)

- **`ai_workstation.kdl`** - 4-pane layout: Claude (top-left), Codex (top-right), Gemini (bottom-left), Shell (bottom-right)
- **`development.kdl`** - 3-pane dev layout
- **`minimal.kdl`** - 2-pane minimal layout

## Common Commands

### Installation
```bash
./install.sh                    # Full installation
./install.sh --no-wezterm       # Skip WezTerm
./install.sh --no-zellij        # Skip Zellij
./install.sh --no-cli-tools     # Skip CLI tools
./install.sh --no-shell         # Skip shell config
```

### OF Commands
```bash
of register <name>              # Register current directory as project
of use <name>                   # Switch current project
of list                         # List all registered projects
of start [name]                 # Start editor + AI workstation
of ai [name]                    # Start AI workstation only
of stop                         # Stop all tools
```

### Verification/Uninstallation
```bash
bash scripts/setup/verify-install.sh   # Verify installation
bash scripts/uninstall.sh              # Remove AI Dev Workstation
```

## Working with the Codebase

### Modifying OF

The `of` script is a single Zsh file at `scripts/of/of`. Key sections:

1. **Configuration Functions** (top): `ensure_config()`, path getters
2. **Project Management**: `register_project()`, `use_project()`, `list_projects()`
3. **Workspace Functions**: `start_project()`, `start_ai()`, `stop_all()`
4. **Main Dispatcher** (bottom): Command routing via case statement

### Adding a New OF Command

1. Implement the function in `scripts/of/of`
2. Add a case entry in the main dispatcher at the bottom
3. Update the `show_help()` function

### Adding a New Zellij Layout

1. Create `.kdl` file in `config/zellij/layouts/`
2. Reference in user's `~/.config/of/projects.json` via `zellij_layout` key

### Adding a New Editor

1. Add editor entry to `editors` object in `~/.config/of/projects.json`
2. Set as `default_editor` or assign to specific projects

### Windows-WSL Integration

The project relies on:
- `wslpath -w` for WSL→Windows path conversion
- `cmd.exe /c start` for launching Windows apps from WSL
- `taskkill.exe` for stopping Windows apps

## Important Constraints

- This is a **WSL2-focused** project. Uses Windows-specific calls (`cmd.exe`, `taskkill.exe`).
- Zellij layouts are defined in KDL (a custom DSL for Zellij).
- WezTerm config is in Lua.
- The `of` script is written in Zsh (not Bash).
- The installer (`install.sh`) copies configs to `~/.config/zellij/` and `~/.config/wezterm/`, and installs `of` to `~/bin/of`.
