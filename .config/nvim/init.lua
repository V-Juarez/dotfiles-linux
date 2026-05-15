
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"  -- ← agrega esta línea

vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 0
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.showbreak = "↪ "

-- Configure Node.js before loading plugins
require("config.nodejs").setup({ silent = true })

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")


-- Cargar la configuración de Codeium
-- require("plugins.codeium")



