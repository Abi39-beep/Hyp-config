------------------------------------------------------------------------
-- 1. Git Branch Caching
------------------------------------------------------------------------
local cached_branch = ""
local last_check = 0

local function git_branch()
    local now = (vim.uv or vim.loop).now()
    if now - last_check > 5000 then
        local branch = vim.fn.system("git branch --show-current 2>/dev/null | tr -d '\n'")
        cached_branch = branch
        last_check = now
    end
    if cached_branch ~= "" then
        return "  " .. cached_branch .. " "
    end
    return ""
end

------------------------------------------------------------------------
-- 2. Theme Extraction & Auto-Updating Colors
------------------------------------------------------------------------
local function refresh_statusline_colors()
    -- Helper function to extract hex colors from current active highlight groups
    local function get_color(group, attr)
        local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
        if hl and hl[attr] then
            return string.format("#%06x", hl[attr])
        end
        return nil
    end

    local bg_dark = get_color("Normal", "bg") or "#0e1419"
    local fg_main = get_color("Normal", "fg") or "#e5e1cf"
    
    -- Extract the specific Background AND Foreground intended for the StatusLine
    local bg_bar  = get_color("StatusLine", "bg") or get_color("CursorLine", "bg") or "#243340"
    local fg_bar  = get_color("StatusLine", "fg") or fg_main 
    
    local blue   = get_color("Function", "fg") or "#36a3d9"
    local green  = get_color("String", "fg")   or "#b8cc52"
    local yellow = get_color("Type", "fg")     or "#e6c446"
    local red    = get_color("Keyword", "fg")  or "#f07078"
    local gray   = get_color("Comment", "fg")  or "#555555"

    local set = vim.api.nvim_set_hl

    -- Mode Colors
    set(0, "StModeNormal",  { bg = blue,   fg = bg_dark, bold = true })
    set(0, "StModeInsert",  { bg = green,  fg = bg_dark, bold = true })
    set(0, "StModeVisual",  { bg = yellow, fg = bg_dark, bold = true })
    set(0, "StModeCommand", { bg = red,    fg = bg_dark, bold = true })
    set(0, "StModeReplace", { bg = red,    fg = bg_dark, bold = true })

    -- Base Colors
    set(0, "StGit",  { bg = bg_bar, fg = gray })
    
    -- FIXED: We now use 'fg_bar' for the text color instead of 'fg_main'
    set(0, "StFile", { bg = bg_bar, fg = fg_bar, bold = true })
    
    set(0, "StFill", { bg = bg_bar, fg = bg_bar }) 
    set(0, "StPos",  { bg = gray,   fg = bg_dark, bold = true })
end
-- Run on startup and on every theme change
refresh_statusline_colors()
vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = refresh_statusline_colors,
})
------------------------------------------------------------------------
-- 3. Construct the entire Statusline dynamically
------------------------------------------------------------------------
function _G.ActiveStatusLine()
    local mode = vim.api.nvim_get_mode().mode
    local mode_map = {
        n       = { " NORMAL ",  "StModeNormal" },
        i       = { " INSERT ",  "StModeInsert" },
        v       = { " VISUAL ",  "StModeVisual" },
        V       = { " V-LINE ",  "StModeVisual" },
        ["\22"] = { " V-BLOCK ", "StModeVisual" },
        c       = { " COMMAND ", "StModeCommand" },
        R       = { " REPLACE ", "StModeReplace" },
    }
    
    local m = mode_map[mode] or { " " .. mode .. " ", "StModeNormal" }
    local mode_hl = "%#" .. m[2] .. "#"
    local mode_text = m[1]

    return table.concat({
        mode_hl, mode_text,        -- Colored Mode
        "%#StGit#", git_branch(),  -- Git Branch
        "%#StFile#", " %f %m%r ",  -- File Path & modified flags
        
        "%#StFill#", "%=",         -- Middle fill & Right Align
        
        -- UPDATED SECTION: Added %P for the Top/Bot/55% indicator
        "%#StPos#", " %P | %l:%c " -- Percentage | Line:Column
    })
end

vim.opt.statusline = "%!v:lua.ActiveStatusLine()"
