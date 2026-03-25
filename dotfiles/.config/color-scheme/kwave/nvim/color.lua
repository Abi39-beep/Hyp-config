local set = vim.api.nvim_set_hl

vim.cmd("hi clear")

-- base
set(0, "Normal", { fg = "#dcd7ba", bg = "#1f1f28" })
set(0, "CursorLine", { bg = "#2a2a37" })
set(0, "LineNr", { fg = "#54546d" })
set(0, "CursorLineNr", { fg = "#e6c384" })

-- syntax
set(0, "Comment", { fg = "#727169", italic = true })
set(0, "String", { fg = "#98bb6c" })
set(0, "Function", { fg = "#7e9cd8" })
set(0, "Keyword", { fg = "#957fb8" })
set(0, "Type", { fg = "#e6c384" })

-- diagnostics
set(0, "DiagnosticError", { fg = "#e82424" })
set(0, "DiagnosticWarn", { fg = "#ff9e3b" })
set(0, "DiagnosticInfo", { fg = "#7e9cd8" })
set(0, "DiagnosticHint", { fg = "#7aa89f" })

-- neo-tree (Replaces NvimTree)
set(0, "NeoTreeNormal", { bg = "#1f1f28" })
set(0, "NeoTreeNormalNC", { bg = "#1f1f28" })
set(0, "NeoTreeDirectoryName", { fg = "#7e9cd8" })
set(0, "NeoTreeRootName", { fg = "#957fb8", bold = true }) -- Kanagawa Wave purple for the root
set(0, "NeoTreeGitAdded", { fg = "#98bb6c" })
set(0, "NeoTreeGitModified", { fg = "#e6c384" })
set(0, "NeoTreeGitDeleted", { fg = "#e82424" })

-- fzf-lua (Replaces Telescope)
set(0, "FzfLuaBorder", { fg = "#54546d" })
set(0, "FzfLuaCursorLine", { bg = "#2d4f67" })
set(0, "FzfLuaNormal", { bg = "#1f1f28" })

-- git signs
set(0, "GitSignsAdd", { fg = "#98bb6c" })
set(0, "GitSignsChange", { fg = "#e6c384" })
set(0, "GitSignsDelete", { fg = "#e82424" })
