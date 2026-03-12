-- ================================================================================================
-- Statusline
-- ================================================================================================

local cached_branch = ""
local last_check = 0

local function git_branch()
    local now = vim.loop.now()
    if now - last_check > 5000 then
        cached_branch =
            vim.fn.system("git branch --show-current 2>/dev/null | tr -d '\n'")
        last_check = now
    end
    if cached_branch ~= "" then
        return "  " .. cached_branch .. " "
    end
    return ""
end

_G.git_branch = git_branch

vim.cmd([[
highlight StatusLineBold gui=bold
]])

vim.opt.statusline =
" %f %h%m%r %{v:lua.git_branch()} %= %l:%c %P "
