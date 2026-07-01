local set = vim.api.nvim_set_hl

vim.cmd("hi clear")

-- base
set(0, "Normal", { fg = "#FBD5AE", bg = "#012423" })
set(0, "CursorLine", { bg = "#023432" })
set(0, "LineNr", { fg = "#324440" })
set(0, "CursorLineNr", { fg = "#FBD5AE" })

-- syntax
set(0, "Comment", { fg = "#CCAF8B", italic = true })
set(0, "String", { fg = "#90B640" })
set(0, "Function", { fg = "#5EA89A" })
set(0, "Keyword", { fg = "#D4493F" })
set(0, "Type", { fg = "#E5B73E" })

-- diagnostics
set(0, "DiagnosticError", { fg = "#D4493F" })
set(0, "DiagnosticWarn", { fg = "#E5B73E" })
set(0, "DiagnosticInfo", { fg = "#3C7B80" })
set(0, "DiagnosticHint", { fg = "#5EA89A" })

-- neo-tree
set(0, "NeoTreeNormal", { bg = "#012423" })
set(0, "NeoTreeNormalNC", { bg = "#012423" })
set(0, "NeoTreeDirectoryName", { fg = "#3C7B80" })
set(0, "NeoTreeRootName", { fg = "#D4493F", bold = true })
set(0, "NeoTreeGitAdded", { fg = "#90B640" })
set(0, "NeoTreeGitModified", { fg = "#E5B73E" })
set(0, "NeoTreeGitDeleted", { fg = "#D4493F" })

-- fzf-lua
set(0, "FzfLuaBorder", { fg = "#435C56" })
set(0, "FzfLuaCursorLine", { bg = "#012423" })
set(0, "FzfLuaNormal", { bg = "#023432" })

-- git signs
set(0, "GitSignsAdd", { fg = "#90B640" })
set(0, "GitSignsChange", { fg = "#E5B73E" })
set(0, "GitSignsDelete", { fg = "#D4493F" })
