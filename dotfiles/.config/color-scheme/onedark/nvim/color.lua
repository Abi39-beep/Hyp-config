local set = vim.api.nvim_set_hl

vim.cmd("hi clear")

-- base
set(0, "Normal", { fg = "#abb2bf", bg = "#282c34" })
set(0, "CursorLine", { bg = "#2c323c" })
set(0, "LineNr", { fg = "#5c6370" })
set(0, "CursorLineNr", { fg = "#abb2bf" })

-- syntax
set(0, "Comment", { fg = "#5c6370", italic = true })
set(0, "String", { fg = "#98c379" })
set(0, "Function", { fg = "#61afef" })
set(0, "Keyword", { fg = "#c678dd" })
set(0, "Type", { fg = "#e5c07b" })

-- diagnostics
set(0, "DiagnosticError", { fg = "#e06c75" })
set(0, "DiagnosticWarn", { fg = "#e5c07b" })
set(0, "DiagnosticInfo", { fg = "#61afef" })
set(0, "DiagnosticHint", { fg = "#56b6c2" })

-- neo-tree (Replaces NvimTree)
set(0, "NeoTreeNormal", { bg = "#282c34" })
set(0, "NeoTreeNormalNC", { bg = "#282c34" })
set(0, "NeoTreeDirectoryName", { fg = "#61afef" })
set(0, "NeoTreeRootName", { fg = "#c678dd", bold = true }) -- Onedark purple for the root
set(0, "NeoTreeGitAdded", { fg = "#98c379" })
set(0, "NeoTreeGitModified", { fg = "#e5c07b" })
set(0, "NeoTreeGitDeleted", { fg = "#e06c75" })

-- fzf-lua (Replaces Telescope)
set(0, "FzfLuaBorder", { fg = "#3e4452" })
set(0, "FzfLuaCursorLine", { bg = "#2c323c" })
set(0, "FzfLuaNormal", { bg = "#282c34" })

-- git signs
set(0, "GitSignsAdd", { fg = "#98c379" })
set(0, "GitSignsChange", { fg = "#e5c07b" })
set(0, "GitSignsDelete", { fg = "#e06c75" })
