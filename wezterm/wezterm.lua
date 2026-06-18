local wezterm = require 'wezterm'
local act = wezterm.action
local is_windows = wezterm.target_triple:find('windows') ~= nil

local config = {
  color_schemes = {
    Hardcore = {
      foreground = '#d0d0d0',
      background = '#0f1117',
      cursor_bg = '#7aa2f7',
      cursor_fg = '#0f1117',
      cursor_border = '#7aa2f7',
      selection_fg = '#f8f8f2',
      selection_bg = '#334155',
      ansi = {
        '#121212',
        '#f92672',
        '#a6e22e',
        '#e6db74',
        '#66d9ef',
        '#ae81ff',
        '#a1efe4',
        '#d0d0d0',
      },
      brights = {
        '#505050',
        '#ff669d',
        '#beed5f',
        '#fff27f',
        '#66d9ef',
        '#c6a3ff',
        '#a1efe4',
        '#f8f8f2',
      },
    },
  },
  color_scheme = 'Hardcore',

  font = wezterm.font('JetBrainsMono NFM'),
  font_size = 11,
  harfbuzz_features = { 'calt=0', 'liga=0' },

  default_cursor_style = 'SteadyBar',
  window_decorations = 'TITLE|RESIZE',
  window_background_opacity = 0.86,
  macos_window_background_blur = 24,
  win32_system_backdrop = 'Acrylic',
  win32_acrylic_accent_color = '#0f1117',
  window_padding = {
    left = 14,
    right = 14,
    top = 14,
    bottom = 14,
  },
  inactive_pane_hsb = {
    saturation = 0.85,
    brightness = 0.72,
  },
  hide_tab_bar_if_only_one_tab = true,
  use_fancy_tab_bar = false,
  show_new_tab_button_in_tab_bar = false,
  show_tab_index_in_tab_bar = false,

  automatically_reload_config = true,
  hide_mouse_cursor_when_typing = true,
  use_dead_keys = false,
  send_composed_key_when_left_alt_is_pressed = false,
  send_composed_key_when_right_alt_is_pressed = false,

  keys = {
    -- Disable default split/tab navigation keys.
    { key = 'Tab', mods = 'CTRL|SHIFT', action = act.DisableDefaultAssignment },
    { key = 'Tab', mods = 'CTRL', action = act.DisableDefaultAssignment },
    { key = 't', mods = 'CTRL|SHIFT', action = act.DisableDefaultAssignment },
    { key = '[', mods = 'SUPER|SHIFT', action = act.DisableDefaultAssignment },
    { key = ']', mods = 'SUPER|SHIFT', action = act.DisableDefaultAssignment },
    { key = '{', mods = 'SUPER|SHIFT', action = act.Nop },
    { key = '}', mods = 'SUPER|SHIFT', action = act.Nop },
    { key = 'd', mods = 'SUPER', action = act.DisableDefaultAssignment },
    { key = 'd', mods = 'SUPER|SHIFT', action = act.DisableDefaultAssignment },
    { key = 'UpArrow', mods = 'SUPER|ALT', action = act.DisableDefaultAssignment },
    { key = 'DownArrow', mods = 'SUPER|ALT', action = act.DisableDefaultAssignment },
    { key = 'LeftArrow', mods = 'SUPER|ALT', action = act.DisableDefaultAssignment },
    { key = 'RightArrow', mods = 'SUPER|ALT', action = act.DisableDefaultAssignment },
    { key = '1', mods = 'SUPER', action = act.DisableDefaultAssignment },
    { key = '2', mods = 'SUPER', action = act.DisableDefaultAssignment },
    { key = '3', mods = 'SUPER', action = act.DisableDefaultAssignment },
    { key = '4', mods = 'SUPER', action = act.DisableDefaultAssignment },
    { key = '5', mods = 'SUPER', action = act.DisableDefaultAssignment },
    { key = '6', mods = 'SUPER', action = act.DisableDefaultAssignment },
    { key = '7', mods = 'SUPER', action = act.DisableDefaultAssignment },
    { key = '8', mods = 'SUPER', action = act.DisableDefaultAssignment },
    { key = '9', mods = 'SUPER', action = act.DisableDefaultAssignment },

    -- Clipboard.
    { key = 'c', mods = 'CTRL|SHIFT', action = act.CopyTo 'Clipboard' },
    { key = 'v', mods = 'CTRL|SHIFT', action = act.PasteFrom 'Clipboard' },
    { key = 'c', mods = 'SUPER', action = act.CopyTo 'Clipboard' },
    { key = 'v', mods = 'SUPER', action = act.PasteFrom 'Clipboard' },

    -- Split navigation.
    { key = 'h', mods = 'ALT', action = act.ActivatePaneDirection 'Left' },
    { key = 'j', mods = 'ALT', action = act.ActivatePaneDirection 'Down' },
    { key = 'k', mods = 'ALT', action = act.ActivatePaneDirection 'Up' },
    { key = 'l', mods = 'ALT', action = act.ActivatePaneDirection 'Right' },

    -- Split creation.
    { key = 'v', mods = 'ALT', action = act.SplitPane { direction = 'Right', size = { Percent = 50 } } },
    { key = 's', mods = 'ALT', action = act.SplitPane { direction = 'Down', size = { Percent = 50 } } },

    -- Split resizing.
    { key = 'H', mods = 'ALT|SHIFT', action = act.AdjustPaneSize { 'Left', 10 } },
    { key = 'J', mods = 'ALT|SHIFT', action = act.AdjustPaneSize { 'Down', 10 } },
    { key = 'K', mods = 'ALT|SHIFT', action = act.AdjustPaneSize { 'Up', 10 } },
    { key = 'L', mods = 'ALT|SHIFT', action = act.AdjustPaneSize { 'Right', 10 } },

    -- Split commands.
    { key = 'q', mods = 'ALT', action = act.CloseCurrentPane { confirm = false } },
    { key = 'Enter', mods = 'ALT', action = act.TogglePaneZoomState },
    { key = 'e', mods = 'ALT', action = act.Nop },

    -- Tab creation.
    { key = 't', mods = 'CTRL', action = act.SpawnTab 'CurrentPaneDomain' },

    -- Tab navigation.
    { key = 'phys:LeftBracket', mods = 'ALT|SHIFT', action = act.ActivateTabRelative(-1) },
    { key = 'phys:RightBracket', mods = 'ALT|SHIFT', action = act.ActivateTabRelative(1) },
    { key = '[', mods = 'ALT|SHIFT', action = act.ActivateTabRelative(-1) },
    { key = ']', mods = 'ALT|SHIFT', action = act.ActivateTabRelative(1) },
    { key = '{', mods = 'ALT', action = act.ActivateTabRelative(-1) },
    { key = '}', mods = 'ALT', action = act.ActivateTabRelative(1) },
    { key = '{', mods = 'ALT|SHIFT', action = act.ActivateTabRelative(-1) },
    { key = '}', mods = 'ALT|SHIFT', action = act.ActivateTabRelative(1) },

    -- Config.
    { key = 'r', mods = 'SUPER', action = act.ReloadConfiguration },
  },

  mouse_bindings = {
    {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'NONE',
      action = act.Multiple {
        act.CompleteSelectionOrOpenLinkAtMouseCursor 'ClipboardAndPrimarySelection',
        act.ClearSelection,
      },
    },
    {
      event = { Up = { streak = 1, button = 'Right' } },
      mods = 'NONE',
      action = act.Multiple {
        act.CopyTo 'Clipboard',
        act.ClearSelection,
      },
    },
  },
}

if is_windows then
  config.default_prog = { 'wsl.exe', '-d', 'Ubuntu-24.04', '--cd', '~' }

  wezterm.on('format-tab-title', function(tab)
    local title = tab.tab_title

    if not title or #title == 0 then
      title = 'Ubuntu'
    end

    return {
      { Text = ' ' .. title .. ' ' },
    }
  end)

  wezterm.on('format-window-title', function()
    return 'Ubuntu'
  end)
end

return config
