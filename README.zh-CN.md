# 🚀 AI 开发工作站

<div align="center">

**构建你的个人开发操作系统**

一个现代化的、AI 驱动的终端开发工作站，基于：

**WSL2 + WezTerm + Zellij + Zsh + AI CLI + 智能终端**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Shell](https://img.shields.io/badge/Shell-Bash-green.svg)](https://www.gnu.org/software/bash/)
[![Platform](https://img.shields.io/badge/Platform-WSL2-blue.svg)](https://learn.microsoft.com/en-us/windows/wsl/)

[English](README.md) | 简体中文

</div>

---

## ✨ 特性

- **🤖 AI 优先设计**: 预配置多个 AI CLI 工具（Claude、Codex、Gemini）的布局
- **🪟 现代终端**: GPU 加速的 WezTerm，配东京之夜主题
- **🧩 智能分屏**: Zellij 自定义工作区布局
- **🛠️ 现代 CLI 工具**: bat、ripgrep、eza、lazygit、zoxide、delta
- **🖥️ Windows 集成**: 无缝的 WSL2-Windows 工作流
- **📦 项目管理**: `of` - 多项目管理器，支持快速切换
- **⚡ 一键安装**: 自动化安装，带验证功能

---

## 🏗 架构

```
Windows 11
│
└── WSL2 (Linux)
    │
    └── WezTerm (GPU 终端)
        │
        └── Zellij (终端复用器)
            │
            └── Zsh (Shell)
                ├── zsh-autosuggestions
                ├── zsh-syntax-highlighting
                └── fzf
                │
                └── of (项目管理器)
                    └── AI CLI 工具
                        ├── claude
                        ├── codex
                        └── gemini
```

---

## 📸 截图

### AI 工作站布局
四面板布局，实现多 AI 协作：
- **左上**: Claude（架构与推理）
- **右上**: Codex（代码生成）
- **左下**: Gemini（文档与算法）
- **右下**: Shell（Git、服务器、工具）

```
┌─────────────────┬─────────────────┐
│   Claude        │    Codex        │
│   (推理)        │   (生成)        │
├─────────────────┼─────────────────┤
│   Gemini        │    Shell        │
│   (文档)        │   (工具)        │
└─────────────────┴─────────────────┘
```

---

## 🚀 快速开始

### 前置要求

- Windows 11 已启用 WSL2
- WSL2 上安装了 Ubuntu 或其他 Linux 发行版

### 安装

```bash
# 克隆仓库
git clone https://github.com/ai-dev-workstation/ai-dev-workstation.git
cd ai-dev-workstation

# 运行安装程序
./install.sh
```

安装程序将：
- 安装 WezTerm（GPU 终端）
- 安装 Zellij（终端复用器）
- 安装现代 CLI 工具（bat、ripgrep、eza、lazygit、zoxide、delta）
- 配置 shell 别名和集成
- 安装 `of` 项目管理器

### 快速开始

```bash
# 注册你的项目（在项目目录中运行）
of register myproject

# 启动工作站（编辑器 + AI）
of start

# 或仅启动 AI 工作站
of ai
```

---

## 📖 使用方法

### `of` 命令

```bash
# 注册当前目录为项目
of register myproject

# 切换当前项目
of use myproject

# 列出所有已注册项目
of list

# 启动完整工作区（编辑器 + AI）
of start [项目名]

# 仅启动 AI 工作站
of ai [项目名]

# 停止所有工具
of stop

# 显示帮助
of help
```

### 配置

`of` 使用 JSON 格式配置文件 `~/.config/of/projects.json`：

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

---

## 📂 项目结构

```
ai-dev-workstation/
├── README.md                    # 英文介绍
├── README.zh-CN.md              # 中文介绍（本文件）
├── LICENSE                      # MIT 许可证
├── install.sh                   # 一键安装脚本
├── config/
│   ├── zellij/                  # Zellij 配置
│   │   ├── config.kdl
│   │   └── layouts/
│   ├── wezterm/                 # WezTerm 配置
│   │   ├── wezterm.lua
│   │   └── colors/
│   ├── shell/                   # Shell 配置
│   ├── of/                      # of 配置模板
│   │   └── projects.json.example
│   └── templates/               # 旧版项目模板（已废弃）
├── scripts/
│   ├── of/                      # 项目管理器
│   │   └── of
│   ├── setup/                   # 安装脚本
│   │   └── verify-install.sh
│   └── uninstall.sh             # 卸载脚本
└── docs/                        # 文档
    ├── installation.md
    ├── configuration.md
    ├── customization.md
    ├── troubleshooting.md
    └── zh-CN/                   # 中文文档
        └── ...
```

---

## 🎯 使用场景

- **多 AI 开发**: 同时与多个 AI 代理协作
- **游戏开发**: Unity + C# 服务器后端工作流
- **Web 开发**: Node.js/React 全栈开发
- **系统编程**: Rust/Go/C++ 开发环境
- **数据科学**: Python 与 Jupyter 集成

---

## 🧠 理念

> 这个项目不仅仅是工具集合。它是设计你的**个人开发操作系统**。

一个能够：
- **与你一起思考** - AI 代理作为协作伙伴
- **与你一起扩展** - 适应任何项目类型
- **与你一起进化** - 模块化、可扩展架构

---

## 📚 文档

- [Installation Guide](docs/installation.md) | [安装指南](docs/zh-CN/installation.md)
- [Configuration](docs/configuration.md) | [配置指南](docs/zh-CN/configuration.md)
- [Customization](docs/customization.md) | [自定义指南](docs/zh-CN/customization.md)
- [Troubleshooting](docs/troubleshooting.md) | [故障排除](docs/zh-CN/troubleshooting.md)
- [AI 开发工作流](docs/zh-CN/workflows/ai-development.md)

---

## 🤝 贡献

欢迎贡献！请随时提交 Pull Request。

1. Fork 本仓库
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 打开 Pull Request

---

## 📄 许可证

本项目采用 MIT 许可证 - 详见 [LICENSE](LICENSE) 文件。

---

## 🌟 致谢

- [WezTerm](https://wezfurlong.org/wezterm/) - GPU 加速终端模拟器
- [Zellij](https://zellij.dev/) - 终端复用器
- [Tokyo Night](https://github.com/folke/tokyonight.nvim) - 配色方案
- [Oh My Zsh](https://ohmyz.sh/) - Zsh 框架

---

## 📮 联系方式

- GitHub Issues: [https://github.com/ai-dev-workstation/ai-dev-workstation/issues](https://github.com/ai-dev-workstation/ai-dev-workstation/issues)

---

## ☕ 请我喝杯咖啡

如果这个项目对你有帮助，欢迎请我喝杯咖啡！

<div align="center">

![微信支付](screenshots/wechatpayqrcode.jpg)

</div>
