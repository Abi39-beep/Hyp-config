require("options")
require("color")
require("keymaps")

require("plugins.lazy")

--require("statusline")

vim.opt.spell = true
vim.opt.spelllang = "en"
vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"
