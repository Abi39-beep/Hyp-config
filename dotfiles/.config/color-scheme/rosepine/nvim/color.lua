local set = vim.api.nvim_set_hl

vim.cmd("hi clear")

-- base
set(0, "Normal", { fg = "#e0def4", bg = "#191724" })
set(0, "CursorLine", { bg = "#1f1d2e" })
set(0, "LineNr", { fg = "#6e6a86" })
set(0, "CursorLineNr", { fg = "#e0def4" })

-- syntax
set(0, "Comment", { fg = "#908caa", italic = true })
set(0, "String", { fg = "#f6c177" })
set(0, "Function", { fg = "#9ccfd8" })
set(0, "Keyword", { fg = "#c4a7e7" })
set(0, "Type", { fg = "#ebbcba" })

-- diagnostics
set(0, "DiagnosticError", { fg = "#eb6f92" })
set(0, "DiagnosticWarn", { fg = "#f6c177" })
set(0, "DiagnosticInfo", { fg = "#9ccfd8" })
set(0, "DiagnosticHint", { fg = "#c4a7e7" })

-- neo-tree
set(0, "NeoTreeNormal", { bg = "#191724" })
set(0, "NeoTreeNormalNC", { bg = "#191724" })
set(0, "NeoTreeDirectoryName", { fg = "#c4a7e7" })
set(0, "NeoTreeRootName", { fg = "#eb6f92", bold = true })
set(0, "NeoTreeGitAdded", { fg = "#9ccfd8" })
set(0, "NeoTreeGitModified", { fg = "#ebbcba" })
set(0, "NeoTreeGitDeleted", { fg = "#eb6f92" })

-- fzf-lua
set(0, "FzfLuaBorder", { fg = "#403d52" })
set(0, "FzfLuaCursorLine", { bg = "#1f1d2e" })
set(0, "FzfLuaNormal", { bg = "#191724" })

-- git signs
set(0, "GitSignsAdd", { fg = "#9ccfd8" })
set(0, "GitSignsChange", { fg = "#ebbcba" })
set(0, "GitSignsDelete", { fg = "#eb6f92" })
