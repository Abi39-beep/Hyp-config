local set = vim.api.nvim_set_hl

vim.cmd("hi clear")

-- base
set(0, "Normal", { fg = "#c5c9c5", bg = "#181616" })
set(0, "CursorLine", { bg = "#282727" })
set(0, "LineNr", { fg = "#717c7c" })
set(0, "CursorLineNr", { fg = "#c4b28a" })

-- syntax
set(0, "Comment", { fg = "#a6a69c", italic = true })
set(0, "String", { fg = "#8a9a7b" })
set(0, "Function", { fg = "#8ba4b0" })
set(0, "Keyword", { fg = "#a292a3" })
set(0, "Type", { fg = "#c4b28a" })

-- diagnostics
set(0, "DiagnosticError", { fg = "#c4746e" })
set(0, "DiagnosticWarn", { fg = "#b6927b" })
set(0, "DiagnosticInfo", { fg = "#8ba4b0" })
set(0, "DiagnosticHint", { fg = "#8ea4a2" })

-- neo-tree (Replaces NvimTree)
set(0, "NeoTreeNormal", { bg = "#181616" })
set(0, "NeoTreeNormalNC", { bg = "#181616" })
set(0, "NeoTreeDirectoryName", { fg = "#8ba4b0" })
set(0, "NeoTreeRootName", { fg = "#a292a3", bold = true }) -- Using the nice Kanagawa purple for the root
set(0, "NeoTreeGitAdded", { fg = "#8a9a7b" })
set(0, "NeoTreeGitModified", { fg = "#c4b28a" })
set(0, "NeoTreeGitDeleted", { fg = "#c4746e" })

-- fzf-lua (Replaces Telescope)
set(0, "FzfLuaBorder", { fg = "#393836" })
set(0, "FzfLuaCursorLine", { bg = "#282727" })
set(0, "FzfLuaNormal", { bg = "#181616" })

-- git signs
set(0, "GitSignsAdd", { fg = "#8a9a7b" })
set(0, "GitSignsChange", { fg = "#c4b28a" })
set(0, "GitSignsDelete", { fg = "#c4746e" })
