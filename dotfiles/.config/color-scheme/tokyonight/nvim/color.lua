local set = vim.api.nvim_set_hl

vim.cmd("hi clear")

-- base
set(0, "Normal", { fg = "#c0caf5", bg = "#1a1b26" })
set(0, "CursorLine", { bg = "#292e42" })
set(0, "LineNr", { fg = "#3b4261" })
set(0, "CursorLineNr", { fg = "#c0caf5" })

-- syntax
set(0, "Comment", { fg = "#565f89", italic = true })
set(0, "String", { fg = "#9ece6a" })
set(0, "Function", { fg = "#7aa2f7" })
set(0, "Keyword", { fg = "#bb9af7" })
set(0, "Type", { fg = "#2ac3de" })

-- diagnostics
set(0, "DiagnosticError", { fg = "#f7768e" })
set(0, "DiagnosticWarn", { fg = "#e0af68" })
set(0, "DiagnosticInfo", { fg = "#7aa2f7" })
set(0, "DiagnosticHint", { fg = "#1abc9c" })

-- tree
set(0, "NvimTreeNormal", { bg = "#16161e" })
set(0, "NvimTreeFolderName", { fg = "#7aa2f7" })

-- telescope
set(0, "TelescopeBorder", { fg = "#292e42" })
set(0, "TelescopeSelection", { bg = "#292e42" })

-- git signs
set(0, "GitSignsAdd", { fg = "#9ece6a" })
set(0, "GitSignsChange", { fg = "#e0af68" })
set(0, "GitSignsDelete", { fg = "#f7768e" })
