require("options")
require("color")
require("keymaps")

require("plugins.lazy")

--require("statusline")

vim.opt.spell = true
vim.opt.spelllang = "en"
vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"

--Turn on English dictionary and spell-check for documents
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown", "txt", "text" },
    callback = function()
        vim.opt_local.spell = true --Enable spell checking
        vim.opt_local.spelllang = "en_us"
    end,
})
