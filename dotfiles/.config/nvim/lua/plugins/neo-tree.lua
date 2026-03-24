return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", 
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true, -- Close Neo-tree if it is the last window left
      popup_border_style = "rounded",
      window = {
        position = "left",
        width = 30,
      },
      filesystem = {
        follow_current_file = { enabled = true }, -- Highlight the current file in the tree
        use_libuv_file_watcher = true,            -- Auto-update tree when files change externally
        filtered_items = {
          visible = true, -- Show hidden files slightly dimmed
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
    })

    -- Map <leader>e to toggle the file explorer
    vim.keymap.set("n", "<leader>e", "<Cmd>Neotree toggle<CR>", { desc = "Toggle Neo-tree" })
  end,
}
