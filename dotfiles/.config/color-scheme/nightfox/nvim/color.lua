local set = vim.api.nvim_set_hl

vim.cmd("hi clear")

-- base
set(0, "Normal", { fg = "#cdcecf", bg = "#192330" })
set(0, "CursorLine", { bg = "#2b3b51" })
set(0, "LineNr", { fg = "#575860" })
set(0, "CursorLineNr", { fg = "#cdcecf" })

-- syntax
set(0, "Comment", { fg = "#575860", italic = true })
set(0, "String", { fg = "#81b29a" })
set(0, "Function", { fg = "#719cd6" })
set(0, "Keyword", { fg = "#9d79d6" })
set(0, "Type", { fg = "#dbc074" })

-- diagnostics
set(0, "DiagnosticError", { fg = "#c94f6d" })
set(0, "DiagnosticWarn", { fg = "#dbc074" })
set(0, "DiagnosticInfo", { fg = "#719cd6" })
set(0, "DiagnosticHint", { fg = "#63cdcf" })

-- neo-tree (Replaces NvimTree)
set(0, "NeoTreeNormal", { bg = "#192330" })
set(0, "NeoTreeNormalNC", { bg = "#192330" })
set(0, "NeoTreeDirectoryName", { fg = "#719cd6" })
set(0, "NeoTreeRootName", { fg = "#9d79d6", bold = true }) -- Nightfox purple for the root
set(0, "NeoTreeGitAdded", { fg = "#81b29a" })
set(0, "NeoTreeGitModified", { fg = "#dbc074" })
set(0, "NeoTreeGitDeleted", { fg = "#c94f6d" })

-- fzf-lua (Replaces Telescope)
set(0, "FzfLuaBorder", { fg = "#393b44" })
set(0, "FzfLuaCursorLine", { bg = "#2b3b51" })
set(0, "FzfLuaNormal", { bg = "#192330" })

-- git signs
set(0, "GitSignsAdd", { fg = "#81b29a" })
set(0, "GitSignsChange", { fg = "#dbc074" })
set(0, "GitSignsDelete", { fg = "#c94f6d" })
