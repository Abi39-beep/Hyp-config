return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local fzf = require("fzf-lua")

        -- Setup FZF to look clean and use your color.lua borders
        fzf.setup({
            winopts = {
                border = "rounded",
            },
        })

        -- 1. Standard FZF keymaps
        vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "Fzf Files" })
        vim.keymap.set("n", "<leader>fg", fzf.live_grep, { desc = "Fzf Live Grep" })
        vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "Fzf Buffers" })

        -- 2. ZOXIDE INTEGRATION
        -- This uses FZF's UI to fuzzy search through your Zoxide history
        vim.keymap.set("n", "<leader>z", function()
            vim.keymap.set("n", "z=", fzf.spell.suggest, { desc = "Spelling Suggestions" })
            fzf.fzf_exec("zoxide query -l", {
                prompt = "Zoxide ❯ ",
                actions = {
                    ["default"] = function(selected)
                        -- Triggered when you hit Enter on a directory
                        if selected and #selected > 0 then
                            local dir = selected[1]
                            -- Change neovim's directory (fnameescape handles paths with spaces)
                            vim.cmd("cd " .. vim.fn.fnameescape(dir))
                            print("Changed directory to: " .. dir)

                            -- Optional: automatically open neo-tree in the new directory
                            vim.cmd("Neotree dir=" .. vim.fn.fnameescape(dir))
                        end
                    end
                }
            })
        end, { desc = "Zoxide via FZF" })
    end,
}
