# 🚀 AI Dev Workstation

<div align="center">

**Build Your Personal Development Operating System**

A modern, AI-powered terminal-based development workstation built on:

**WSL2 + WezTerm + Zellij + Zsh + AI CLI + Smart Shell**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Shell](https://img.shields.io/badge/Shell-Bash-green.svg)](https://www.gnu.org/software/bash/)
[![Platform](https://img.shields.io/badge/Platform-WSL2-blue.svg)](https://learn.microsoft.com/en-us/windows/wsl/)

</div>

---

## ✨ Features

- **🤖 AI-First Design**: Pre-configured layouts for multiple AI CLI tools (Claude, Codex, Gemini)
- **🪟 Modern Terminal**: GPU-accelerated WezTerm with Tokyo Night theme
- **🧩 Smart Multiplexing**: Zellij with custom workspace layouts
- **🛠️ Modern CLI Tools**: bat, ripgrep, eza, lazygit, zoxide, delta
- **🖥️ Windows Integration**: Seamless WSL2-Windows workflow
- **📦 Project Management**: `of` - multi-project manager with quick switching
- **⚡ One-Command Setup**: Automated installation with verification

---

## 🏗 Architecture

```
Windows 11
│
└── WSL2 (Linux)
    │
    └── WezTerm (GPU Terminal)
        │
        └── Zellij (Terminal Multiplexer)
            │
            └── Zsh (Shell)
                ├── zsh-autosuggestions
                ├── zsh-syntax-highlighting
                └── fzf
                │
                └── of (Project Manager)
                    └── AI CLI Tools
                        ├── claude
                        ├── codex
                        └── gemini
```

---

## 📸 Screenshots

### AI Workstation Layout
A 4-pane layout for multi-AI collaboration:
- **Top-Left**: Claude (Architecture & Reasoning)
- **Top-Right**: Codex (Code Generation)
- **Bottom-Left**: Gemini (Docs & Algorithms)
- **Bottom-Right**: Shell (Git, Server, Tools)

```
┌─────────────────┬─────────────────┐
│   Claude        │    Codex        │
│   (Reasoning)   │   (Generation)  │
├─────────────────┼─────────────────┤
│   Gemini        │    Shell        │
│   (Docs)        │   (Tools)       │
└─────────────────┴─────────────────┘
```

---

## 🚀 Quick Start

### Prerequisites

- Windows 11 with WSL2 enabled
- Ubuntu or other Linux distro on WSL2

### Installation

```bash
# Clone the repository
git clone https://github.com/ai-dev-workstation/ai-dev-workstation.git
cd ai-dev-workstation

# Run the installer
./install.sh
```

The installer will:
- Install WezTerm (GPU terminal)
- Install Zellij (terminal multiplexer)
- Install modern CLI tools (bat, ripgrep, eza, lazygit, zoxide, delta)
- Configure your shell with aliases and integrations
- Install the `of` project manager

### Get Started

```bash
# Register your project (run from project directory)
of register myproject

# Start your workstation (editor + AI)
of start

# Or start AI workstation only
of ai
```

---

## 📖 Usage

### The `of` Command

```bash
# Register current directory as a project
of register myproject

# Switch current project
of use myproject

# List all registered projects
of list

# Start full workspace (editor + AI)
of start [project_name]

# Start AI workstation only
of ai [project_name]

# Stop all tools
of stop

# Show help
of help
```

### Configuration

`of` uses JSON configuration at `~/.config/of/projects.json`:

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

## 📂 Project Structure

```
ai-dev-workstation/
├── README.md                    # This file
├── README.zh-CN.md              # 中文介绍
├── LICENSE                      # MIT License
├── install.sh                   # One-command installer
├── config/
│   ├── zellij/                  # Zellij configurations
│   │   ├── config.kdl
│   │   └── layouts/
│   ├── wezterm/                 # WezTerm configurations
│   │   ├── wezterm.lua
│   │   └── colors/
│   ├── shell/                   # Shell configurations
│   ├── of/                      # of configuration templates
│   │   └── projects.json.example
│   └── templates/               # Legacy project templates
├── scripts/
│   ├── of/                      # Project manager
│   │   └── of
│   ├── setup/                   # Setup scripts
│   │   └── verify-install.sh
│   └── uninstall.sh             # Uninstaller
└── docs/                        # Documentation
    ├── installation.md
    ├── configuration.md
    ├── customization.md
    ├── troubleshooting.md
    └── zh-CN/                   # 中文文档
        └── ...
```

---

## 🎯 Use Cases

- **Multi-AI Development**: Collaborate with multiple AI agents simultaneously
- **Game Development**: Unity + C# server backend workflow
- **Web Development**: Node.js/React full-stack development
- **System Programming**: Rust/Go/C++ development environments
- **Data Science**: Python with Jupyter integration

---

## 🧠 Philosophy

> This project is not just about tools. It's about designing your **personal development operating system**.

A system that:
- **Thinks with you** - AI agents as collaborative partners
- **Scales with you** - Adapts to any project type
- **Evolves with you** - Modular and extensible architecture

---

## 📚 Documentation

- [Installation Guide](docs/installation.md) | [安装指南](docs/zh-CN/installation.md)
- [Configuration](docs/configuration.md) | [配置指南](docs/zh-CN/configuration.md)
- [Customization](docs/customization.md) | [自定义指南](docs/zh-CN/customization.md)
- [Troubleshooting](docs/troubleshooting.md) | [故障排除](docs/zh-CN/troubleshooting.md)
- [AI Development Workflows](docs/workflows/ai-development.md)

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🌟 Acknowledgments

- [WezTerm](https://wezfurlong.org/wezterm/) - GPU-accelerated terminal emulator
- [Zellij](https://zellij.dev/) - Terminal multiplexer
- [Tokyo Night](https://github.com/folke/tokyonight.nvim) - Color scheme
- [Oh My Zsh](https://ohmyz.sh/) - Zsh framework

---

## 📮 Contact

- GitHub Issues: [https://github.com/ai-dev-workstation/ai-dev-workstation/issues](https://github.com/ai-dev-workstation/ai-dev-workstation/issues)

---

<div align="center">

**Made with ❤️ by developers, for developers**

[⬆ Back to Top](#-ai-dev-workstation)

</div>
