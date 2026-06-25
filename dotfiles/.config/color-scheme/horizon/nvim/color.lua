local set = vim.api.nvim_set_hl

vim.cmd("hi clear")

-- base
set(0, "Normal", { fg = "#D5D8DA", bg = "#1C1E26" })
set(0, "CursorLine", { bg = "#232530" })
set(0, "LineNr", { fg = "#44465B" })
set(0, "CursorLineNr", { fg = "#D5D8DA" })

-- syntax
set(0, "Comment", { fg = "#6C6F93", italic = true })
set(0, "String", { fg = "#29D398" })
set(0, "Function", { fg = "#26BBD9" })
set(0, "Keyword", { fg = "#E95678" })
set(0, "Type", { fg = "#FAC29A" })

-- diagnostics
set(0, "DiagnosticError", { fg = "#E95678" })
set(0, "DiagnosticWarn", { fg = "#FAC29A" })
set(0, "DiagnosticInfo", { fg = "#26BBD9" })
set(0, "DiagnosticHint", { fg = "#59E1E3" })

-- neo-tree
set(0, "NeoTreeNormal", { bg = "#1C1E26" })
set(0, "NeoTreeNormalNC", { bg = "#1C1E26" })
set(0, "NeoTreeDirectoryName", { fg = "#26BBD9" })
set(0, "NeoTreeRootName", { fg = "#E95678", bold = true })
set(0, "NeoTreeGitAdded", { fg = "#29D398" })
set(0, "NeoTreeGitModified", { fg = "#FAC29A" })
set(0, "NeoTreeGitDeleted", { fg = "#E95678" })

-- fzf-lua
set(0, "FzfLuaBorder", { fg = "#2E303E" })
set(0, "FzfLuaCursorLine", { bg = "#232530" })
set(0, "FzfLuaNormal", { bg = "#1C1E26" })

-- git signs
set(0, "GitSignsAdd", { fg = "#29D398" })
set(0, "GitSignsChange", { fg = "#FAC29A" })
set(0, "GitSignsDelete", { fg = "#E95678" })
