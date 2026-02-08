# 自定义指南

AI Dev Workstation 的核心理念之一是可扩展性。以下是如何根据你的具体需求定制环境。

## 创建自定义布局

最强大的自定义功能是创建你自己的 Zellij 布局。这允许你精确定义启动项目时要运行哪些工具。

1.  **创建一个新的 KDL 文件**:
    进入你的布局目录：
    ```bash
    cd ~/.config/zellij/layouts/
    touch my_custom_layout.kdl
    ```

2.  **定义结构**:
    使用 KDL 语法编辑文件。这是一个简单的例子：

    ```kdl
    layout {
        // 定义一个包含特定面板的标签页
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
        
        // 定义标准状态栏
        default_tab_template {
            children
            pane size=1 borderless=true {
                plugin location="zellij:status-bar"
            }
        }
    }
    ```

3.  **激活它**:
    更新你的 `~/.config/of/projects.json` 以使用这个新布局：
    ```json
    "zellij_layout": "my_custom_layout"
    ```

## 添加新编辑器

要使用不同的编辑器（例如 Cursor、Sublime Text、IntelliJ）：

1.  **找到 Windows 路径**: 在 Windows 上找到 `.exe` 文件。
2.  **更新 `projects.json`**:
    将其添加到 `~/.config/of/projects.json` 的 `editors` 块中：

    ```json
    "editors": {
      "vscode": "...",
      "sublime": "C:\Program Files\Sublime Text 3\subl.exe"
    }
    ```
3.  **分配它**:
    设置 `"default_editor": "sublime"` 或将其分配给特定项目。

## Shell 别名

你可以向 `~/.bashrc` 或 `~/.zshrc` 添加自定义别名。安装程序设置了一些默认值，但你可以自由扩展。

AI 工作流的推荐添加：

```bash
# 快速编辑配置
alias conf="code ~/.config/of/projects.json"

# 快速编辑布局
alias layouts="cd ~/.config/zellij/layouts/"
```
