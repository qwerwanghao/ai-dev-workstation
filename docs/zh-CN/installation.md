# 安装指南

本指南将帮助你在 Windows 11 机器上安装 AI 开发工作站（WSL2 环境）。

## 目录

- [前置要求](#前置要求)
- [快速安装](#快速安装)
- [手动安装](#手动安装)
- [验证安装](#验证安装)
- [故障排除](#故障排除)

---

## 前置要求

### 必需项

- **Windows 11** 已启用 WSL2
- WSL2 上的 **Ubuntu** 或其他 Linux 发行版
- WSL2 上已安装 **Git**
- WSL2 上已安装 **Curl**

### 启用 WSL2

如果尚未启用 WSL2，请在 PowerShell（以管理员身份运行）中运行：

```powershell
wsl --install
```

根据提示重启电脑。

### 验证 WSL2

打开 Ubuntu/WSL 并验证：

```bash
# 检查 WSL 版本
wsl --status

# 验证是否运行 WSL2
uname -r
# 应显示: ...-microsoft-standard
```

---

## 快速安装

### 1. 克隆仓库

```bash
git clone https://github.com/yourname/ai-dev-workstation.git
cd ai-dev-workstation
```

### 2. 运行安装程序

```bash
chmod +x install.sh
./install.sh
```

安装程序将：
- 安装 WezTerm
- 安装 Zellij
- 安装 CLI 工具（bat、ripgrep、eza、lazygit、zoxide、delta）
- 配置你的 shell
- 安装 `mm` 项目管理器

### 3. 重新加载 Shell

```bash
source ~/.bashrc
```

### 4. 初始化你的项目

```bash
mm init /path/to/project
```

---

## 手动安装

如果你希望单独安装各个组件：

### WezTerm

```bash
# 添加 WezTerm PPA
curl -fsSL https://wezfurlong.org/releases/apt/pubkey.asc | sudo gpg --dearmor -o /usr/share/keyrings/wezterm.gpg
echo "deb [signed-by=/usr/share/keyrings/wezterm.gpg] https://wezfurlong.org/releases/apt/debian stable main" | sudo tee /etc/apt/sources.list.d/wezterm.list

# 安装
sudo apt update
sudo apt install -y wezterm
```

### Zellij

```bash
sudo apt install -y zellij
```

### CLI 工具

```bash
# 基础工具
sudo apt install -y bat ripgrep fzf

# eza（现代 ls）
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza

# lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin

# zoxide
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

# delta（git diff）
DELTA_VERSION=$(curl -s "https://api.github.com/repos/dandavison/delta/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+")
wget "https://github.com/dandavison/delta/releases/download/${DELTA_VERSION}/delta-${DELTA_VERSION}-x86_64-unknown-linux-gnu.tar.gz"
tar xzf delta-${DELTA_VERSION}-x86_64-unknown-linux-gnu.tar.gz
sudo install delta-${DELTA_VERSION}-x86_64-unknown-linux-gnu/delta /usr/local/bin
```

### MM 项目管理器

```bash
# 安装 mm
mkdir -p ~/bin
cp scripts/mm/mm ~/bin/mm
chmod +x ~/bin/mm

# 复制 mm 库文件
mkdir -p ~/.ai-dev-workstation/mm
cp scripts/mm/*.sh ~/.ai-dev-workstation/mm/

# 更新 mm 脚本路径
sed -i "s|SCRIPT_DIR=.*|SCRIPT_DIR=\"$HOME/.ai-dev-workstation/mm\"|" ~/bin/mm
```

### 配置文件

```bash
# Zellij
mkdir -p ~/.config/zellij/layouts
cp config/zellij/config.kdl ~/.config/zellij/
cp config/zellij/layouts/*.kdl ~/.config/zellij/layouts/

# WezTerm
mkdir -p ~/.config/wezterm/colors
cp config/wezterm/wezterm.lua ~/.config/wezterm/
cp config/wezterm/colors/*.lua ~/.config/wezterm/colors/
```

---

## 验证安装

运行验证脚本：

```bash
bash scripts/setup/verify-install.sh
```

预期输出：
```
======================================
AI Dev Workstation - Installation Verification
======================================

Terminal Emulators:
✓ WezTerm: wezterm 0.0.0

Terminal Multiplexer:
✓ Zellij: zellij 0.43.1

CLI Tools:
✓ bat: bat 0.24
✓ ripgrep: rg 14.1.0
✓ eza: eza 0.18.0
✓ lazygit: lazygit 0.40.0
✓ zoxide: zoxide
✓ delta: delta 0.16.0
✓ fzf: fzf 0.44.1

Project Management:
✓ mm script: /home/user/bin/mm
✓ mm libraries: /home/user/.ai-dev-workstation/mm
ℹ mm config: not found (run 'mm init')
```

---

## 故障排除

### WezTerm 无法启动

- 确保已安装 GPU 驱动程序
- 先从 Windows PowerShell 运行 WezTerm 测试
- 检查 WezTerm 日志：`~/.wezterm.log`

### Zellij 布局未找到

```bash
# 验证布局是否已安装
ls ~/.config/zellij/layouts/

# 如果缺失，重新安装
cp config/zellij/layouts/*.kdl ~/.config/zellij/layouts/
```

### MM 命令未找到

```bash
# 检查 mm 是否在 PATH 中
echo $PATH | grep -o ~/bin

# 如果不在，添加到 PATH
export PATH="$HOME/bin:$PATH"
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
```

### 权限被拒绝

```bash
# 使脚本可执行
chmod +x install.sh
chmod +x ~/bin/mm
```

---

## 下一步

1. [配置你的项目](configuration.md)
2. [自定义布局](customization.md)
3. [学习 AI 工作流](workflows/ai-development.md)
