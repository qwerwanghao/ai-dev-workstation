# 故障排除

AI Dev Workstation 的常见问题及解决方案。

## 安装问题

### "wslpath: command not found"
*   **原因**: 你可能是在标准的 Linux 环境中运行脚本，而不是 WSL2。
*   **解决方案**: 此工具包专为 Windows 11 上的 WSL2 设计。请确保你在 Windows 11 的 WSL 实例中运行。

### "Command not found: wezterm"
*   **原因**: WezTerm 可能不在你的 PATH 中或安装失败。
*   **解决方案**:
    1.  检查 WezTerm 是否已在 Windows 上安装。
    2.  如果你尝试从 WSL 内部运行 `wezterm`，请确保互操作性已启用（你可以运行 `.exe` 文件）。
    3.  手动安装：按照 [wezfurlong.org](https://wezfurlong.org/wezterm/install/windows.html) 上的指南操作。

## 运行时问题

### 编辑器没有打开
*   **现象**: `of start` 运行了，但没有出现窗口。
*   **检查**:
    1.  打开 `~/.config/of/projects.json`。
    2.  验证编辑器的 `win_path` 是否正确。它必须指向 Windows 文件系统中有效的 `.exe`。
    3.  确保路径中的反斜杠已转义（例如 `C:\Program Files\...`）。

### "Project not found" (未找到项目)
*   **现象**: `of use my-project` 失败。
*   **解决方案**:
    1.  运行 `of list` 查看已注册的项目。
    2.  如果缺失，请在项目目录内运行 `of register my-project`。

### Zellij 面板立即关闭
*   **现象**: 你看到一个面板闪烁后消失。
*   **原因**: 布局中指定的命令（例如 `claude`, `codex`）未安装或不在你的 PATH 中。
*   **解决方案**:
    1.  安装缺失的工具。
    2.  或者，编辑 `~/.config/zellij/layouts/ai_workstation.kdl` 以使用你实际拥有的工具（例如将 `codex` 替换为 `zsh`）。

## Windows 集成

### 关闭进程时显示 "Access Denied" (拒绝访问)
*   **现象**: `of stop` 无法关闭编辑器。
*   **原因**: `taskkill.exe` 可能需要提升权限才能关闭某些进程，或者进程名称逻辑不正确。
*   **解决方案**: 你可能需要手动关闭窗口，或确保你的用户有权限终止编辑器进程。
