# Troubleshooting

Common issues and solutions for the AI Dev Workstation.

## Installation Issues

### "wslpath: command not found"
*   **Cause**: You are likely running the script in a standard Linux environment, not WSL2.
*   **Solution**: This toolkit is designed specifically for WSL2. Ensure you are running inside a WSL instance on Windows 11.

### "Command not found: wezterm"
*   **Cause**: WezTerm might not be in your PATH or failed to install.
*   **Solution**:
    1.  Check if WezTerm is installed on Windows.
    2.  If you are trying to run `wezterm` from inside WSL, ensure the interop is enabled (you can run `.exe` files).
    3.  Manual install: Follow the guide at [wezfurlong.org](https://wezfurlong.org/wezterm/install/windows.html).

## Runtime Issues

### Editor does not open
*   **Symptom**: `of start` runs, but no window appears.
*   **Check**:
    1.  Open `~/.config/of/projects.json`.
    2.  Verify the `win_path` for the editor is correct. It must point to the valid `.exe` on the Windows file system.
    3.  Ensure path backslashes are escaped (e.g., `C:\Program Files\...`).

### "Project not found"
*   **Symptom**: `of use my-project` fails.
*   **Solution**:
    1.  Run `of list` to see registered projects.
    2.  If missing, run `of register my-project` inside the project directory.

### Zellij panes close immediately
*   **Symptom**: You see a pane flash and disappear.
*   **Cause**: The command specified in the layout (e.g., `claude`, `codex`) is not installed or not in your PATH.
*   **Solution**:
    1.  Install the missing tool.
    2.  Or, edit `~/.config/zellij/layouts/ai_workstation.kdl` to use a tool you actually have (e.g., replace `codex` with `zsh`).

## Windows Integration

### "Access Denied" when killing processes
*   **Symptom**: `of stop` fails to close the editor.
*   **Cause**: `taskkill.exe` might require elevation for some processes, or the process name logic is incorrect.
*   **Solution**: You may need to manually close the window, or ensure your user has permissions to kill the editor process.
