-- Tokyo Night color scheme for WezTerm
-- Based on https://github.com/folke/tokyonight.nvim

local colors = {
  -- Base colors
  foreground = '#c0caf5',
  background = '#1a1b26',

  -- Cursor
  cursor_fg = '#1a1b26',
  cursor_bg = '#c0caf5',
  cursor_border = '#c0caf5',

  -- Selection
  selection_fg = '#c0caf5',
  selection_bg = '#33467c',

  -- Scrollbar
  scrollbar_thumb = '#394b70',

  -- Split
  split = '#7aa2f7',

  -- ANSI colors (normal)
  ansi = {
    '#15161e',  -- black (background)
    '#f7768e',  -- red
    '#9ece6a',  -- green
    '#e0af68',  -- yellow
    '#7aa2f7',  -- blue
    '#bb9af7',  -- magenta
    '#7dcfff',  -- cyan
    '#a9b1d6',  -- white
  },

  -- ANSI colors (bright)
  brights = {
    '#414868',  -- bright black
    '#f7768e',  -- bright red
    '#9ece6a',  -- bright green
    '#e0af68',  -- bright yellow
    '#7aa2f7',  -- bright blue
    '#bb9af7',  -- bright magenta
    '#7dcfff',  -- bright cyan
    '#c0caf5',  -- bright white
  },

  -- Indexed colors (for compatibility)
  indexed = {
    [16] = '#ff9e64',  -- orange
    [17] = '#db4b4b',  -- bright red
  },

  -- Tab bar colors
  tab_bar = {
    background = '#1a1b26',

    -- Active tab
    active_tab = {
      bg_color = '#7aa2f7',
      fg_color = '#1a1b26',
      intensity = 'Normal',
      italic = false,
      strikethrough = false,
      underline = 'None',
    },

    -- Inactive tab
    inactive_tab = {
      bg_color = '#16161e',
      fg_color = '#565f89',
      intensity = 'Normal',
      italic = false,
      strikethrough = false,
      underline = 'None',
    },

    -- Inactive tab on hover
    inactive_tab_hover = {
      bg_color = '#1a1b26',
      fg_color = '#7aa2f7',
      intensity = 'Normal',
      italic = false,
      strikethrough = false,
      underline = 'None',
    },

    -- New tab button
    new_tab = {
      bg_color = '#1a1b26',
      fg_color = '#565f89',
      intensity = 'Normal',
      italic = false,
      strikethrough = false,
      underline = 'None',
    },

    -- New tab button on hover
    new_tab_hover = {
      bg_color = '#16161e',
      fg_color = '#7aa2f7',
      intensity = 'Normal',
      italic = false,
      strikethrough = false,
      underline = 'None',
    },
  },
}

-- Visual bell (flash on bell)
colors.visual_bell = '#33467c'

-- Index for compose key (16 colors)
colors.compose_cursor = '#7dcfff'

-- Color for the indicator showing where a block selection edge is
colors.selection_fg = 'None'

-- Hyperlink color
colors.hyperlink = '#7dcfff'

-- Color for the leader key
colors.leader = '#bb9af7'

return colors
