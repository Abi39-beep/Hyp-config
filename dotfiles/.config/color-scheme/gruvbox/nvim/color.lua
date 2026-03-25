local set = vim.api.nvim_set_hl

vim.cmd("hi clear")

-- base
set(0, "Normal", { fg = "#ebdbb2", bg = "#282828" })
set(0, "CursorLine", { bg = "#3c3836" })
set(0, "LineNr", { fg = "#928374" })
set(0, "CursorLineNr", { fg = "#ebdbb2" })

-- syntax
set(0, "Comment", { fg = "#928374", italic = true })
set(0, "String", { fg = "#b8bb26" })
set(0, "Function", { fg = "#8ec07c" })
set(0, "Keyword", { fg = "#fb4934" })
set(0, "Type", { fg = "#fabd2f" })

-- diagnostics
set(0, "DiagnosticError", { fg = "#fb4934" })
set(0, "DiagnosticWarn", { fg = "#fabd2f" })
set(0, "DiagnosticInfo", { fg = "#83a598" })
set(0, "DiagnosticHint", { fg = "#8ec07c" })

-- neo-tree (Replaced NvimTree)
set(0, "NeoTreeNormal", { bg = "#282828" })
set(0, "NeoTreeNormalNC", { bg = "#282828" })
set(0, "NeoTreeDirectoryName", { fg = "#83a598" })
set(0, "NeoTreeRootName", { fg = "#fb4934", bold = true })
set(0, "NeoTreeGitAdded", { fg = "#b8bb26" })
set(0, "NeoTreeGitModified", { fg = "#fabd2f" })
set(0, "NeoTreeGitDeleted", { fg = "#fb4934" })

-- fzf-lua (Replaced Telescope)
set(0, "FzfLuaBorder", { fg = "#504945" })
set(0, "FzfLuaCursorLine", { bg = "#3c3836" })
set(0, "FzfLuaNormal", { bg = "#282828" })

-- git signs
set(0, "GitSignsAdd", { fg = "#b8bb26" })
set(0, "GitSignsChange", { fg = "#fabd2f" })
set(0, "GitSignsDelete", { fg = "#fb4934" })
