# Configuration Guide

The AI Dev Workstation is primarily configured through a single JSON file and several standard configuration files for the underlying tools.

## The Project Registry (`projects.json`)

The core configuration lives at `~/.config/of/projects.json`. This file tells the `of` manager where your projects are and which editor to use.

### File Location
```bash
~/.config/of/projects.json
```

### Structure Reference

```json
{
  "current": "my-app",                        // The currently active project
  "default_editor": "vscode",                 // Default editor ID
  "zellij_layout": "ai_workstation",          // Default Zellij layout file name
  "editors": {                                // Dictionary of available editors
    "vscode": "C:\Program Files\Microsoft VS Code\Code.exe",
    "cursor": "C:\Users\User\AppData\Local\Programs\cursor\Cursor.exe"
  },
  "projects": {                               // Dictionary of registered projects
    "my-app": {
      "name": "my-app",
      "win_path": "F:\Git\my-app",          // Path formatting for Windows
      "wsl_path": "/mnt/f/Git/my-app",        // Path formatting for WSL
      "editor": "vscode"                      // Specific editor for this project
    }
  }
}
```

### Key Fields

- **`current`**: Managed automatically by `of use <name>`.
- **`zellij_layout`**: The name of the `.kdl` file in `~/.config/zellij/layouts/` (without extension) to use when running `of ai` or `of start`.
- **`win_path`**: The Windows-style path. This is passed to the Windows editor executable. **Important:** Backslashes must be escaped (``).
- **`wsl_path`**: The Linux-style path. This is used by the shell and Zellij to set the working directory.

## Tool Configurations

Besides the project manager, each component has its own configuration:

### WezTerm
- **File**: `~/.config/wezterm/wezterm.lua`
- **Purpose**: Terminal appearance, fonts, GPU acceleration settings, and window behavior.
- **Reference**: [WezTerm Documentation](https://wezfurlong.org/wezterm/config/files.html)

### Zellij
- **File**: `~/.config/zellij/config.kdl`
- **Purpose**: Keyboard shortcuts, plugins, and global behavior for the multiplexer.
- **Layouts**: `~/.config/zellij/layouts/*.kdl` define the pane structures.
- **Reference**: [Zellij Documentation](https://zellij.dev/documentation/)

### Shell (Zsh)
- **File**: `~/.zshrc`
- **Purpose**: Aliases, exports, and shell plugins.
- **Note**: The installer adds specific aliases (like `of`) to your shell configuration.
