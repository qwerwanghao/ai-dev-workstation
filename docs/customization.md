# Customization Guide

One of the core philosophies of the AI Dev Workstation is extensibility. Here is how you can tailor the environment to your specific needs.

## Creating Custom Layouts

The most powerful customization is creating your own Zellij layouts. This allows you to define exactly which tools launch when you start a project.

1.  **Create a new KDL file**:
    Go to your layouts directory:
    ```bash
    cd ~/.config/zellij/layouts/
    touch my_custom_layout.kdl
    ```

2.  **Define the structure**:
    Edit the file using the KDL syntax. Here is a simple example:

    ```kdl
    layout {
        // Define a tab with specific panes
        tab name="Backend" focus=true {
            pane split_direction="vertical" {
                pane command="cargo" {
                    args "run"
                }
                pane command="npm" {
                    args "start"
                }
            }
        }
        
        // Define standard status bar
        default_tab_template {
            children
            pane size=1 borderless=true {
                plugin location="zellij:status-bar"
            }
        }
    }
    ```

3.  **Activate it**:
    Update your `~/.config/of/projects.json` to use this new layout:
    ```json
    "zellij_layout": "my_custom_layout"
    ```

## Adding New Editors

To use a different editor (e.g., Cursor, Sublime Text, IntelliJ):

1.  **Find the Windows path**: Locate the `.exe` file on Windows.
2.  **Update `projects.json`**:
    Add it to the `editors` block in `~/.config/of/projects.json`:

    ```json
    "editors": {
      "vscode": "...",
      "sublime": "C:\Program Files\Sublime Text 3\subl.exe"
    }
    ```
3.  **Assign it**:
    Set `"default_editor": "sublime"` or assign it to a specific project.

## Shell Aliases

You can add custom aliases to your `~/.bashrc` or `~/.zshrc`. The installer sets up a few defaults, but you are free to expand them.

Recommended additions for AI workflows:

```bash
# Quick edit config
alias conf="code ~/.config/of/projects.json"

# Quick layout edit
alias layouts="cd ~/.config/zellij/layouts/"
```
