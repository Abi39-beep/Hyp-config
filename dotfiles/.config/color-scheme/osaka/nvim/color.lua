local set = vim.api.nvim_set_hl

vim.cmd("hi clear")

-- base
set(0, "Normal", { fg = "#839395", bg = "#001a1f" })
set(0, "CursorLine", { bg = "#003842" })
set(0, "LineNr", { fg = "#587175" })
set(0, "CursorLineNr", { fg = "#839395" })

-- syntax
set(0, "Comment", { fg = "#587175", italic = true })
set(0, "String", { fg = "#869900" })
set(0, "Function", { fg = "#278bd2" })
set(0, "Keyword", { fg = "#d53683" })
set(0, "Type", { fg = "#b28700" })

-- diagnostics
set(0, "DiagnosticError", { fg = "#de322e" })
set(0, "DiagnosticWarn", { fg = "#b28700" })
set(0, "DiagnosticInfo", { fg = "#278bd2" })
set(0, "DiagnosticHint", { fg = "#2a9f97" })

-- tree
set(0, "NvimTreeNormal", { bg = "#001a1f" })
set(0, "NvimTreeFolderName", { fg = "#278bd2" })

-- telescope
set(0, "TelescopeBorder", { fg = "#07404a" })
set(0, "TelescopeSelection", { bg = "#003842" })

-- git signs
set(0, "GitSignsAdd", { fg = "#869900" })
set(0, "GitSignsChange", { fg = "#b28700" })
set(0, "GitSignsDelete", { fg = "#de322e" })
