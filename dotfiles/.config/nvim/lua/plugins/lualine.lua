return {
  'nvim-lualine/lualine.nvim',
  config = function()
    -- Helper function to extract colors from your active highlight groups
    -- It fetches the specific foreground ('fg') or background ('bg') of a group
    local function get_hl_color(group_name, attr)
      local hl = vim.api.nvim_get_hl(0, { name = group_name })
      if hl and hl[attr] then
        -- Convert the integer color to a hex string (e.g., #D3C6AA)
        return string.format('#%06x', hl[attr])
      end
      return nil
    end

    -- Dynamically map your color.lua groups to lualine variables.
    -- The second string is a fallback color just in case it loads before color.lua
    local colors = {
      bg     = get_hl_color('Normal', 'bg')          or '#2D353B',
      fg     = get_hl_color('Normal', 'fg')          or '#D3C6AA',
      green  = get_hl_color('String', 'fg')          or '#A7C080',
      blue   = get_hl_color('DiagnosticInfo', 'fg')  or '#7FBBB3',
      red    = get_hl_color('Keyword', 'fg')         or '#E67E80',
      yellow = get_hl_color('Type', 'fg')            or '#DBBC7F',
      gray1  = get_hl_color('Comment', 'fg')         or '#859289',
      gray2  = get_hl_color('CursorLine', 'bg')      or '#343F44',
      gray3  = get_hl_color('TelescopeBorder', 'fg') or '#3D484D',
    }

    -- Build the theme using the extracted colors
    local dynamic_theme = {
      normal = {
        a = { fg = colors.bg, bg = colors.green, gui = 'bold' },
        b = { fg = colors.fg, bg = colors.gray3 },
        c = { fg = colors.fg, bg = colors.gray2 },
      },
      command = { a = { fg = colors.bg, bg = colors.yellow, gui = 'bold' } },
      insert = { a = { fg = colors.bg, bg = colors.blue, gui = 'bold' } },
      visual = { a = { fg = colors.bg, bg = colors.red, gui = 'bold' } },
      terminal = { a = { fg = colors.bg, bg = colors.blue, gui = 'bold' } },
      replace = { a = { fg = colors.bg, bg = colors.red, gui = 'bold' } },
      inactive = {
        a = { fg = colors.gray1, bg = colors.bg, gui = 'bold' },
        b = { fg = colors.gray1, bg = colors.bg },
        c = { fg = colors.gray1, bg = colors.gray2 },
      },
    }

    local hide_in_width = function()
      return vim.fn.winwidth(0) > 100
    end

    local mode = {
      'mode',
      fmt = function(str)
        if hide_in_width() then
          return ' ' .. str
        else
          return ' ' .. str:sub(1, 1) -- displays only the first character of the mode
        end
      end,
    }

    local filename = {
      'filename',
      file_status = true, 
      path = 0, 
    }

    local diagnostics = {
      'diagnostics',
      sources = { 'nvim_diagnostic' },
      sections = { 'error', 'warn' },
      symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
      colored = false,
      update_in_insert = false,
      always_visible = false,
      cond = hide_in_width,
    }

    local diff = {
      'diff',
      colored = false,
      symbols = { added = ' ', modified = ' ', removed = ' ' }, 
      cond = hide_in_width,
    }

    require('lualine').setup {
      options = {
        icons_enabled = true,
        -- Apply our auto-generated theme here!
        theme = dynamic_theme, 
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        disabled_filetypes = { 'alpha', 'neo-tree', 'Avante' },
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { mode },
        lualine_b = { 'branch' },
        lualine_c = { filename },
        lualine_x = { diagnostics, diff, { 'encoding', cond = hide_in_width }, { 'filetype', cond = hide_in_width } },
        lualine_y = { 'location' },
        lualine_z = { 'progress' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { { 'location', padding = 0 } },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = { 'fugitive' },
    }
  end,
}
