# 配置指南

AI Dev Workstation 主要通过一个核心 JSON 文件以及底层工具的标准配置文件进行配置。

## 项目注册表 (`projects.json`)

核心配置位于 `~/.config/of/projects.json`。该文件告诉 `of` 管理器你的项目位置以及使用哪个编辑器。

### 文件位置
```bash
~/.config/of/projects.json
```

### 结构参考

```json
{
  "current": "my-app",                        // 当前激活的项目
  "default_editor": "vscode",                 // 默认编辑器 ID
  "zellij_layout": "ai_workstation",          // 默认 Zellij 布局文件名
  "editors": {                                // 可用编辑器字典
    "vscode": "C:\Program Files\Microsoft VS Code\Code.exe",
    "cursor": "C:\Users\User\AppData\Local\Programs\cursor\Cursor.exe"
  },
  "projects": {                               // 已注册项目字典
    "my-app": {
      "name": "my-app",
      "win_path": "F:\Git\my-app",          // Windows 格式路径
      "wsl_path": "/mnt/f/Git/my-app",        // WSL 格式路径
      "editor": "vscode"                      // 该项目指定的编辑器
    }
  }
}
```

### 关键字段

- **`current`**: 由 `of use <name>` 命令自动管理。
- **`zellij_layout`**: 运行 `of ai` 或 `of start` 时使用的 `.kdl` 布局文件名（不带扩展名），位于 `~/.config/zellij/layouts/`。
- **`win_path`**: Windows 风格的路径。它会被传递给 Windows 编辑器可执行文件。**重要：** 反斜杠必须转义（``）。
- **`wsl_path`**: Linux 风格的路径。Shell 和 Zellij 使用它来设置工作目录。

## 工具配置

除了项目管理器，每个组件都有自己的配置文件：

### WezTerm
- **文件**: `~/.config/wezterm/wezterm.lua`
- **用途**: 终端外观、字体、GPU 加速设置和窗口行为。
- **参考**: [WezTerm 文档](https://wezfurlong.org/wezterm/config/files.html)

### Zellij
- **文件**: `~/.config/zellij/config.kdl`
- **用途**: 复用器的快捷键、插件和全局行为。
- **布局**: `~/.config/zellij/layouts/*.kdl` 定义了面板结构。
- **参考**: [Zellij 文档](https://zellij.dev/documentation/)

### Shell (Zsh)
- **文件**: `~/.zshrc`
- **用途**: 别名、环境变量导出和 Shell 插件。
- **注意**: 安装程序会在你的 Shell 配置中添加特定的别名（如 `of`）。
