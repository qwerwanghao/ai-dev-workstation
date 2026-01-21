-- WezTerm configuration for AI Dev Workstation
-- Integrates with Zellij for terminal multiplexing

local wezterm = require('wezterm')
local config = wezterm.config_builder()
local colors = require('colors.tokyonight')

-------------------------------------------------------------------------------
-- Basic Configuration
-------------------------------------------------------------------------------

config:set_strict_mode(true)
config.colors = colors

-- Font configuration
config.font = wezterm.font('JetBrains Mono', { weight = 'Regular' })
config.font_size = 11.0
config.line_height = 1.2

-- Window configuration
config.window_padding = {
  left = 8,
  right = 8,
  top = 8,
  bottom = 8,
}
config.window_background_opacity = 0.95
config.window_close_confirmation = 'NeverPrompt'
config.window_decorations = "RESIZE"

-- Tab bar configuration
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = false

-- Scrollback
config.scrollback_lines = 10000

-------------------------------------------------------------------------------
-- Key Bindings (vim-style)
-------------------------------------------------------------------------------

config.leader = { key = 'b', mods = 'CTRL', timeout_milliseconds = 1000 }

config.keys = {
  -- Split panes
  { key = '"', mods = 'LEADER|SHIFT', action = wezterm.action.SplitVertical({ domain = 'CurrentPaneDomain' }) },
  { key = '%', mods = 'LEADER|SHIFT', action = wezterm.action.SplitHorizontal({ domain = 'CurrentPaneDomain' }) },

  -- Navigate panes (vim-style)
  { key = 'h', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection('Left') },
  { key = 'j', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection('Down') },
  { key = 'k', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection('Up') },
  { key = 'l', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection('Right') },

  -- Resize panes
  { key = 'H', mods = 'LEADER|SHIFT', action = wezterm.action.AdjustPaneSize({ 'Left', 2 }) },
  { key = 'J', mods = 'LEADER|SHIFT', action = wezterm.action.AdjustPaneSize({ 'Down', 2 }) },
  { key = 'K', mods = 'LEADER|SHIFT', action = wezterm.action.AdjustPaneSize({ 'Up', 2 }) },
  { key = 'L', mods = 'LEADER|SHIFT', action = wezterm.action.AdjustPaneSize({ 'Right', 2 }) },

  -- Close pane
  { key = 'x', mods = 'LEADER', action = wezterm.action.CloseCurrentPane({ confirm = false }) },

  -- Rotate panes
  { key = 'o', mods = 'LEADER', action = wezterm.action.RotatePanes('CounterClockwise') },

  -- Tabs
  { key = 'c', mods = 'LEADER', action = wezterm.action.SpawnTab('CurrentPaneDomain') },
  { key = 'n', mods = 'LEADER', action = wezterm.action.ActivateTabRelative(1) },
  { key = 'p', mods = 'LEADER', action = wezterm.action.ActivateTabRelative(-1) },
  { key = ',', mods = 'LEADER', action = wezterm.action.PromptInputLine {
    description = 'Enter new name for tab',
    action = wezterm.action_callback(function(window, pane, line)
      if line then
        window:active_tab():set_title(line)
      end
    end),
  } },

  -- AI Workstation quick launch
  { key = 'a', mods = 'LEADER', action = wezterm.action.SpawnCommandInNewTab({
    args = { 'zellij', '--layout', 'ai_workstation' },
  })},

  -- Copy mode
  { key = '[', mods = 'LEADER', action = wezterm.action.ActivateCopyMode },

  -- Quick select
  { key = 's', mods = 'LEADER', action = wezterm.action.QuickSelect },

  -- Debug overlay
  { key = 'L', mods = 'CTRL|SHIFT', action = wezterm.action.ShowDebugOverlay },
}

-- Key tables for copy mode
config.key_tables = {
  copy_mode = {
    -- Vim-style copy mode bindings
    { key = 'c', mods = 'CTRL', action = wezterm.action.CopyMode 'Close' },
    { key = 'q', mods = 'NONE', action = wezterm.action.CopyMode 'Close' },
    { key = 'Escape', mods = 'NONE', action = wezterm.action.CopyMode 'Close' },

    -- Movement
    { key = 'h', mods = 'NONE', action = wezterm.action.CopyMode 'MoveLeft' },
    { key = 'j', mods = 'NONE', action = wezterm.action.CopyMode 'MoveDown' },
    { key = 'k', mods = 'NONE', action = wezterm.action.CopyMode 'MoveUp' },
    { key = 'l', mods = 'NONE', action = wezterm.action.CopyMode 'MoveRight' },

    -- Copy
    { key = 'y', mods = 'NONE', action = wezterm.action.Multiple {
      { CopyTo = 'ClipboardAndPrimarySelection' },
      { CopyMode = 'Close' }
    }},

    -- Search
    { key = '/', mods = 'NONE', action = wezterm.action.Search { CaseSensitiveString = '' } },
  },
}

-------------------------------------------------------------------------------
-- Mouse Bindings
-------------------------------------------------------------------------------

config.mouse_bindings = {
  -- Change click behavior to select text only
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'NONE',
    action = wezterm.action.CompleteSelection('PrimarySelection'),
  },
  -- CTRL-Click to open URL
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CTRL',
    action = wezterm.action.OpenLinkAtMouseCursor('DefaultBrowser'),
  },
  -- Select and copy on drag
  {
    event = { Down = { streak = 1, button = 'Left' } },
    mods = 'NONE',
    action = wezterm.action.SelectTextAtMouseCursor('Cell'),
  },
}

-------------------------------------------------------------------------------
-- Launch Configuration
-------------------------------------------------------------------------------

-- Auto-launch Zellij on startup
config.default_prog = { 'zellij', '--layout', 'ai_workstation' }

-- Alternatively, uncomment to use bash instead:
-- config.default_prog = { '/bin/bash' }

-------------------------------------------------------------------------------
-- Domain-specific configuration
-------------------------------------------------------------------------------

-- WSL-specific settings
if wezterm.target_triple == 'x86_64-unknown-linux-gnu' or
   wezterm.target_triple == 'aarch64-unknown-linux-gnu' then
  config.default_domain = 'WSL:Ubuntu'
end

-------------------------------------------------------------------------------
return config
