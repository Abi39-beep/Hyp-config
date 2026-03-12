local set = vim.api.nvim_set_hl

vim.cmd("hi clear")

-- base
set(0, "Normal", { fg = "#D3C6AA", bg = "#2D353B" })
set(0, "CursorLine", { bg = "#343F44" })
set(0, "LineNr", { fg = "#7A8478" })
set(0, "CursorLineNr", { fg = "#D3C6AA" })

-- syntax
set(0, "Comment", { fg = "#859289", italic = true })
set(0, "String", { fg = "#A7C080" })
set(0, "Function", { fg = "#A7C080" })
set(0, "Keyword", { fg = "#E67E80" })
set(0, "Type", { fg = "#DBBC7F" })

-- diagnostics
set(0, "DiagnosticError", { fg = "#E67E80" })
set(0, "DiagnosticWarn", { fg = "#DBBC7F" })
set(0, "DiagnosticInfo", { fg = "#7FBBB3" })
set(0, "DiagnosticHint", { fg = "#A7C080" })

-- tree
set(0, "NvimTreeNormal", { bg = "#2D353B" })
set(0, "NvimTreeFolderName", { fg = "#7FBBB3" })

-- telescope
set(0, "TelescopeBorder", { fg = "#3D484D" })
set(0, "TelescopeSelection", { bg = "#343F44" })

-- git signs
set(0, "GitSignsAdd", { fg = "#A7C080" })
set(0, "GitSignsChange", { fg = "#DBBC7F" })
set(0, "GitSignsDelete", { fg = "#E67E80" })
