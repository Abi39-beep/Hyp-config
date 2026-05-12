local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    require("plugins.neo-tree"),
    require("plugins.gitsigns"),
    require("plugins.lazygit"),
    require("plugins.lualine"),
    require("plugins.fzf-lua"),
    require("plugins.autocompletion"),
    require("plugins.lsp"),
    require("plugins.formatting"),
})
