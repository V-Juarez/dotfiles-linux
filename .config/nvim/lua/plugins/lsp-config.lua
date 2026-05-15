-- return {
--
--     {
--         "mason-org/mason.nvim",
--         config = function()
--             -- setup mason with default properties
--             require("mason").setup()
--         end
--     },
--     -- mason lsp config utilizes mason to automatically ensure lsp servers you want installed are installed
--     {
--         "mason-org/mason.nvim",
--         config = function()
--             -- ensure that we have lua language server, typescript launguage server, java language server, and java test language server are installed
--             require("williamboman/mason-lspconfig.nvim").setup({
--                 ensure_installed = { "lua_ls", "ts_ls", "jdtls" },
--             })
--         end
--     },
--     -- mason nvim dap utilizes mason to automatically ensure debug adapters you want installed are installed, mason-lspconfig will not automatically install debug adapters for us
--     {
--         "jay-babu/mason-nvim-dap.nvim",
--         config = function()
--             -- ensure the java debug adapter is installed
--             require("mason-nvim-dap").setup({
--                 ensure_installed = { "java-debug-adapter", "java-test" }
--             })
--         end
--     },
--     -- utility plugin for configuring the java language server for us
--     {
--         "mfussenegger/nvim-jdtls",
--         dependencies = {
--             "mfussenegger/nvim-dap",
--         }
--     },
--     {
--         "neovim/nvim-lspconfig",
--         config = function()
--             -- get access to the lspconfig plugins functions
--             local lspconfig = require("lspconfig")
--
--             local capabilities = require("cmp_nvim_lsp").default_capabilities()
--
--             -- setup the lua language server
--             lspconfig.lua_ls.setup({
--                 capabilities = capabilities,
--             })
--
--             -- setup the typescript language server
--             lspconfig.tsserver.setup({
--                 capabilities = capabilities,
--             })
--
--             -- Set vim motion for <Space> + c + h to show code documentation about the code the cursor is currently over if available
--             vim.keymap.set("n", "<leader>ch", vim.lsp.buf.hover, { desc = "[C]ode [H]over Documentation" })
--             -- Set vim motion for <Space> + c + d to go where the code/variable under the cursor was defined
--             vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, { desc = "[C]ode Goto [D]efinition" })
--             -- Set vim motion for <Space> + c + a for display code action suggestions for code diagnostics in both normal and visual mode
--             vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ctions" })
--             -- Set vim motion for <Space> + c + r to display references to the code under the cursor
--             vim.keymap.set("n", "<leader>cr", require("telescope.builtin").lsp_references,
--                 { desc = "[C]ode Goto [R]eferences" })
--             -- Set vim motion for <Space> + c + i to display implementations to the code under the cursor
--             vim.keymap.set("n", "<leader>ci", require("telescope.builtin").lsp_implementations,
--                 { desc = "[C]ode Goto [I]mplementations" })
--             -- Set a vim motion for <Space> + c + <Shift>R to smartly rename the code under the cursor
--             vim.keymap.set("n", "<leader>cR", vim.lsp.buf.rename, { desc = "[C]ode [R]ename" })
--             -- Set a vim motion for <Space> + c + <Shift>D to go to where the code/object was declared in the project (class file)
--             vim.keymap.set("n", "<leader>cD", vim.lsp.buf.declaration, { desc = "[C]ode Goto [D]eclaration" })
--         end
--     }
-- }
--
--



return {
    -- mason principal
    {
        "mason-org/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    -- mason-lspconfig
    {
        "mason-org/mason-lspconfig.nvim",  -- ✅ nombre correcto del spec
        dependencies = { "mason-org/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({  -- ✅ require correcto
                ensure_installed = { "lua_ls", "ts_ls", "jdtls" },
            })
        end
    },
    -- mason-nvim-dap
    {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = { "mason-org/mason.nvim" },
        config = function()
            require("mason-nvim-dap").setup({
                ensure_installed = { "java-debug-adapter", "java-test" }
            })
        end
    },
    -- nvim-jdtls
    {
        "mfussenegger/nvim-jdtls",
        dependencies = { "mfussenegger/nvim-dap" }
    },
    -- nvim-lspconfig
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "mason-org/mason.nvim",
            "mason-org/mason-lspconfig.nvim",
        },
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            lspconfig.lua_ls.setup({ capabilities = capabilities })

            -- ✅ tsserver fue renombrado a ts_ls en versiones recientes
            lspconfig.ts_ls.setup({ capabilities = capabilities })

            vim.keymap.set("n", "<leader>ch", vim.lsp.buf.hover, { desc = "[C]ode [H]over Documentation" })
            vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, { desc = "[C]ode Goto [D]efinition" })
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ctions" })
            vim.keymap.set("n", "<leader>cr", require("telescope.builtin").lsp_references, { desc = "[C]ode Goto [R]eferences" })
            vim.keymap.set("n", "<leader>ci", require("telescope.builtin").lsp_implementations, { desc = "[C]ode Goto [I]mplementations" })
            vim.keymap.set("n", "<leader>cR", vim.lsp.buf.rename, { desc = "[C]ode [R]ename" })
            vim.keymap.set("n", "<leader>cD", vim.lsp.buf.declaration, { desc = "[C]ode Goto [D]eclaration" })
        end
    }
}
