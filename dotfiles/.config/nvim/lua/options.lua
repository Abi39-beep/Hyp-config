-- Alias vim.opt to opt for cleaner code
local opt = vim.opt
local g = vim.g

-----------------------------------------------------------
-- General
-----------------------------------------------------------
-- Set leader keys (It's best practice to set this before loading plugins)
g.mapleader = " "       -- Set leader key to space
g.maplocalleader = " "  -- Set local leader key to space

opt.mouse = "a"         -- Enable mouse support in all modes
opt.clipboard = "unnamedplus" -- Sync Neovim clipboard with the system clipboard

-----------------------------------------------------------
-- UI & Appearance
-----------------------------------------------------------
opt.termguicolors = true  -- Enable 24-bit RGB colors (Crucial for modern colorschemes)
opt.number = true         -- Show absolute line numbers
opt.relativenumber = true -- Show relative line numbers (great for jumping with j/k)
opt.cursorline = true     -- Highlight the current line
opt.signcolumn = "yes"    -- Always show the signcolumn (prevents text shifting from diagnostics)
opt.wrap = false          -- Disable line wrapping
opt.showmode = false      -- Don't show mode in command line (statusline plugins do this anyway)
opt.cmdheight = 1         -- Height of the command prompt (can set to 0 to hide)

-----------------------------------------------------------
-- Navigation & Scrolling
-----------------------------------------------------------
opt.scrolloff = 8         -- Keep 8 lines above/below the cursor when scrolling
opt.sidescrolloff = 8     -- Keep 8 columns left/right of the cursor when scrolling horizontally

-----------------------------------------------------------
-- Tabs & Indentation
-----------------------------------------------------------
opt.tabstop = 4           -- Number of spaces a <Tab> counts for
opt.shiftwidth = 4        -- Number of spaces to use for each step of (auto)indent
opt.expandtab = true      -- Convert tabs to spaces
opt.autoindent = true     -- Copy indent from current line when starting a new one
opt.smartindent = true    -- Make indenting smarter (adds indent after '{', etc.)

-----------------------------------------------------------
-- Search
-----------------------------------------------------------
opt.ignorecase = true     -- Ignore case when searching
opt.smartcase = true      -- Override ignorecase if search contains a capital letter
opt.incsearch = true      -- Show search matches as you type
opt.hlsearch = false      -- Don't keep search terms highlighted after pressing Enter

-----------------------------------------------------------
-- Window Splitting
-----------------------------------------------------------
opt.splitbelow = true     -- Horizontal splits open below the current window
opt.splitright = true     -- Vertical splits open to the right of the current window

-----------------------------------------------------------
-- Backup & Undo
-----------------------------------------------------------
opt.swapfile = false      -- Don't create swap files
opt.backup = false        -- Don't create backup files
opt.undofile = true       -- Save undo history to a file (allows undoing after closing Neovim)

-----------------------------------------------------------
-- Timings & Performance
-----------------------------------------------------------
opt.updatetime = 250      -- Decrease update time (default 4000ms). Faster git signs & completion.
opt.timeoutlen = 300      -- Time to wait for a mapped key sequence to complete (in milliseconds)

-----------------------------------------------------------
-- Autocomplete & Text behavior
-----------------------------------------------------------
opt.completeopt = { "menu", "menuone", "noselect" } -- Recommended settings for nvim-cmp
opt.iskeyword:append("-") -- Treat dash-separated words as a single word (useful for CSS/HTML)
