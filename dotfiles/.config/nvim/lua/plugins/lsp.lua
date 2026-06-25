return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "ibhagwan/fzf-lua",
    },
    config = function()
        -- 🚨 CRUCIAL: You MUST require lspconfig to load the :LspInfo command
        -- and to inject community servers (like qmlls) into Neovim 0.12's native API.
        require("lspconfig")

        require("mason").setup()
        require("mason-lspconfig").setup({
            -- ADDED "qmlls" HERE so Mason actually downloads it
            ensure_installed = { "lua_ls", "ts_ls", "cssls", "rust_analyzer", "qmlls" },
        })

        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local fzf = require("fzf-lua")

        -- === LUA LSP ===
        vim.lsp.config("lua_ls", {
            capabilities = capabilities,
            settings = {
                Lua = {
                    diagnostics = { globals = { "vim", "ags" } },
                },
            },
        })
        vim.lsp.enable("lua_ls")

        -- === TYPESCRIPT / JAVASCRIPT LSP ===
        vim.lsp.config("ts_ls", {
            capabilities = capabilities,
        })
        vim.lsp.enable("ts_ls")

        -- === CSS / SCSS LSP ===
        vim.lsp.config("cssls", {
            capabilities = capabilities,
        })
        vim.lsp.enable("cssls")

        -- === RUST LSP ===
        vim.lsp.config("rust_analyzer", {
            capabilities = capabilities,
            settings = {
                ["rust-analyzer"] = {
                    check = {
                        command = "clippy",
                    },
                },
            },
        })
        vim.lsp.enable("rust_analyzer")

        -- === QML LSP ===
        vim.lsp.config("qmlls", {
            capabilities = capabilities,
            -- Add the '-I' flag to tell it where Arch Linux stores QML modules!
            cmd = {
                "/usr/lib/qt6/bin/qmlls",
                "-I", "/usr/lib/qt6/qml"
            },
            on_init = function(client)
                client.server_capabilities.semanticTokensProvider = nil
            end,
            handlers = {
                ["textDocument/semanticTokens/full"] = function() end,
                ["textDocument/semanticTokens/full/delta"] = function() end,
            },
        })
        vim.lsp.enable("qmlls")

        -- Universal LSP Keybinds (Triggers when an LSP attaches to a buffer)
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                local opts = { buffer = ev.buf, silent = true }

                -- Integrate Fzf-Lua beautifully with your LSP
                vim.keymap.set("n", "gd", fzf.lsp_definitions, { desc = "Go to Definition", buffer = ev.buf })
                vim.keymap.set("n", "gr", fzf.lsp_references, { desc = "Go to References", buffer = ev.buf })
                vim.keymap.set("n", "gI", fzf.lsp_implementations, { desc = "Go to Implementation", buffer = ev.buf })
                vim.keymap.set("n", "<leader>ca", fzf.lsp_code_actions, { desc = "Code Actions", buffer = ev.buf })
                vim.keymap.set("n", "<leader>fd", fzf.lsp_document_diagnostics,
                    { desc = "Document Diagnostics", buffer = ev.buf })

                -- Standard LSP functions
                vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation", buffer = ev.buf })
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol", buffer = ev.buf })
            end,
        })

        -- Configure diagnostic symbols in the gutter
        local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end
    end,
}
