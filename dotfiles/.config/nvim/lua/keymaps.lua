local keymap = vim.keymap.set

vim.g.mapleader = " "

-- explorer
keymap("n", "<leader>e", ":NvimTreeToggle<CR>")

-- telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>")
keymap("n", "<leader>fg", ":Telescope live_grep<CR>")
keymap("n", "<leader>fb", ":Telescope buffers<CR>")

-- git
keymap("n", "<leader>gg", ":LazyGit<CR>")
